#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 00:20:00
#SBATCH -J quast_job
#SBATCH --mail-type=ALL
#SBATCH --mail-user Erika.Lindberg.3300@student.uu.se
# Load modules
module load bioinfo-tools
module load quast 

#variables 
OUTPUT="/home/erikali/Genome_analysis_VT23/analyses/01_DNA_ass/quast_out"
INPUT="/home/erikali/Genome_analysis_VT23/analyses/01_DNA_ass/canu_out/LFerriphilum.contigs.fasta"
REFERENCE="/home/erikali/Genome_analysis_VT23/data/raw_data/reference/OBMB01.fasta"

# Your commands
quast.py $INPUT -R $REFERENCE -o $OUTPUT
