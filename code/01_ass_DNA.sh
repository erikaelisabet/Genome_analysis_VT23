#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 4
#SBATCH -t 16:00:00
#SBATCH -J canu_job
#SBATCH --mail-type=ALL
#SBATCH --mail-user Erika.Lindberg.3300@student.uu.se

# Load modules
module load bioinfo-tools
module load canu 

# Your commands
OUTPUTPATH="/home/erikali/Genome_analysis_VT23/analyses/01_DNA_ass"
INPUT="/proj/genomeanalysis2023/Genome_Analysis/2_Christel_2017/DNA_raw_data/ERR2028*.fastq.gz"

canu -d $OUTPUTPATH -p LFerriphilum genomeSize=2.6m useGrid=false maxThreads=4 -raw -pacbio $INPUT




