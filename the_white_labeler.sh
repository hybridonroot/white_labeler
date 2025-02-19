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

echo "==========================================="
echo "You are about to replace: '$WORD_TO_REPLACE' with '$REPLACEMENT_WORD'"
echo "This includes filenames, folder names, and file contents."
echo "==========================================="
read -p "Proceed? (y/n): " CONFIRM

if [[ "$CONFIRM" == "y" ]]; then
    clear
    echo "==========================================="
    echo "       EXECUTING WHITE LABELLING...       "
    echo "==========================================="

    # Step 1: Rename files (handling spaces & preserving extensions)
    total_files=$(find . -type f -name "*$WORD_TO_REPLACE*" ! -name ".*" | wc -l)
    echo "Total files to rename: $total_files"
    progress=0

    while IFS= read -r -d '' file; do
        dir=$(dirname "$file")
        base=$(basename "$file")
        ext="${base##*.}"
        filename="${base%.*}"

        # Replace only in filename, not extension
        if [[ "$base" == *"$WORD_TO_REPLACE"* ]]; then
            if [[ "$filename" == *"$WORD_TO_REPLACE"* ]]; then
                new_filename="${filename//$WORD_TO_REPLACE/$REPLACEMENT_WORD}"
                new_name="$dir/$new_filename.$ext"
            else
                new_name="$dir/$base"
            fi

            if [[ "$file" != "$new_name" ]]; then
                mv -- "$file" "$new_name" 2>/dev/null
                ((progress++))
                echo -ne "\rProgress: $progress/$total_files files renamed"
            fi
        fi
    done < <(find . -type f -name "*$WORD_TO_REPLACE*" ! -name ".*" -print0)

    echo ""
    echo "File renaming completed."

    # Step 2: Rename directories
    total_dirs=$(find . -type d -name "*$WORD_TO_REPLACE*" ! -name ".*" | wc -l)
    echo "Total directories to rename: $total_dirs"
    progress=0

    while IFS= read -r -d '' dir; do
        new_name="${dir//$WORD_TO_REPLACE/$REPLACEMENT_WORD}"
        if mv -- "$dir" "$new_name" 2>/dev/null; then
            ((progress++))
            echo -ne "\rProgress: $progress/$total_dirs directories renamed"
        else
            echo "Error renaming: $dir"
        fi
    done < <(find . -type d -name "*$WORD_TO_REPLACE*" ! -name ".*" -print0 | sort -rz)

    echo ""
    echo "Directory renaming completed."

    echo "==========================================="
    echo " WHITE LABELLING COMPLETED SUCCESSFULLY! "
    echo "==========================================="
    exit 0
fi

# If user selects "n", enter interactive renaming mode
echo "==========================================="
echo "   ENTERING INTERACTIVE RENAMING MODE...   "
echo "==========================================="

FILES=()
while IFS= read -r -d '' file; do
    FILES+=("$file")
done < <(find . -depth -name "*$WORD_TO_REPLACE*" ! -name ".*" -print0 2>/dev/null)

if [[ ${#FILES[@]} -eq 0 ]]; then
    echo "No matching files found. Exiting."
    exit 1
fi

read -p "Do you want to rename files one by one? (y/n): " INDIVIDUAL_RENAME

if [[ "$INDIVIDUAL_RENAME" == "y" ]]; then
    # Rename files one by one
    for file in "${FILES[@]}"; do
        read -p "Rename '$file'? (y/n): " RENAME_CONFIRM
        if [[ "$RENAME_CONFIRM" == "y" ]]; then
            dir=$(dirname "$file")
            base=$(basename "$file")
            ext="${base##*.}"
            filename="${base%.*}"

            if [[ "$filename" == *"$WORD_TO_REPLACE"* ]]; then
                new_filename="${filename//$WORD_TO_REPLACE/$REPLACEMENT_WORD}"
                new_name="$dir/$new_filename.$ext"
            else
                new_name="$file"
            fi

            mv "$file" "$new_name" 2>/dev/null
            echo "Renamed: '$file' -> '$new_name'"
        fi
    done

    echo "==========================================="
    echo "  INTERACTIVE RENAMING COMPLETED!  "
    echo "==========================================="
    exit 0
fi

echo "Operation canceled. Exiting."
exit 1
