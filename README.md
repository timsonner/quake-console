# Quake console

The Omarchy drop-down console, with the Quake letter shapes, at a size that fills the screen, on the current Omarchy theme.

What you get:

- The QuakeConsole face at 18px. Icons the sheet does not include fall back to JetBrains Mono.
- GrokNight in the agent window. Other Foot windows keep the normal theme.
- A full-width panel, about 70% of the screen tall, slightly see-through.
- Copy-paste selection in GrokNight gray, so the letters stay readable.

## Install

On an Omarchy machine, from this directory:

```bash
./install
```

Then reopen the console with Super+`. The script is safe to run again.

It copies files into `~/.local` and `~/.config`. It does not remove them.

## Font

The letter shapes come from LibreQuake's console sheet, `lq1/gfx-wad/CONCHARS.png`, under the 3-clause BSD license. `font/COPYING` is that notice. Keep it with the font file.
