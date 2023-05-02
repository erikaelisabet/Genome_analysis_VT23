#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 01:00:00
#SBATCH -J trimmomatic_job
#SBATCH --mail-type=ALL
#SBATCH --mail-user Erika.Lindberg.3300@student.uu.se

# Load modules
module load bioinfo-tools
module load trimmomatic

INPUT="/home/erikali/Genome_analysis_VT23/data/raw_data/RNA_raw_data"
OUTPUT="/home/erikali/Genome_analysis_VT23/data/preprocessed_data"

# Run trimmomatic in one file, to save some time
trimmomatic PE \
-threads 4 -phred33 \
$INPUT/ERR2036629_1.fastq.gz \
$INPUT/ERR2036629_2.fastq.gz \
-baseout $OUTPUT\trimmed_ERR2036629.fastq.gz \
ILLUMINACLIP:TruSeq3-PE.fa:2:30:10 \
LEADING:10 \
TRAILING:10 \
SLIDINGWINDOW:4:15 \
MINLEN:36
