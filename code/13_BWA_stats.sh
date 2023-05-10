#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 16:00:00
#SBATCH -J BWA_stats
#SBATCH --mail-type=ALL
#SBATCH --mail-user Erika.Lindberg.3300@student.uu.se

# Load modules
module load bioinfo-tools
module load bwa
module load samtools

# variables
OUTPUT="/home/erikali/Genome_analysis_VT23/analyses/04_RNA_mapping"
INPUT="/proj/genomeanalysis2023/nobackup/work/erikalindberg"
SEQUENCES="ERR2036629 ERR2036630 ERR2036631 ERR2036632 ERR2036633 ERR2117288 ERR2117289 ERR2117290 ERR2117291 ERR2117292"

$SNIC_TMP

cd $SNIC_TMP

for F in $SEQUENCES
do
(
gunzip -c $INPUT/${F}_mapped_RNA.sorted.bam.gz > $SNIC_TMP/${F}_mapped_RNA.sorted.bam
samtools stats -O tsv $SNIC_TMP/${F}_mapped_RNA.sorted.bam > $SNIC_TMP/${F}.stat
) &
done
wait 

cp $SNIC_TMP/*.stat $OUTPUT
