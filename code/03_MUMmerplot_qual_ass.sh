#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
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
OUTPUT=/home/erikali/Genome_analysis_VT23/analyses/01_DNA_ass
INPUT= <all contigs from assembly?>
REF= <reference genome>
OUTFILE=<path to outfile> 

# Your commands

mummer -mum -b -c $REF $INPUT > $OUTFILE/<filename>

cd $OUTFILE

mummerplot \
-Q $INPUT \
-R $REF \
$MUMS/lferriphilum.mums \
--png --prefix=lferriphilum

gnuplot lferriphilum.gp

