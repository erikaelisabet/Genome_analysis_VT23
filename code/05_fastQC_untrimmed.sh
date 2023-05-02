#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 16:00:00
#SBATCH -J fastQC_pretrimming_job
#SBATCH --mail-type=ALL
#SBATCH --mail-user Erika.Lindberg.3300@student.uu.se

# Load modules
module load bioinfo-tools
module load FastQC

# variables
INPUT="/home/erikali/Genome_analysis_VT23/data/raw_data/RNA_raw_data/ERR2*"
OUTPUT="/home/erikali/Genome_analysis_VT23/data/preprocessed_data"

# running FastQC
fastqc -t 4 -o $OUTPUT -d $OUTPUT $INPUT
