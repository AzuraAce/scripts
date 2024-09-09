#!/bin/bash

GIT_DIR="$HOME/Uni/notes/Informatik/2.-Semester/AlgoDat/Hausaufgaben/Material"
COPY_TO_DIR="$HOME/Uni/notes/Informatik/2.-Semester/AlgoDat/Hausaufgaben/Bearbeitung"

cd $GIT_DIR
git pull

LATEST_FILE=$(ls -t | head -n1)
read -p "Do you want to copy these files? [$LATEST_FILE ] (Y/n): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1

cp -r "$GIT_DIR/$LATEST_FILE" $COPY_TO_DIR
echo "Copied $LATEST_FILE to $COPY_TO_DIR"
echo ""


