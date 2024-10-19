#!/bin/bash
#SBATCH -J Map_pass1   # name of the job
#SBATCH --mem-per-cpu=40G     # reserve 30G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --cpus-per-task=4
#SBATCH --array=0-3


module add star/2.7.9a


cd trim_PE  # change directory to where trimmed reads are


###################
# change number of libraries in line 8 (#SBATCH --array=0-9), note counting starts from 0 now!

star_index=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/STAR_indexed_wGTF  # indexed genome location

name_list=(*_R1*.fq) # make a list of all R1.fastq files in the folder

Input1_trimmed=${name_list[$SLURM_ARRAY_TASK_ID]} # don't change this line
# take the nth ($SGE_TASK_ID-th) file in name_list

Input2_trimmed=`echo $Input1_trimmed | sed 's/_R1_val_1/_R2_val_2/'`   # replace R1 in name of read 1 to generate file name of read 2
####################




mkdir -p star_pass1  # create directory for STAR pass 1 output
pass1_prefix=star_pass1/${Input1_trimmed%.*}_  # prefix for pass 1 outputs


STAR --runThreadN 4 \
--runMode alignReads \
--genomeDir $star_index \
--alignSJoverhangMin 10 \
--alignIntronMax 100000 \
--alignMatesGapMax 100000 \
--outFilterMismatchNoverLmax 0.04 \
--readFilesIn $Input1_trimmed $Input2_trimmed \
--outFileNamePrefix $pass1_prefix \
--outSAMtype None


# STAR --runThreadN 4 \  # use 4 threads in parallell
# --runMode alignReads \  # align reads
# --genomeDir $star_index \  # where the index is
# --alignSJoverhangMin 10 \  # for reads spanning splice junctions, need to have > 10bp align to both exons to be included in output
# --alignIntronMax 100000 \  # maximum intron length. Minimum is 21bp by default.
# --alignMatesGapMax 100000 \  # maximum distance between reads in a pair

# --outFilterMismatchNoverLmax 0.04 \  # max mismatch allowed = read lenght x 0.04
# --readFilesIn $Input1_trimmed $Input2_trimmed \  # read 1 and read 2 input files
# --outFileNamePrefix $pass1_prefix \  # output prefix
# --outSAMtype None  # don't output the bam file, since the goal of pass 1 is to generate the splice junction file
