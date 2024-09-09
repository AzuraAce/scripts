#!/bin/bash

JAVA_FILES=()
while [ $# -gt 0 ]; do
    case $1 in
        *)
            JAVA_FILES+=("$(basename $1)")
            shift # shift past file
            ;;
    esac
done

javac -d out -cp out ${JAVA_FILES[*]} && java -cp out $(basename ${JAVA_FILES[0]} .java)
