#!/bin/bash
#SBATCH -J GTF_filter   # name of the job
#SBATCH --mem=10G     # reserve 10G (per processor) of memory for the job
#SBATCH --cpus-per-task=8
#SBATCH -t 2:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI

cd $SLURM_SUBMIT_DIR     # all the output of the file will be in the same directory as the .sh script

module add python/2.7


filtered_transcripts=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/filtered_transcripts.txt

gtf_file=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/TAMA_merge_BamGal4_KmgKD_corrected.gtf


python GTF_filter.py $filtered_transcripts $gtf_file

#filtered_transcripts: output of Run12c_filter_SQANTI3.R.
#gtf_file that we want to filter: output of Run11_SQANTI3.sh

#make sure this script is in the same folder as file1 and 2

#it will output 1 file
#*_corrected_filtered.gtf
