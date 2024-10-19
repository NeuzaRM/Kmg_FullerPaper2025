#!/bin/bash

#SBATCH -J Trimming   # name of the job
#SBATCH --mem=20G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --array=0-3 #modify this depending on your sample number


module load star/2.7.9a
module load samtools
module load fastqc
module load bbmap
module load deeptools


ml samtools
ml seqtk


name_list=(*_R1_001.fastq) # make a list of all fastq files in the folder which has "R1" (read 1) in file name
# name_list=(a.fastq b.fastq) # or write a full list of fastq files
Input=${name_list[$SLURM_ARRAY_TASK_ID]} # don't change this line
# take the nth ($SGE_TASK_ID-th) file in name_list

Output=`echo $Input | sed 's/_R1_001.fastq/_R1_001_trimmed_clean.fastq/'`


#### check the result with a browser
######## preparation for mapping
######## preparation for mapping

### remove the adapter contamination, polyA read through, and low quality tails
cat $Input | bbduk.sh in=stdin.fq out=$Output ref=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/3Pseq/polyA.fa.gz,/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/3Pseq/truseq.fa k=13 ktrim=r useshortkmers=t mink=5 qtrim=t trimq=10 minlength=20 int=f
#if you want to remove polyA from reads add /labs/mtfuller/Lorenzo/3seq-resources/polyA.fa.gz to ref
###################
