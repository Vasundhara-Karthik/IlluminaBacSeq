#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if BUSCO is installed
if ! command_exists busco; then
  echo "BUSCO is not installed. Please install BUSCO and try again."
  exit 1
fi

if [ -z "$1" ] || [-z "$2"]; then
  echo "Usage: bash busco.sh <output_directory> <busco_path>"
  exit 1
fi

output_dir=$1
input_dir="$output_dir/results/assembly"
busco_path=$2

# Set the output directory for BUSCO results
BUSCO_OUTPUT_FOLDER="results/busco"

# Create the output folder if it doesn't exist
mkdir -p $BUSCO_OUTPUT_FOLDER

# Loop through the Unicycler output directories
for assembly_dir in "$input_dir"/*; do
    if [ -d "$assembly_dir" ]; then
        assembly_name=$(basename "$assembly_dir")
        echo "Running BUSCO for $assembly_name"

        if [[ "$assembly_name" == *"EC"* ]]; then
            busco_db="enterobacterales_odb10"
        elif [[ "$assembly_name" == *"KP"* ]]; then
            busco_db="enterobacterales_odb10"
        elif [[ "$assembly_name" == *"AB"* ]]; then
            busco_db="pseudomonadales_odb10"
        elif [[ "$assembly_name" == *"PA"* ]]; then
            busco_db="pseudomonadales_odb10"
        elif [[ "$assembly_name" == *"EF"* ]]; then
            busco_db="pseudomonadales_odb10"
        else
            echo "Unknown database for $assembly_name, skipping BUSCO"
            continue
        fi

        busco \
            -i "$assembly_dir/assembly.fasta" \
            -o "$BUSCO_OUTPUT_FOLDER/$assembly_name" \
            -l "$busco_path/$busco_db" \
            -m genome \
            -c 16 --offline

        echo "BUSCO done for $assembly_name"
        echo
    fi
done

echo "BUSCO assessment completed. Results saved in busco_results directory."

