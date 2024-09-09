#!/bin/bash

JAVA_FILES=()
while [ $# -gt 0 ]; do
	case $1 in
	*)
		JAVA_FILES+=("$(basename $1)")
		shift
		;;
	esac
done

javac -d out -cp out:/home/oliver/Downloads/junit-platform-console-standalone-1.9.3.jar ${JAVA_FILES[*]}

java -jar /home/oliver/Downloads/junit-platform-console-standalone-1.9.3.jar --class-path out --scan-class-path
