#!/bin/sh

# Kill already running dublicate process
_ps="mako swaybg"
for _prs in $_ps; do
    if [ "$(pidof "${_prs}")" ]; then
         killall -9 "${_prs}"
    fi
 done

# Start our applications
swaybg --output '*' --mode fill --image ~/wallpapers/macOS-Sierra-Wallpaper-Macbook-Wallpaper.jpg & 
mako &
foot --server &

exec dbus-update-environment WAYLAND_DISPLAY
