#!/bin/bash
#SBATCH -J bedtools   # name of the job
#SBATCH --mem=10G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI


module add bedtools/2.27.1


Input_TSS=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/SQANTI3_filtered/tappAS/tappAS_outputs/Promoter_quantif/Results_analysis/Drosophila_melanogaster.BDGP6.32.109_TSScoordinates.bed

Output_TSS_cCluster=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/SQANTI3_filtered/tappAS/tappAS_outputs/Promoter_quantif/Results_analysis/Drosophila_melanogaster.BDGP6.32.109_TSS_cCluster.bed


cCluster=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/CAGE/trim_SE/consensusCluster_CAGE.bed

bedtools intersect -a $Input_TSS -b $cCluster -loj -s > $Output_TSS_cCluster

#https://bedtools.readthedocs.io/en/latest/content/tools/intersect.html
