
#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 2
#SBATCH -t 16:00:00
#SBATCH -J canu_job
#SBATCH --mail-type=ALL
#SBATCH --mail-user Erika.Lindberg.3300@student.uu.se
# Load modules
module load bioinfo-tools
module load canu 

# Your commands
export outdir = /home/erikali/Genome_analysis_VT23/analyses/01_DNA_ass
canu -num_threads 2 \
-d outdir \
-p ass_L_Ferriphilum \
useGrid=false \
genomeSize=2.41 \
-pacbio-raw /home/erikali/Genome_analysis_VT23/data/raw_data/DNA_raw_data/*.fastq.gz




