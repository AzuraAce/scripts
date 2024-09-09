#!/bin/bash

show_help()
{
    echo "Error: no tex file given"
    echo "Usage: $(basename $0) <tex_file_to_compile.tex>"
}

if [[ $# < 1 ]]; then
    show_help
    exit
fi

TEX_FILE=$(basename $1)
xelatex $TEX_FILE ; zathura "$(basename $TEX_FILE .tex).pdf"
