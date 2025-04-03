#!/bin/bash

# Settings
padding_top=1
padding_bottom=0
padding_right=4
padding_left=4
max_width=0
reserved_playlist_cols=30
reserved_cols_in_percent="false"
force_square="false"
square_alignment="center"
left_aligned="true"

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
    notify-send -u low "Now Playing" "`mpc current`"
}

display_cover() {
    if ! kitty @ focus-window --match title:cover &> /dev/null; then
        return -1
    fi

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
        kitty @ send-text --match title:cover 'clear && kitten icat --silent --scale-up --clear --stdin=no --align '${alignment}' --transfer-mode stream --place '${icat_width}'x'${icat_height}'@'${icat_left}'x'${padding_top}' "/home/oliver/'$name'.webp" \r'
    fi

    kitty @ focus-window --match title:ncmpcpp

}

compute_size() {
    term_lines=$(tput lines)
    term_cols=$(tput cols) 
    icat_height=$term_lines
    icat_width=$(($term_cols - ($padding_left + $padding_right)))
    icat_left=$padding_left
}

detect_window_resizes() {
    {
        trap 'display_cover' WINCH
        while :; do sleep 5; done
    } &
}

main
