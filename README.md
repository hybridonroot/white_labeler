# The White Labeler

## Overview
The White Labeler is a powerful CLI tool designed to replace a given word across file names, folder names, and file contents within a directory. Whether you're rebranding or simply renaming multiple occurrences of a word, The White Labeler automates the process efficiently.

## Features
- **Batch rename files and directories** containing a specific word.
- **Replace text inside files** across an entire directory.
- **Interactive CLI** with a clean UI and progress tracking.
- **Safe execution** with confirmation prompts before making changes.
- **Fast processing** with real-time progress updates.

## Setup
### Prerequisites
Ensure you have a Linux or macOS system with the following:
- **Bash** (default on Unix systems)
- **sed** (stream editor for modifying file contents)
- **find & mv** (for searching and renaming files)

### Installation
1. Clone or download this repository:
   ```sh
   git clone https://github.com/your-repo/the-white-labeler.git
   cd the-white-labeler
   ```
2. Grant execute permissions to the script:
   ```sh
   chmod +x the_white_labeler.sh
   ```

## Usage
1. Run the script:
   ```sh
   ./the_white_labeler.sh
   ```
2. Enter the word you want to replace.
3. Enter the new replacement word.
4. Confirm the operation.
5. Watch as the script processes files and directories, displaying progress updates.

## Example
**Before execution:**
```
my_project/
  ├── oldname-folder/
  │   ├── oldname-file.txt
  │   └── config.yaml (contains 'oldname' inside)
  ├── README.md
```

**Running The White Labeler:**
```sh
./the_white_labeler.sh
```
**User Inputs:**
```
Enter the word to replace: oldname
Enter the new replacement word: newname
Proceed? (y/n): y
```

**After execution:**
```
my_project/
  ├── newname-folder/
  │   ├── newname-file.txt
  │   └── config.yaml (all occurrences of 'oldname' replaced with 'newname')
  ├── README.md
```

## Notes
- This script modifies filenames, directory names, and file contents **irreversibly**. Use version control or backup before execution.
- Large directories may take time to process. Progress tracking is displayed to keep you informed.

## License
This project is open-source and available under the MIT License.

## Author
Developed by **hybridonroot**. Contributions and feedback are welcome!

---
**Happy White Labelling! 🚀**

