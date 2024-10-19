#!/bin/bash -l
#SBATCH -J cov
#SBATCH -p standard
#SBATCH --mem=20G
#SBATCH -t 12:0:0
#SBATCH -p batch
#SBATCH --account=mtfuller
#SBATCH --cpus-per-task=1


cd $SLURM_SUBMIT_DIR

module add bedtools/2.25.0


## N: The output of CAGEr is consensusCluster.txt and not the same of the one in Dan's script "consensusCluster_UCSC.bed"
# ---Delete the first row (column names)
# ---I just changed the extension from the file to .bed
# ---I had to change the order of the columns

awk 'NR>1' consensusCluster.txt > consensusClusterV2.txt
awk -F '\t' {'print $2"\t"$3"\t"$4"\t"$1"\t"$6"\t"$5'} consensusClusterV2.txt > consensusCluster.bed

bedtools sort -i consensusCluster.bed > consensusCluster_sorted.bed

####
