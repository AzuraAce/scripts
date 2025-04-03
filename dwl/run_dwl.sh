export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=sway # sway because this makes obs screen sharing work
export XDG_SESSION_DESKTOP=sway

export PATH="$PATH:$HOME/scripts/dwm:$HOME/scripts/dwl"

dwl -s ' 
        dwlb &
        sleep 0.1
        conky | dwlb -status-stdin all &
        mpd &
        udiskie &' 2> /tmp/dwl-log.txt

        # setwall set ~/wallpapers/1630505.jpg -c sway &
