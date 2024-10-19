#!/bin/bash
#SBATCH -J trim_PE   # name of the job
#SBATCH --mem=20G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --array=0-22


cd $SLURM_SUBMIT_DIR     # all the output of the file will be in the same directory as the .sh script


module purge
unset PERL5LIB
unset PYTHONPATH
module load anaconda
source activate trimgalore_0.4.5

module list

mkdir -p trim_PE # make directory for output


#####################
# in line 7 (#SBATCH --array=0-9), note counting starts from 0 now!, if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change to 0-2.

name_list=(*L1_1*.fq) # make a list of all fastq files in the folder which has "R1" (read 1) in file name
# name_list=(a.fastq b.fastq) # or write a full list of fastq files

Input1=${name_list[$SLURM_ARRAY_TASK_ID]} # don't change this line
# take the nth ($SGE_TASK_ID-th) file in name_list

Input2=`echo $Input1 | sed 's/L1_1/L1_2/'`
# replace R1 in name of read 1 to generate file name of read 2
#####################


trim_galore --quality 20 --stringency 1 --length 20 --paired_end $Input1 $Input2 --output_dir trim_PE/
# At 3' end, trim off bases that has quality < 20 (default), 20 means that there is 1% of change the base is incorrectly identified

# Then at 3' end, trim off bases that has >=1bp overlap with the adapter sequence. The adapter sequence is automatically identified by the program
##### The NEBNext libraries for Illumina resemble TruSeq libraries and can be trimmed like TruSeq:
#Adaptor Read1   AGATCGGAAGAGCACACGTCTGAACTCCAGTCA
#Adaptor Read2   AGATCGGAAGAGCGTCGTGTAGGGAAAGAGTGT

# Discard reads shorter than 20bp after trimming. The cutoff is arbituary, but short than this won't map efficiently

# 'paired_end' mode keeps mate-to-mate correspondence, meaning that if read 1 is deleted, read 2 will be deleted too. that's why the input needs to include both R1.fastq and R2.fastq

# output all files in trim_PE folder
