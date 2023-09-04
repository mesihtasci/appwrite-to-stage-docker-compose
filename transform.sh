#!/bin/bash

# Check for input file
if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <yml-file>"
  exit 1
fi

file="$1"
temp_file="${file}.tmp"

# Process each line
while IFS= read -r line; do

  # Skip lines containing container_name: => otherwise docker will complain about duplicated names
  if [[ ! $line =~ container_name: ]]; then

    # Replace 'appwrite' with 'appwrite-stage' for lines containing 'constraint-label-stack' => here we want to replace appwrite with appwrite-stage
    if [[ $line =~ constraint-label-stack ]]; then
      line=${line/appwrite/appwrite-stage}
    fi

    echo "$line" >> "$temp_file"

    # Check for the specific line to append new lines after => this is important for oauth
    if [[ $line == *"--entrypoints.appwrite_websecure.address=:443" ]]; then
      echo "      - --entrypoints.appwrite_web.forwardedHeaders.insecure" >> "$temp_file"
      echo "      - --entrypoints.appwrite_websecure.forwardedHeaders.insecure" >> "$temp_file"
    fi

  fi

done < "$file"

# Replace original file with the temporary one
mv "$temp_file" "$file"