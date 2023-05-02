#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 16:00:00
#SBATCH -J fastQC_posttrimming_job
#SBATCH --mail-type=ALL
#SBATCH --mail-user Erika.Lindberg.3300@student.uu.se

# Load modules
module load bioinfo-tools
module load FastQC

# variables
INPUT="/home/erikali/Genome_analysis_VT23/data/raw_data/RNA_trimmed_reads/*"
OUTPUT="/home/erikali/Genome_analysis_VT23/analyses/03_RNA_quality/fastqc_trimmed"

# running FastQC
fastqc -t 4 -o $OUTPUT -d $OUTPUT $INPUT
