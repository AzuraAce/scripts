#!/usr/bin/env bash
# Requires mpc

kitty @ send-text --match title:cover 'export PS1="" && clear \r'

COVERPATH="/tmp/cover.webp"
file_name=$(mpc --format %file%)

echo "$file_name" >> /tmp/some_stuff.txt

name=$(head -n 1 /tmp/some_stuff.txt)

rm /tmp/some_stuff.txt

name="${name%.*}"
COVER="/home/oliver/$name.webp"


kitty @ send-text --match title:cover 'clear && kitten icat --silent --scale-up --clear --stdin=no --align center "/home/oliver/'$name'.webp" \r'
