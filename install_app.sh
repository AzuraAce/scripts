#!/bin/bash

if [[ $# -ne 2 ]]; then
    echo "Usage: install_app.sh <app_name> <path/to/app.tar>"
    exit 2
fi

APP_NAME=$1
TAR_FILE=$2
TARGET_DIR="$HOME/applications"

if [ ! -d "$TARGET_DIR" ]; then
    mkdir "$TARGET_DIR"
fi

mkdir "$TARGET_DIR/$APP_NAME"

tar -xvf "$TAR_FILE" -C "$TARGET_DIR/$APP_NAME"

if [ -f "$TARGET_DIR/$APP_NAME/$APP_NAME" ]; then
    sudo ln -sf "$TARGET_DIR/$APP_NAME/$APP_NAME" "/usr/bin/$APP_NAME"
fi

rm "$TAR_FILE"
