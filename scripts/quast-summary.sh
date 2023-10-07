#!/bin/bash

# Check if the assembly directory is provided
if [ -z "$1" ]; then
  echo "Usage: bash quast-summary.sh <output_directory>"
  exit 1
fi

output_dir=$1
quast_output_dir="$output_dir/results/quast"

# Output CSV file to store the data
output_csv_file="$output_dir/results/assembly_metrics.csv"

# Header for the CSV file
echo "Quast Output Folder,Number of Contigs,N50,GC Content (%)" > "$output_csv_file"

# Iterate over each QUAST output folder
for folder in "$quast_output_dir"/*; do
    if [ -d "$folder" ]; then
        quast_folder_name=$(basename "$folder")
        report_tsv="$folder/report.tsv"

        if [ -f "$report_tsv" ]; then
            num_contigs=$(awk -F'\t' '$1 == "# contigs (>= 0 bp)" {print $2}' "$report_tsv")
            n50=$(awk -F'\t' '$1 == "N50" {print $2}' "$report_tsv")
            gc_content=$(awk -F'\t' '$1 == "GC (%)" {print $2}' "$report_tsv")

            # Append to the CSV file
            echo "$quast_folder_name,$num_contigs,$n50,$gc_content" >> "$output_csv_file"
        fi
    fi
done

echo "Data saved to $output_csv_file"

