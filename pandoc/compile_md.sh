#!/bin/bash

show_help()
{
    echo "Error: no markdown files given"
    echo "Usage: $(basename $0) <md_file_to_compile.md>"
}

if [[ $# < 1 ]]; then
    show_help
    exit
fi

MD_FILES=()
OUTPUT_FILE=""

while [ $# -gt 0 ]; do
    case $1 in
        -o)
            OUTPUT_FILE=("$(basename $2)")
            shift
            shift
            ;;
        *)
            MD_FILES+=("$(basename $1)")
            shift # shift past file
            ;;
    esac
done

if [ -n $OUTPUT_FILE ]; then
    pandoc ${MD_FILES[*]} --from markdown+grid_tables --toc=true -o "$OUTPUT_FILE.pdf"
    zathura "$(basename $OUTPUT_FILE).pdf" &
else
    pandoc ${MD_FILES[*]} --from markdown+grid_tables --toc=true -o "$(basename ${MD_FILES[0]} .md).pdf"
    zathura "$(basename ${MD_FILES[0]} .md).pdf" &
fi
