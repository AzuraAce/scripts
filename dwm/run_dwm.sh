xrdb -merge ~/.Xresources
xset r rate 200 50 &

# transperancy
picom &

# wallpaper
feh --no-fehbg --bg-fill $HOME/wallpapers/2014465.webp &

# TopBar
conky | while read -r; do xsetroot -name "$REPLY"; done &
exec mpd &
udiskie &

export PATH="$PATH:$HOME/scripts/dwm:/usr/avr/include"
export JAVA_HOME=/opt/jdk-21.0.1+12
export PATH=$PATH:$JAVA_HOME/bin

# while type dwm >/dev/null; do dwm && continue || break; done
exec dbus-launch --sh-syntax --exit-with-session dwm

