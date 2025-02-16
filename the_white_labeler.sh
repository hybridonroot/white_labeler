#!/bin/bash

# Beautiful CLI Intro
clear
echo "==========================================="
echo "        THE WHITE LABELER BY MISBAH        "
echo "==========================================="
echo ""
echo "1. Enter the word to replace"
echo "2. Enter the replacement word"
echo "3. Execute White Labelling"
echo "==========================================="

echo ""
read -p "Enter the word you want to replace: " WORD_TO_REPLACE
read -p "Enter the new replacement word: " REPLACEMENT_WORD

echo ""
read -p "Add a file type filter? (y/n): " ADD_FILE_FILTER
FILE_EXTENSION=""
if [[ "$ADD_FILE_FILTER" == "y" ]]; then
    read -p "Enter the file extension (e.g., .txt): " FILE_EXTENSION
fi

echo "==========================================="
echo "You are about to replace: '$WORD_TO_REPLACE' with '$REPLACEMENT_WORD'"
echo "This includes filenames, folder names, and file contents."
echo "==========================================="
read -p "Proceed? (y/n): " CONFIRM

if [[ "$CONFIRM" != "y" ]]; then
    echo "Operation canceled. Exiting."
    exit 1
fi

clear
echo "==========================================="
echo "       EXECUTING WHITE LABELLING...       "
echo "==========================================="

# Step 1: Rename files and directories
if [[ "$FILE_EXTENSION" == "" ]]; then
    find . -depth -name "*$WORD_TO_REPLACE*" | while read file; do
        new_name=$(echo "$file" | sed "s/$WORD_TO_REPLACE/$REPLACEMENT_WORD/g")
        mv "$file" "$new_name" 2>/dev/null
        echo "Renamed: $file -> $new_name"
    done
else
    find . -depth -name "*$WORD_TO_REPLACE*$FILE_EXTENSION" | while read file; do
        new_name=$(echo "$file" | sed "s/$WORD_TO_REPLACE/$REPLACEMENT_WORD/g")
        mv "$file" "$new_name" 2>/dev/null
        echo "Renamed: $file -> $new_name"
    done
fi
# Step 2: Replace inside files
if [[ "$FILE_EXTENSION" == "" ]]; then
    find . -type f -exec sed -i "s/$WORD_TO_REPLACE/$REPLACEMENT_WORD/g" {} +
else
    find . -type f -name "*$FILE_EXTENSION" -exec sed -i "s/$WORD_TO_REPLACE/$REPLACEMENT_WORD/g" {} +
fi

echo "==========================================="
echo " WHITE LABELLING COMPLETED SUCCESSFULLY! 🚀 "
echo "==========================================="
