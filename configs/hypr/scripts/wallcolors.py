#!/usr/bin/env python3
"""
Analyse wallpaper, call matugen to render every colour template, then render
the fastfetch config (needs r;g;b from hex which matugen templates can't do).
"""
import colorsys
import json
import re
import subprocess
import sys
from pathlib import Path

CACHE = Path.home() / ".cache" / "ricelin"


def analyze(wallpaper):
    out = subprocess.run(
        ["magick", wallpaper, "-alpha", "off", "-resize", "200x200", "-colors", "48",
         "-format", "%c", "histogram:info:-"],
        capture_output=True, text=True).stdout
    buckets, total, lum, chroma = {}, 0, 0.0, 0
    for line in out.splitlines():
        m = re.search(r"\s*(\d+):\s*\([^)]*\)\s*#([0-9A-Fa-f]{6})", line)
        if not m:
            continue
        count, hex_str = int(m.group(1)), m.group(2)
        r, g, b = (int(hex_str[i:i + 2], 16) / 255 for i in (0, 2, 4))
        h, lightness, s = colorsys.rgb_to_hls(r, g, b)
        total += count
        lum += count * lightness
        if s < 0.15 or lightness < 0.05 or lightness > 0.92:
            continue
        chroma += count
        bucket = buckets.setdefault((int(h * 360) // 30) % 12, {"wsat": 0.0, "best": None})
        bucket["wsat"] += count * s
        score = count * s * (1 if 0.12 < lightness < 0.55 else 0.4)
        if not bucket["best"] or score > bucket["best"][0]:
            bucket["best"] = (score, h, s)
    mean_l = lum / total if total else 0.0
    if not buckets or chroma < 0.08 * total:
        return None, 0.0, mean_l
    win = max(buckets.values(), key=lambda v: v["wsat"])
    return win["best"][1], win["best"][2], mean_l


def hex_to_rgb(h):
    h = h.lstrip("#")
    return tuple(int(h[i:i + 2], 16) / 255 for i in (0, 2, 4))


def render_fastfetch(scheme):
    ff = Path.home() / ".config" / "fastfetch"
    tmpl = ff / "config.jsonc.in"
    if not tmpl.is_file():
        return

    def seq(c):
        return "%d;%d;%d" % tuple(round(x * 255) for x in hex_to_rgb(c))

    pill = {
        "__PRIMARY__":             scheme["primary"],
        "__DIM__":                 scheme.get("outline", scheme["on_surface_variant"]),
        "__ON_PRIMARY_CONTAINER__": scheme.get("on_primary_container", scheme.get("on_primary", "#ffffff")),
        "__SURFACE_CONTAINER__":   scheme.get("surface_container", scheme.get("surface_variant", scheme["surface"])),
        "__SURFACE_CONTAINER_HIGH__": scheme.get("surface_container_high", scheme.get("surface_container", scheme["surface"])),
        "__SUBTLE__":              scheme.get("on_surface_variant", scheme["on_surface"]),
        "__OUTLINE__":             scheme.get("outline", scheme.get("on_surface_variant", scheme["on_surface"])),
        "__BRIGHT__":              scheme["on_surface"],
    }
    repl = {
        "__LANTERN__": str(ff / "lantern.txt"),
        "__KEYS__": seq(pill["__PRIMARY__"]),
        "__SEP__":  seq(pill["__DIM__"]),
        "__LOGO1__": seq(pill["__PRIMARY__"]),
        "__LOGO2__": seq(pill["__ON_PRIMARY_CONTAINER__"]),
        "__LOGO3__": seq(pill["__SURFACE_CONTAINER__"]),
        "__LOGO4__": seq(pill["__SURFACE_CONTAINER_HIGH__"]),
        "__LOGO5__": seq(pill["__SUBTLE__"]),
        "__LOGO6__": seq(pill["__OUTLINE__"]),
        "__LOGO7__": seq(pill["__BRIGHT__"]),
    }
    out = tmpl.read_text()
    for key, val in repl.items():
        out = out.replace(key, val)
    (ff / "config.jsonc").write_text(out)


def main():
    if len(sys.argv) < 2:
        return 1
    if sys.argv[1] == "--hue":
        hue = (float(sys.argv[2]) % 360) / 360.0
        mode = sys.argv[3] if len(sys.argv) > 3 else "dark"
        sat = float(sys.argv[4]) if len(sys.argv) > 4 else 0.5
        sat = max(0.0, min(1.0, sat))
        r, g, b = colorsys.hls_to_rgb(hue % 1.0, 0.45, max(0.02, sat))
        source_hex = "#%02x%02x%02x" % (round(r * 255), round(g * 255), round(b * 255))
        matugen_args = ["matugen", "color", "hex", source_hex, "-m", mode]
    else:
        wallpaper = sys.argv[1]
        if not Path(wallpaper).is_file():
            return 0
        hue, sat, mean_l = analyze(wallpaper)
        if hue is None:
            hue, sat = 0.09, 0.0
        mode = "light" if mean_l >= 0.40 else "dark"
        matugen_args = ["matugen", "image", wallpaper, "-m", mode]
    CACHE.mkdir(parents=True, exist_ok=True)
    # Write mode for KDE post_hook (runs during matugen call below)
    (CACHE / "kde-mode.txt").write_text(mode)

    try:
        out = subprocess.run(matugen_args + ["-j", "hex"],
                             capture_output=True, text=True, check=True)
        stdout = out.stdout
        brace = stdout.rfind("}")
        if brace >= 0:
            stdout = stdout[:brace + 1]
        data = json.loads(stdout)
        colors = {k: v[mode]["color"] for k, v in data["colors"].items()}
    except (OSError, ValueError, KeyError, subprocess.SubprocessError):
        try:
            out = subprocess.run(
                ["matugen", "color", "hex", "#ffbf9b", "-m", "dark", "-j", "hex"],
                capture_output=True, text=True, check=True,
            )
            stdout = out.stdout
            brace = stdout.rfind("}")
            if brace >= 0:
                stdout = stdout[:brace + 1]
            data = json.loads(stdout)
            colors = {k: v["dark"]["color"] for k, v in data["colors"].items()}
        except (OSError, ValueError, KeyError, subprocess.SubprocessError):
            return 0

    render_fastfetch(colors)

    # Switch GTK/appearance mode
    if mode == "light":
        subprocess.run(["gsettings", "set", "org.gnome.desktop.interface",
                        "color-scheme", "prefer-light"],
                       capture_output=True)
    else:
        subprocess.run(["gsettings", "set", "org.gnome.desktop.interface",
                        "color-scheme", "prefer-dark"],
                       capture_output=True)

    return 0


if __name__ == "__main__":
    sys.exit(main())
