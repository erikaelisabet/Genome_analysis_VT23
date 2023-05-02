#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 02:00:00
#SBATCH -J nblast_job
#SBATCH --mail-type=ALL
#SBATCH --mail-user Erika.Lindberg.3300@student.uu.se
# Load modules
module load bioinfo-tools
module load blast 

#variables
OUTPUT="/home/erikali/Genome_analysis_VT23/analyses/20_DNA_synteny"
INPUT="/home/erikali/Genome_analysis_VT23/analyses/01_DNA_ass/canu_out/LFerriphilum.contigs.fasta"
REFERENCE="/home/erikali/Genome_analysis_VT23/data/reference_data/YSK_sequence.fasta"


makeblastdb -in $REFERENCE -dbtype nucl -out DB_with_ref

# Your commands
# Run blast
blastn -db DB_with_ref \
-query $INPUT \
-outfmt	6 \
-out $OUTPUT/nblast_out.txt \
-num_threads 4 \


