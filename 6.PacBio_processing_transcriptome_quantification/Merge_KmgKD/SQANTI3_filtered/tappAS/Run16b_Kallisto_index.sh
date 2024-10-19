#!/bin/bash
#SBATCH -J kallisto   # name of the job
#SBATCH --mem=100G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI


module load kallisto


cd $SLURM_SUBMIT_DIR     # all the output of the file will be in the same directory as the .sh script

###########
#https://pachterlab.github.io/kallisto/starting
###########

SQANTI3_fasta=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/SQANTI3_filtered/TAMA_merge_BamGal4_KmgKD_corrected_filtered_corrected.fasta

#########

kallisto index -i transcripts.idx $SQANTI3_fasta
