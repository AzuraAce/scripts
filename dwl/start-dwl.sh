#!/bin/sh

# --- Session settings ---
export XDG_CURRENT_DESKTOP=wlroots
export XDG_SESSION_TYPE=wayland
export XDG_SESSION_DESKTOP=wlroots

# Starting dbus-session might require hard path.
slstatus -s | dbus-run-session dwl -s '/home/oliver/scripts/dwl/dwl-startup.sh <&-'
