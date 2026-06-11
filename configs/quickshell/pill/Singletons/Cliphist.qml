pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

/**
 * cliphist bridge — keeps a warm in-memory snapshot of the clipboard history so
 * the clipboard surface opens instantly instead of shelling out on demand. A
 * wl-paste watcher fires on every clipboard change; after a short debounce the
 * thumbnail script regenerates missing image previews (and prunes stale ones),
 * then `cliphist list` is re-read into `entries`. Thumbnails are written before
 * the list lands so image delegates never bind to a not-yet-existing file.
 *
 * Entries are plain objects: { id, preview, isImage, meta, thumb } where meta
 * is the human-readable binary descriptor ("245 KiB png 1920x1080") and thumb
 * the absolute path of the cached preview png (empty for text).
 */
Singleton {
    id: root

    property var entries: []
    readonly property int count: entries.length

    readonly property string thumbDir: (Quickshell.env("XDG_CACHE_HOME") || (Quickshell.env("HOME") + "/.cache")) + "/cliphist-thumbs/"
    readonly property string thumbScript: Quickshell.env("HOME") + "/.config/hypr/scripts/cliphist-thumbs.sh"

    function refresh() {
        if (!thumbProc.running && !listProc.running)
            thumbProc.running = true;
    }

    function copy(entry) {
        if (!/^\d+$/.test(String(entry.id)))
            return;
        Quickshell.execDetached(["sh", "-c", "printf '%s' '" + entry.id + "' | cliphist decode | wl-copy"]);
    }

    function remove(entry) {
        if (!/^\d+$/.test(String(entry.id)))
            return;
        Quickshell.execDetached(["sh", "-c", "printf '%s' '" + entry.id + "' | cliphist delete"]);
        var kept = [];
        for (var i = 0; i < entries.length; i++)
            if (entries[i].id !== entry.id)
                kept.push(entries[i]);
        entries = kept;
    }

    Process {
        id: watchProc
        command: ["wl-paste", "--watch", "echo", "x"]
        running: true
        stdout: SplitParser {
            onRead: debounce.restart()
        }
    }

    Timer {
        id: debounce
        interval: 300
        onTriggered: root.refresh()
    }

    Process {
        id: thumbProc
        command: ["sh", root.thumbScript]
        onExited: listProc.running = true
    }

    Process {
        id: listProc
        command: ["cliphist", "list"]
        stdout: StdioCollector {
            onStreamFinished: {
                var lines = this.text.split("\n");
                var out = [];
                var metaRe = /\[\[ binary data (.*) \]\]/;
                var imgRe = /\b(png|jpg|jpeg|gif|bmp|webp)\b/;
                for (var i = 0; i < lines.length; i++) {
                    var line = lines[i];
                    var tab = line.indexOf("\t");
                    if (tab < 1)
                        continue;
                    var id = line.substring(0, tab);
                    if (!/^\d+$/.test(id))
                        continue;
                    var preview = line.substring(tab + 1);
                    var m = metaRe.exec(preview);
                    var isImage = m !== null && imgRe.test(m[1]);
                    out.push({
                        id: id,
                        preview: preview,
                        isImage: isImage,
                        meta: isImage ? m[1] : "",
                        thumb: isImage ? root.thumbDir + id + ".png" : ""
                    });
                }
                root.entries = out;
            }
        }
    }

    Component.onCompleted: refresh()
}
