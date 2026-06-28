pragma Singleton

import QtQuick
import Quickshell
import Quickshell.Services.Mpris

/**
 * Shared now-playing source. Picks the player the user last commanded, the one
 * whose play or pause state changed most recently, which is the same player
 * playerctld routes the media keys to, so the media surface and the keybinds
 * never disagree on which player they mean. The playerctld aggregator proxy is
 * dropped from the candidates and from the recency watch. Until something is
 * touched it falls back to the first playing, then the first track-bearing
 * player.
 */
Singleton {
    id: root

    /** dbusName of the player whose playback state changed most recently. */
    property string lastTouched: ""

    function anyOtherPlaying(self) {
        var l = root.list;
        for (var i = 0; i < l.length; i++)
            if (l[i] !== self && l[i].isPlaying)
                return true;
        return false;
    }

    /** The playerctld aggregator mirrors the others, so it must not double-count. */
    function isProxy(p) {
        return (p.dbusName || "").toLowerCase().indexOf("playerctld") >= 0;
    }

    /** Real players only, the playerctld proxy left out. */
    readonly property var list: {
        var all = Mpris.players.values;
        var out = [];
        for (var i = 0; i < all.length; i++) {
            var p = all[i];
            if (p && !isProxy(p))
                out.push(p);
        }
        return out;
    }

    /** The player to show and control. */
    readonly property var active: {
        var l = root.list;
        if (l.length === 0)
            return null;
        if (root.lastTouched) {
            for (var i = 0; i < l.length; i++)
                if (l[i].dbusName === root.lastTouched)
                    return l[i];
        }
        var withTrack = null;
        for (var j = 0; j < l.length; j++) {
            var p = l[j];
            if (p.isPlaying)
                return p;
            if (!withTrack && p.trackTitle && p.trackTitle.length > 0)
                withTrack = p;
        }
        return withTrack ? withTrack : l[0];
    }

    /**
     * Mark the last-commanded player. A play or pause moves the player's
     * playbackState, and the binding only re-fires on real changes (not on
     * delegate creation), so a freshly seen player never steals focus on its
     * own. A player that starts while another is already playing is left alone,
     * so a background tab autoplaying can't grab the surface off your music; a
     * pause always counts, since pausing is something you did on purpose. The
     * proxy is held at a constant so its mirrored state never fires.
     */
    Instantiator {
        model: Mpris.players
        delegate: QtObject {
            id: watch
            required property var modelData
            readonly property int pbState: (watch.modelData && !Players.isProxy(watch.modelData)) ? watch.modelData.playbackState : -1
            onPbStateChanged: {
                var p = watch.modelData;
                if (!p || Players.isProxy(p))
                    return;
                if (p.isPlaying && Players.anyOtherPlaying(p))
                    return;
                Players.lastTouched = p.dbusName;
            }
        }
    }
}
