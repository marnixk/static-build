#!/bin/bash

TARGET_FOLDER=../build/
BASE_FOLDER=html/
CONFIG=${CONFIG:-../config/default.tcl}
TX_FILES=$(find -wholename "*.html" ! -path "*/_*")

echo
echo "Find results in: $(realpath $TARGET_FOLDER)"
echo

# copy everything
cp -R . $TARGET_FOLDER

for file in $TX_FILES 
do
	FILE_DIR=$(dirname $file)
	TARGET_FILE="$TARGET_FOLDER$file"

	echo " .. building: $(realpath $file)"

	mkdir -p $TARGET_FOLDER/$FILE_DIR
	cat $file | ../convert.tcl $BASE_FOLDER $CONFIG > $TARGET_FILE
done

