
#!/bin/bash

input_dir="$1"

# Check if a directory is provided
if [ -z "$input_dir" ]; then
  echo "Usage: $0 <input_dir>"
  exit 1
fi

# Check if the directory exists
if [ ! -d "$input_dir" ]; then
  echo "Directory not found: $input_dir"
  exit 1
fi

# Iterate through files in the directory
for file in "$input_dir"/*; do
  # Check if the file is not already gzipped
  if [[ ! "$file" =~ \.gz$ ]]; then
    # Gzip the file
    gzip "$file"
    echo "Gzipped: $file"
  else
    echo "Already gzipped: $file"
  fi
done

echo "Gzipping completed for files in: $directory"
