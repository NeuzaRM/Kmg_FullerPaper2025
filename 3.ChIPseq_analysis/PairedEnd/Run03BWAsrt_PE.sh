#!/bin/bash
#SBATCH -J BWA_srt   # name of the job
#SBATCH --mem=20G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --array=0-22



module add bwa
module add samtools

module list

cd $SLURM_SUBMIT_DIR
cd trim_PE

#####################
# in line 7 (#SBATCH --array=0-9), note counting starts from 0 now!, if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 0-9 to 0-2.

genome=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Drosophila_melanogaster.BDGP6.32.dna.toplevel.fa
echo $genome


name_list=(*L1_1_val_1.fq) # make a list of all R1.fastq files in the folder

Input1=${name_list[$SLURM_ARRAY_TASK_ID]} # don't change this line
# take the nth ($SGE_TASK_ID-th) file in name_list

Input2=`echo $Input1 | sed 's/L1_1_val_1/L1_2_val_2/'`   # replace R1 in name of read 1 to generate file name of read 2

OutputSam=`echo $Input1 | sed 's/L1_1_val_1.fq/_PE.sam/'`
#####################



Output1=`echo $Input1 | sed 's/.fq/.sai/'`
Output2=`echo $Input2 | sed 's/.fq/.sai/'`

bwa aln $genome $Input1 > $Output1
bwa aln $genome $Input2 > $Output2

bwa sampe $genome $Output1 $Output2 $Input1 $Input2 > $OutputSam



OutputTemp=`echo $OutputSam | sed 's/.sam/.temp/'`
echo $OutputTemp

Output3=`echo $OutputSam | sed 's/.sam/.nsrt.bam/'`
echo $Output3
samtools sort -O bam -o $Output3 -n -T $OutputTemp $OutputSam

Output4=`echo $Output3 | sed 's/.bam/.fxm.bam/'`
echo $Output4
samtools fixmate -O bam $Output3 $Output4
#Convert SAM files to BAM files and fix read pairing information and flags
## don't remove unmapped reads here (-r), picard will complain pair info is incorrect

Output5=`echo $Output4 | sed 's/.bam/.srt.bam/'`
echo $Output5
samtools sort -O bam -o $Output5 -T $OutputTemp $Output4
