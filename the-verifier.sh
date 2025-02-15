#!/bin/bash

# Beautiful CLI Intro
clear
echo "==========================================="
echo "           THE VERIFIER BY MISBAH           "
echo "==========================================="
echo ""
echo "This tool checks if a given text exists in file names, directories, or within files."
echo "==========================================="

echo ""
read -p "Enter the text you want to verify: " TEXT_TO_CHECK

clear
echo "==========================================="
echo "        SEARCHING FOR '$TEXT_TO_CHECK'        "
echo "==========================================="

# Step 1: Search in filenames and directory names
echo "Checking file and directory names..."
found_files=$(find . -name "*$TEXT_TO_CHECK*" 2>/dev/null)
if [[ -n "$found_files" ]]; then
    echo "Found in file/directory names:"
    echo "$found_files"
else
    echo "No matches found in file or directory names."
fi

echo "-------------------------------------------"

# Step 2: Search inside files
echo "Checking inside files..."
found_inside_files=$(grep -rl "$TEXT_TO_CHECK" . 2>/dev/null)
if [[ -n "$found_inside_files" ]]; then
    echo "Found inside files:"
    echo "$found_inside_files"
else
    echo "No matches found inside files."
fi

echo "==========================================="
echo "           VERIFICATION COMPLETED          "
echo "==========================================="
