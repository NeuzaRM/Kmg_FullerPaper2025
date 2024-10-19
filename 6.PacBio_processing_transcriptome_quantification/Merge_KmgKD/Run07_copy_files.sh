#!/bin/bash
#SBATCH -J copyData   # name of the job
#SBATCH --mem=30G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH --cpus-per-task=8
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI


# copy files from individual folders to the MERGE folder. And add sample name to file name

# Copy TAMA.collapsed_trans_read.bed

cp /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/BamGal4_1/*_TAMA.collapsed_trans_read.bed /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/BamGal4_1_TAMA.collapsed_trans_read.bed
cp /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/BamGal4_2/*_TAMA.collapsed_trans_read.bed /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/BamGal4_2_TAMA.collapsed_trans_read.bed

cp /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/KmgKD_BamGal4_1/*_TAMA.collapsed_trans_read.bed /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/KmgKD_1_TAMA.collapsed_trans_read.bed
cp /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/KmgKD_BamGal4_2/*_TAMA.collapsed_trans_read.bed /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/KmgKD_2_TAMA.collapsed_trans_read.bed


# Copy TAMA.collapsed_forMerge.bed

cp /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/BamGal4_1/*_TAMA.collapsed_forMerge.bed /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/BamGal4_1_TAMA.collapsed_forMerge.bed
cp /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/BamGal4_2/*_TAMA.collapsed_forMerge.bed /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/BamGal4_2_TAMA.collapsed_forMerge.bed

cp /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/KmgKD_BamGal4_1/*_TAMA.collapsed_forMerge.bed /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/KmgKD_1_TAMA.collapsed_forMerge.bed
cp /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/KmgKD_BamGal4_2/*_TAMA.collapsed_forMerge.bed /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/KmgKD_2_TAMA.collapsed_forMerge.bed
