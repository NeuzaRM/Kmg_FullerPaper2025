#!/bin/bash
#SBATCH -J fastQC   # name of the job
#SBATCH --mem=30G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI


cd $SLURM_SUBMIT_DIR     # all the output of the file will be in the same directory as the .sh script


#module add fastqc  # so the system knows where to find fastqc
#module list

#mkdir -p fastQC


########################
# gunzip *.gz
########################

fastqc *.fastq --outdir fastQC  # run quality control in all samples, output to fastQC folder
