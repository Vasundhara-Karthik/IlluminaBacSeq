#!/bin/bash

# Check if necessary tools are installed
check_tools() {
  local tools=("trimmomatic" "unicycler" "quast.py")

  for tool in "${tools[@]}"; do
    if ! [ -x "$(command -v $tool)" ]; then
      echo "Error: $tool is not installed. Please install $tool."
      return 1
    fi
  done
  return 0
}

check_tools
if [ $? -ne 0 ]; then
  exit 1
fi

# Check if all required arguments are provided
if [ "$#" -ne 6 ]; then
  echo "Usage: $0 <raw_reads_directory> <output_directory> <adapter_file> <num_threads> <busco_db path> <path_to_scripts>"
  exit 1
fi

input_dir="$1"
output_dir="$2"
adapter_file="$3"
num_threads="$4"
busco_path="$5"
scripts_path="$6"

cd "$scripts_path"

# Run gzip 
bash gzip.sh "$input_dir"

# Run Trimmomatic to trim reads
bash read-trimming.sh "$input_dir" "$output_dir" "$adaptor_file"

# Run Assembly
bash assembly.sh "$output_dir" "$num_threads"

# Run QUAST
bash quast.sh "$output_dir"

# Run QUAST-summary
bash quast-summary.sh "$output_dir"

# Run BUSCO
#bash busco.sh "$output_dir/results/busco" "$busco_path"

echo "Pipeline completed successfully."
