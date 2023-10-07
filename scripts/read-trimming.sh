#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if Trimmomatic is installed
if ! command_exists trimmomatic; then
  echo "Trimmomatic is not installed. Please install Trimmomatic and try again."
  exit 1
fi

# Check if the input directory and adapter file are provided
if [ -z "$1" ] || [ -z "$2" ] || [-z "$3"]; then
  echo "Usage: bash read-trimming.sh <input_directory> <output_directory> <adapter_file>"
  exit 1
fi

# Input directory and adapter file
input_dir=$1
output_dir=$2
adapter_file=$3

trimmed="$output_dir/results/trimmed_reads"
# Create an output directory for trimmed reads
mkdir -p  "$trimmed"


# Run Trimmomatic on all paired-end FASTQ and FASTQ.gz files in the specified input directory
for file_read1 in ${input_dir}/*_R1.fastq.gz; do
  base=$(basename "$file_read1" .fastq.gz)
  file_read2="${file_read1/_R1/_R2}"

  trimmed_r1="$trimmed/${base}.trimmed.fastq.gz"
  trimmed_r2="$trimmed/${base/_R1/_R2}.trimmed.fastq.gz"

  trimmomatic PE -phred33 "$file_read1" "$file_read2" "$trimmed_r1" /dev/null "$trimmed_r2" /dev/null \
        ILLUMINACLIP:"$adapter_file":2:30:10:2:keepBothReads LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36 
done

echo "Trimmomatic read trimming completed for paired-end reads using provided adapters. Trimmed reads saved in results/trimmed_reads/ directory."

