#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if QUAST is installed
if ! command_exists quast.py; then
  echo "QUAST is not installed. Please install QUAST and try again."
  exit 1
fi

if [ -z "$1" ]; then
  echo "Usage: bash quast.sh <output_directory>"
  exit 1
fi

output_dir=$1
assembly_dir="$output_dir/results/assembly"
quast_dir="$output_dir/results/quast"

mkdir -p "$quast_dir"

# Iterate through provided assembly directories
for assembly in "$assembly_dir"/*; do
  base=$(basename "$assembly")
  output_dir1="$quast_dir/$base"
  # Run QUAST to evaluate the assembly
  quast.py -o "$output_dir1" --threads 4 "$assembly/assembly.fasta"
done

echo "QUAST evaluation completed for provided assembly directories."
