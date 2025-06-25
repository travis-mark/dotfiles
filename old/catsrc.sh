#!/bin/bash

# Check if any arguments were provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <file1> [file2] [file3] ..." >&2
    echo "Example: $0 *.txt" >&2
    echo "Example: find . -name '*.py' | xargs $0" >&2
    exit 1
fi

# Loop through all provided files
for file in "$@"; do
    # Check if file exists and is readable
    if [ ! -f "$file" ]; then
        echo "Warning: '$file' is not a regular file, skipping..." >&2
        continue
    fi
    if [ ! -r "$file" ]; then
        echo "Warning: '$file' is not readable, skipping..." >&2
        continue
    fi
    # Print header with filename
    echo "## $file"
    echo
    # Cat the file content
    echo '```'
    cat "$file" 
    echo '```'
    echo
done