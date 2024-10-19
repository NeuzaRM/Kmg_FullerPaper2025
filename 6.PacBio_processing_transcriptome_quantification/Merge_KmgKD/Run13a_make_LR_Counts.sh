#!/bin/bash
#SBATCH -J makeLRcounts   # name of the job
#SBATCH --mem=10G     # reserve 10G (per processor) of memory for the job
#SBATCH --cpus-per-task=8
#SBATCH -t 2:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
# copy files to Merge folder, from individual sample folders, and add samplePrefix

cp /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/BamGal4_1/*clustered.cluster_report.csv /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/BamGal4_1_clustered.cluster_report.csv
cp /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/BamGal4_2/*clustered.cluster_report.csv /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/BamGal4_2_clustered.cluster_report.csv
cp /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/KmgKD_BamGal4_1/*clustered.cluster_report.csv /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/KmgKD_BamGal4_1_clustered.cluster_report.csv
cp /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/KmgKD_BamGal4_2/*clustered.cluster_report.csv /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/KmgKD_BamGal4_2_clustered.cluster_report.csv

# I had copyed the *TAMA.collapsed_trans_read.bed of KmgKD with a weird name. So I'm copying those again:
cp /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/KmgKD_BamGal4_1/*TAMA.collapsed_trans_read.bed /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/KmgKD_BamGal4_1_TAMA.collapsed_trans_read.bed
cp /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/KmgKD_BamGal4_2/*TAMA.collapsed_trans_read.bed /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/KmgKD_BamGal4_2_TAMA.collapsed_trans_read.bed
