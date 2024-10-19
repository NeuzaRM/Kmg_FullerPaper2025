#!/bin/bash
#SBATCH -J kallisto   # name of the job
#SBATCH --mem=1G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 1:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI


cp /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/SQANTI3_filtered/STAR_index/chrNameLength.txt /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/SQANTI3_filtered/tappAS/
