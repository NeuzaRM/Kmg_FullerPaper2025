#!/bin/bash
#SBATCH -J BWA_index   # name of the job
#SBATCH --mem=20G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI

#run this script in the folder where the genome is:
#/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/

module add bwa

bwa index Drosophila_melanogaster.BDGP6.32.dna.toplevel.fa
