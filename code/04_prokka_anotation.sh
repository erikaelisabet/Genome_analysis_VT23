#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:20:00
#SBATCH -J quast_job
#SBATCH --mail-type=ALL
#SBATCH --mail-user Erika.Lindberg.3300@student.uu.se

# Load modules
module load bioinfo-tools
module load prokka/1.45-5b58020

# variables
OUTPUT="/home/erikali/Genome_analysis_VT23/analyses/02_DNA_ann/prokka_out"
INPUT="/home/erikali/Genome_analysis_VT23/analyses/01_DNA_ass/canu_out/LFerriphilum.contigs.fasta"

# running prokka
prokka \
--outdir $OUTPUT --prefix Lferriphilum --addgenes --force --locustag LFT \
--genus Leptospirillum --species ferriphilum --strain DSM_14647 --gram neg \
--usegenus \
$INPUT
