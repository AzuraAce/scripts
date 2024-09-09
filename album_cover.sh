#!/bin/sh
# Requires mpc

file_name=$(mpc --format %file%)

echo "$file_name" >> /tmp/some_stuff.txt

name=$(head -n 1 /tmp/some_stuff.txt)

rm /tmp/some_stuff.txt

name="${name%.*}"
echo $name

kitten icat "/home/oliver/$name.webp"
