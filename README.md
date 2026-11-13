# Quake console

This repo installs Omarchy's drop-down console: the Foot agent window (`org.omarchy.agent`) with Quake letter shapes, on the current Omarchy theme. The panel is full width, about 70% of the work area tall, and slightly see-through. The Quake face is 18px; glyphs the sheet does not include fall back to JetBrains Mono. Copy-paste selection is a gray that keeps those outlined letters readable. Other Foot windows keep the normal theme.

## Prerequisites

- An Omarchy machine with Hyprland, and an existing `~/.config/hypr/hyprland.lua`. `./install` exits if that file is missing.
- `bash`, `python3`, `install` (coreutils), and `fc-cache` (fontconfig).
- `foot` on `PATH`. The console config includes `~/.config/foot/foot.ini` and names `JetBrainsMono Nerd Font` as the fallback face.
- A live Hyprland session is optional. If `hyprctl` is on `PATH` and `HYPRLAND_INSTANCE_SIGNATURE` is set, the installer reloads Hyprland.

## Install

There is no build step. From this directory:

```bash
./install
```

The script is safe to run again. It copies files into `~/.local` and `~/.config` and does not remove them. It appends `require("hypr.quake")` to `~/.config/hypr/hyprland.lua` when that line is absent, and drops an older inline Quake block if one is still there.

There is no test suite. Syntax-check the scripts with:

```bash
bash -n ./install
bash -n ./bin/omarchy-foot-launch
```

## Use

Reopen the console with Super+`.

`xdg-terminal-exec` launches Foot through `~/.local/bin/omarchy-foot-launch` (`omarchy-foot.desktop`). The wrapper loads `~/.config/foot/quake.ini` and sets `GROK_THEME=groknight` only when the arguments include `--app-id=org.omarchy.agent`.

Installed paths:

- `~/.local/share/fonts/QuakeConsole/QuakeConsole.ttf` and `COPYING`
- `~/.config/foot/quake.ini`
- `~/.local/bin/omarchy-foot-launch`
- `~/.local/share/applications/omarchy-foot.desktop`
- `~/.config/hyprland-xdg-terminals.list`
- `~/.config/hypr/quake.lua`

## Layout

```
install
applications/omarchy-foot.desktop.in
bin/omarchy-foot-launch
font/QuakeConsole.ttf
font/COPYING
foot/quake.ini
hypr/hyprland-xdg-terminals.list
hypr/quake.lua
```

The letter shapes come from LibreQuake's console sheet, `lq1/gfx-wad/CONCHARS.png`, under the 3-clause BSD license. See [font/COPYING](font/COPYING). Keep that notice with the font file.
