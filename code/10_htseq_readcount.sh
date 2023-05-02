#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 16:00:00
#SBATCH -J htseq_readcount_job
#SBATCH --mail-type=ALL
#SBATCH --mail-user Erika.Lindberg.3300@student.uu.se

# Load modules
module load bioinfo-tools
module load htseq 

# variables
GENOMANNOTATED="/home/erikali/Genome_analysis_VT23/analyses/02_DNA_ann/prokka_out/man_edit_Lferriphilum.gff"
RNAREADS="/home/erikali/Genome_analysis_VT23/analyses/04_RNA_mapping"
OUTPUT="/home/erikali/Genome_analysis_VT23/analyses/05_Read_count"
SEQUENCE="ERR2036629 ERR2036630 ERR2036631 ERR2036632 ERR2036633 ERR2117288 ERR2117289 ERR2117290 ERR2117291 ERR2117292"

$SNIC_TMP

cd $SNIC_TMP

for file in $SEQUENCE 
do 
(
gunzip -c $RNAREADS/${file}_mapped_RNA.sorted.bam.gz > $SNIC_TMP/${file}_mapped_RNA.sorted.bam
# running htseq
htseq-count -f bam -r pos -s reverse -t CDS -i ID ${file}_mapped_RNA.sorted.bam $GENOMANNOTATED > ${file}_out_HTseq.txt
) &
done
wait

cp $SNIC_TMP/*_out_HTseq.txt $OUTPUT
