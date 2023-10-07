#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

if [ -z "$1" ] || [-z "$2"]; then
  echo "Usage: bash unicycler-assembly.sh <output_directory> <number of threads>"
  exit 1
fi

output_dir=$1
threads=$2

input_trimmed_reads_dir="$output_dir/results/trimmed_reads"

# Check if Unicycler is installed
if ! command_exists unicycler; then
  echo "Unicycler is not installed. Please install Unicycler and try again."
  exit 1
fi

# Input directory with trimmed reads and output directory for Unicycler assembly
output_assembly_dir="$output_dir/results/assembly"

# Create the output directory if it doesn't exist
mkdir -p "$output_assembly_dir"

for file_read1 in "${input_trimmed_reads_dir}"/*_R1.trimmed.fastq.gz; do
  base=$(basename "$file_read1" _R1.trimmed.fastq.gz)
  file_read2="${file_read1/_R1/_R2}"

  output_assembly="$output_assembly_dir/${base}"
  
  # Assemble reads using Unicycler
  unicycler -1 "$file_read1" -2 "$file_read2" -o "$output_assembly" --min_fasta_length 300 --keep 0 -t "$threads" 
done


echo "Unicycler assembly completed. Assembly saved in $output_dir."

