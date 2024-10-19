#!/bin/bash
#SBATCH -J bedtools   # name of the job
#SBATCH --mem=10G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI


module add bedtools/2.27.1


Input_TSS=(TAMA_merge_BamGal4_KmgKD_TSS.bed)
Input_TTS=(TAMA_merge_BamGal4_KmgKD_TTS.bed)

Output_TSS=(TAMA_merge_BamGal4_KmgKD_TSS_CAGE.bed)
Output_TTS=(TAMA_merge_BamGal4_KmgKD_TTS_3Pseq.bed)

CAGE=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/CAGE/trim_SE/consensusCluster_CAGE.bed
p3seq=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/3Pseq/consensusCluster_3Pseq.bed


bedtools intersect -a $Input_TSS -b $CAGE -wa -u -s > $Output_TSS

bedtools intersect -a $Input_TTS -b $p3seq -wa -u -s > $Output_TTS

#https://bedtools.readthedocs.io/en/latest/content/tools/intersect.html
