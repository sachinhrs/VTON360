#!/bin/bash

# $1 = source folder, $2 = destination folder
SRC="$1"
DEST="$2"

# Validate arguments
if [ -z "$SRC" ] || [ -z "$DEST" ]; then
    echo "Usage: $0 <source_folder> <destination_folder>"
    exit 1
fi

# If destination folder already exists, rename it with a timestamp
if [ -d "$DEST" ]; then
    TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
    mv "$DEST" "${DEST}_${TIMESTAMP}"
    echo "Existing folder renamed to: ${DEST}_${TIMESTAMP}"
fi

# Copy the new folder to destination
cp -r "$SRC" "$DEST"
echo "Folder copied to: $DEST"
