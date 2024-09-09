#!/bin/bash

# Settings
padding_top=0
padding_bottom=0
padding_right=0
max_width=0
reserved_playlist_cols=30
reserved_cols_in_percent="false"
force_square="false"
square_alignment="center"
left_aligned="true"
padding_left=0

font_height=6
font_width=6

# TEMP Settings
alignment="center"
icat_width= #70
icat_height= #39
icat_left=0

main() {
    display_cover
    # detect_window_resizes
    notify-send -u low -i ${COVER} "Now Playing" "`mpc current`"
}

display_cover() {
    COVERPATH="/tmp/cover.webp"
    file_name=$(mpc --format %file%)

    echo "$file_name" >> /tmp/some_stuff.txt

    name=$(head -n 1 /tmp/some_stuff.txt)
    name="$(mpc current)"

    if [[ -f /tmp/some_stuff.txt ]]; then
        rm /tmp/some_stuff.txt 2> /dev/null
    fi

    name="${name%.*}"
    COVER="/home/oliver/$name.webp"

    kitty @ focus-window --match title:cover 
    compute_size

    kitty @ send-text --match title:cover 'export PS1="" && clear \r'

    if [[ ! -z $name ]] && [[ -f $COVER ]]; then
    kitty @ send-text --match title:cover 'clear && kitten icat --silent --scale-up --clear --stdin=no --align '${alignment}' --transfer-mode stream --place '${term_cols}'x'${term_lines}'@'${icat_left}'x'${padding_top}' "/home/oliver/'$name'.webp" \r'
    fi

    kitty @ focus-window --match title:ncmpcpp

}

compute_size() {
    # unset LINES COLUMNS # Required in order for tput to work in a script
    term_lines=$(tput lines)
    term_cols=$(tput cols)
    padding_top=$(($term_lines / 4))
}

detect_window_resizes() {
    {
        trap 'display_cover' WINCH
        while :; do sleep 5; done
    } &
}

main
