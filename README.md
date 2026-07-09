# CSHELL
A [caelestia shell](https://github.com/caelestia-dots/shell) inspired quickshell config

I really liked the design and animations of caelestia shell and its border/bars but 
the shell was only avaliable for hyprland and also has alot of things I didn't need.

## Features
- Caelestia-like dashboard
- Workspace indicator implemented with the built-in quickshell workspace
module (but might not work with all wm because niri workspace uses the y coordinate)
- Notification Daemon (I haven't made anything to keep track of notifications yet)
- Wifi, Bluetooth and Battery indicators (WIP)
- Current window title (this is niri only)
- Volume & brightness OSD

## WIP
The config is very wip so if you want to use it for yourself you have to change
things yourself. Alot of things are hardcoded, so if people like this and want to
use it I'll spend some time to make it more portable.

## Dependencies

- [m3shapes](https://github.com/soramanew/m3shapes)

# Installation

Nix users:

The shell is avaliable as a flake

```sh
$ nix run gitbub:chaeu-srk/cshell
```
