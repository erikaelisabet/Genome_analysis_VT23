#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 00:20:00
#SBATCH -J MUMer_job
#SBATCH --mail-type=ALL
#SBATCH --mail-user Erika.Lindberg.3300@student.uu.se

# Load modules
module load bioinfo-tools
module load MUMmer

#variables
OUTPUT="/home/erikali/Genome_analysis_VT23/analyses/01_DNA_ass/mumer_out"
INPUT="/home/erikali/Genome_analysis_VT23/analyses/01_DNA_ass/canu_out/LFerriphilum.contigs.fasta"
REFERENCE="/home/erikali/Genome_analysis_VT23/data/raw_data/reference/OBMB01.fasta"

# Your commands

mummer -mum -b -c $REFERENCE $INPUT > $OUTPUT/mumer_file.mums


cd $OUTPUT

mummerplot \
-Q $INPUT \
-R $REFERENCE \
$OUTPUT/mumer_file.mums \
-p mumer_file --png

gnuplot mumer_file.gp

