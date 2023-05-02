#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 16:00:00
#SBATCH -J BWA_job
#SBATCH --mail-type=ALL
#SBATCH --mail-user Erika.Lindberg.3300@student.uu.se

# Load modules
module load bioinfo-tools
module load bwa 
module load samtools

# variables
REFERENCE="/home/erikali/Genome_analysis_VT23/data/raw_data/reference/OBMB01.fasta"
INPUTRNAPATH="/home/erikali/Genome_analysis_VT23/data/raw_data/RNA_trimmed_reads"
OUTPUT="/home/erikali/Genome_analysis_VT23/analyses/04_RNA_mapping"
SEQUENCES="ERR2036629 ERR2036630 ERR2036631 ERR2036632 ERR2036633 ERR2117288 ERR2117289 ERR2117290 ERR2117291 ERR2117292"

$SNIC_TMP

cd $SNIC_TMP

# Indexed
bwa index $REFERENCE -p ref_indexed

# Run BWA MEM for each experiment both P1 and P2

for file in $SEQUENCES 
do
( bwa mem -t 4 ref_indexed $INPUTRNAPATH/${file}_P1.trim.fastq.gz $INPUTRNAPATH/${file}_P2.trim.fastq.gz | samtools view -S -b | samtools sort -o ${file}_mapped_RNA.sorted.bam
gzip ${file}_mapped_RNA.sorted.bam ) &
done
wait

cp $SNIC_TMP/*_mapped_RNA.sorted.bam.gz $OUTPUT
