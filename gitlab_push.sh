#!/bin/bash

show_help () 
{
    echo "Usage: $(basename $0) <path to git repository> -d <dir to add files to> <file1 to add> <file2 to add> ..."
    echo "options:"
    echo "  -d          specify path in git repository to copy files to. If Empty copy to root of git repo"
    exit
}

if [ $# -lt 2 ]; then
    show_help
fi

# directory of git repository
GIT_DIR=$1
shift # shift to start for-loop from second argument

# (-d option) Dir in repository to copy files to
COPY_DIR=""

FILE_NAMES=()
while [ $# -gt 0 ]; do
    case $1 in
        -h)
            show_help
            ;;
        -d)
            COPY_DIR=$2

            if [[ ! -d "$GIT_DIR/$COPY_DIR" ]]; then
                mkdir -p "$GIT_DIR/$COPY_DIR"
            fi
            if [[ ! -z $COPY_DIR ]]; then
                COPY_DIR+="/"
            fi
            shift # past argument
            shift # past value
            ;;
         *)
            FILE_NAMES+=" $COPY_DIR$(basename $1)"
            cp $(basename $1) "$GIT_DIR/$COPY_DIR"
            shift # past argument
            ;;
    esac
done

cd $GIT_DIR
git status

printf "\nPulling in latest changes if any\n"
git pull

read -p "Do you want to commit these files? [$FILE_NAMES ] (Y/n): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
git add $FILE_NAMES

read -p "Enter commit message: " commit
git commit -m "$commit"

git push


