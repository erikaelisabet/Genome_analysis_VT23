#!/bin/bash -l
#SBATCH -A uppmax2023-2-8
#SBATCH -M snowy
#SBATCH -p core
#SBATCH -n 1
#SBATCH -t 00:30:00
#SBATCH -J 01_qual_DNA
#SBATCH --mail-type=ALL
#SBATCH --mail-user Erika.Lindberg.3300@student.uu.se
# Load modules
module load bioinfo-tools
module load FastQC/0.11.8

# Your commands
<Command_1...>


<Command_2...>
