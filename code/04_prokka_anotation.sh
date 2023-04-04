#!/bin/bash -l

#SBATCH -A g2020008
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 00:10:00
#SBATCH -J 0109_annotation_prokka
#SBATCH --mail-type=ALL
#SBATCH --mail-user nuria.garrigaalonso.5928@student.uu.se

# Load modules
module load bioinfo-tools
module load prokka

# variables
INPUT="
OUTPUT="~/genome-analysis/analyses/01_genome_assembly/09_annotation_prokka"

cd ~/genome-analysis/analyses/01_genome_assembly/
# running prokka
prokka \
--outdir $OUTPUT --prefix lferr --locustag LFT \
--genus Leptospirillum --species ferriphilum --strain DSM_14647 --gram neg\
--usegenus --cpus 4 --rfam \
lferriphilum_genome.fasta \
