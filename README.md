# **IlluminaBacSeq**
A simple pipeline for de novo genome assembly of clinical bacterial isolates using short-read sequencing data  

The pipeline is designed to process short-read sequencing data, perform trimming, de novo assembly, quality assessment and provide a summary of the assembly metrics. This pipeline was specifically designed to work with our own dataset, however the trimming and assembly parameters can be changed by altering the respective scripts to suit the user's needs.

## **Overview** 
This documentation provides an overview and usage instructions for the scripts in the IlluminaBacSeq pipeline. The pipeline is designed to process short-read sequencing data, perform trimming, de novo assembly, quality assessment and provide a summary of the assembly metrics. This pipeline was specifically designed to work with our own dataset, however the trimming and assembly parameters can be changed by altering the respective scripts to suit the user's needs. 

## **Contents**

1. Requirements 
2. Installation 
3. Usage 
5. Output files 
6. Workflow steps 
7. Integration and flow 
8. References

## **Requirements**

1. Linux (the pipeline has been tested only on Ubuntu so far) 
2. Python 3.7 or later 
3. Trimmomatic 
4. Unicycler 
5. QUAST
   
## **Installation**

1. To install all the third party components, first create a conda environment:

   ```conda create -n "env_name" python=3.7```
   
   ```conda activate "env_name```

3. Install all the third party components.

    ```conda install -c bioconda trimmomatic```
   
    ```conda install -c bioconda unicycler```
   
    ```conda install -c conda-forge -c bioconda quast```

5. Download the git package of the pipeline.

    ``` git clone https://github.com/Vasundhara-Karthik/IlluminaBacSeq.git```

## **Usage**

```sh ./master.sh <raw_reads_directory> <output_directory> <adaptor_file> <num_threads> <path_to_scripts>```

- <raw_reads_directory>: Path to the directory containing the raw read fastq files
- <output_directory>: Path to the directory where all the results will be saved 
- <adapter_file>: Path to the files containing the adapter sequences to be used for trimming
- <num_threads>: Number of threads to be used during the process 
- <path_to_scripts>: Path to the directory containing the workflow scripts

## **Workflow steps**

1. Read Trimming and Filtering (read-trimming.sh)-Trims and filters reads to remove low-quality bases and adapter sequences. 
2. Genome Assembly (assembly.sh)- Utilizes unicycler for short-read genome assembly using high quality short reads. ● Generates a de novo genome assembly. 
3. Quality assessment of genome assembly using QUAST (quast.sh)- Uses quast to assess the contiguity of an assembly. 
4. Assembly metric summary (quast-summary.sh)- Retrieves the total contig number, N50 and GC content statistics for each assembly. ● Returns the summary in the form of a CSV file.

## **Output files**

In the output folder, the results directory contains key subfolders and files summarizing the analysis results: 

1. ‘trimmed_reads/’ : This folder holds the trimmed and filtered read files after the Trimmomatic step.
2. ‘assembly/’ : Within this directory, you’ll find the outputs from the Unicycler tool, which performs the de novo assembly. Each Unicycler output folder contains the genome fasta file (assembly.fasta), assembly graph file (assembly.gfa), and the Unicycler run log files. 
3. ‘quast/’ : Here, QUAST-generated detailed reports on assembly statistics and genome view files reside. These reports provide valuable insights on assembly contiguity. 
4. ‘assembly_metrics.csv’ : A csv file that summarizes essential metrics from the QUAST reports for all the assemblies, making it easy to track and compare results across different runs. 

# **References**

1.	Bolger, A. M., Lohse, M., & Usadel, B. (2014). Trimmomatic: a flexible trimmer for Illumina sequence data. Bioinformatics, 30(15), 2114–2120. https://doi.org/10.1093/BIOINFORMATICS/BTU170

2.	Gurevich, A., Saveliev, V., Vyahhi, N., & Tesler, G. (2013). QUAST: quality assessment tool for genome assemblies. Bioinformatics, 29(8), 1072–1075. https://doi.org/10.1093/BIOINFORMATICS/BTT086

3.	Wick, R. R., Judd, L. M., Gorrie, C. L., & Holt, K. E. (2017). Unicycler: Resolving bacterial genome assemblies from short and long sequencing reads. PLOS Computational Biology, 13(6), e1005595. https://doi.org/10.1371/JOURNAL.PCBI.1005595

Organization: Ashoka University


