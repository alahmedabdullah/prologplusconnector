#!/bin/sh

INPUT_DIR=$1
OUTPUT_DIR=$2

cd $INPUT_DIR
prolog_exe=$(whereis gprolog 2>&1 | awk '/gprolog/ {print $2}')

java_exe=$(whereis java 2>&1 | awk '/java/ {print $2}')
java_path=$(dirname $java_exe)
export PATH=$PATH:$java_path

MAX_ATOM=131064 GLOBALSZ=131064 $prolog_exe $(cat gprolog_command_line.txt) &> runlog.txt


cp ./*.txt ../$OUTPUT_DIR

# --- EOF ---
