#!/usr/bin/env bash

# Prompt user for source and destination
echo "Enter the source directory to back up (default is /):"
read -r LOCATION
LOCATION="${LOCATION:-/}"

echo "Enter the destination path for the backup file (e.g., /path/to/backup.tar.gz):"
read -r DESTINATION

# Prompt for directories to exclude, read multiline input until empty line
echo "Enter the directories to exclude (one per line). Press Enter on an empty line to finish:"
EXCLUDE_DIRS=()
while IFS= read -r line && [[ -n "$line" ]]; do
    EXCLUDE_DIRS+=("--exclude=$line")
done

# Add default system directories to exclude
DEFAULT_EXCLUDES=(
  --exclude=proc
  --exclude=tmp
  --exclude=mnt
  --exclude=dev
  --exclude=sys
  --exclude=run
  --exclude=media
  --exclude=var/log
  --exclude=/home/oliver/.cache
  --exclude=/home/oliver/.local/share/nvim
  --exclude=/home/oliver/downloads
)

# Run tar with all excludes
tar -cvpzf "$DESTINATION" \
    "${DEFAULT_EXCLUDES[@]}" \
    "${EXCLUDE_DIRS[@]}" \
    -C "$LOCATION" .
