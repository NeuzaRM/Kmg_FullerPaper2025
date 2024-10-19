#!/bin/bash
#SBATCH -J bedtools   # name of the job
#SBATCH --mem=10G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI


module add bedtools/2.27.1


Input_TSS=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/TAMA_merge_BamGal4_KmgKD_TSS.bed

cCluster=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/CAGE/trim_SE/consensusCluster_CAGE.bed
CtrlCluster=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/CAGE/trim_SE/CtrlCluster_CAGE.bed
KmgKDCluster=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/CAGE/trim_SE/KmgKDCluster_CAGE.bed


Output_TSS_cCluster=(TAMA_merge_BamGal4_KmgKD_TSS_cClusterID.bed)

Output_cCluster_CtrlCluster=(cCluster_CtrlClusterID.bed)

Output_cCluster_KmgKDCluster=(cCluster_KmgKDClusterID.bed)



bedtools intersect -a $Input_TSS -b $cCluster -loj -s > $Output_TSS_cCluster

bedtools intersect -a $cCluster -b $CtrlCluster -loj -s > $Output_cCluster_CtrlCluster

bedtools intersect -a $cCluster -b $KmgKDCluster -loj -s > $Output_cCluster_KmgKDCluster

#https://bedtools.readthedocs.io/en/latest/content/tools/intersect.html
