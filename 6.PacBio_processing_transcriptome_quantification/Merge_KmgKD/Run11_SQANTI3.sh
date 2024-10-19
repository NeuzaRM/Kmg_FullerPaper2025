#!/bin/bash
#SBATCH -J SQANTI3   # name of the job
#SBATCH --mem=100G     # reserve 10G (per processor) of memory for the job
#SBATCH --cpus-per-task=8
#SBATCH -t 30:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI

cd $SLURM_SUBMIT_DIR     # all the output of the file will be in the same directory as the .sh script

module load r/4.2.2
module load SQANTI3/5.2.1
module list


####################
# https://github.com/ConesaLab/SQANTI3/wiki/Running-SQANTI3-Quality-Control
#####################

Input=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/TAMA_merge_BamGal4_KmgKD.gtf

#Make this file manually
short_reads=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/short_reads_FileNames.fofn

#It is possible to feed SQANTI3 with your matching RNA-Seq data (FASTA/FASTQ files) through the --short_reads argument.
#The expected file format is a File Of File Names (.fofn),
#which is a text file that contains the paths of the Short-Read RNA-Seq data with
#one line per replicate and separated by one space in the case of paired-end data

######################


reference_fasta=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Drosophila_melanogaster.BDGP6.32.dna.toplevel.fa

reference_gtf=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Drosophila_melanogaster.BDGP6.32.109.gtf


#####################


sqanti3_qc.py $Input \
  $reference_gtf \
  $reference_fasta \
  --short_reads $short_reads \
  --force_id_ignore \
  --skipORF \
  --report pdf


#--force_id_ignore     Allow the usage of transcript IDs non related with PacBio's nomenclature (PB.X.Y)
# TAMA uses different ID format

#--skipORF             Skip ORF prediction (to save time and not needed now)

# https://github.com/ConesaLab/SQANTI3#exp
