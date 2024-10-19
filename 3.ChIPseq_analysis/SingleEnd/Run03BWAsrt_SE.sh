#!/bin/bash
#SBATCH -J BWA_srt   # name of the job
#SBATCH --mem=20G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --array=0-15



module add bwa
module add samtools

module list

cd $SLURM_SUBMIT_DIR
cd trim_SE

#####################
# in line 7 (#SBATCH --array=0-9), note counting starts from 0 now!, if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 0-9 to 0-2.

genome=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Drosophila_melanogaster.BDGP6.32.dna.toplevel.fa
echo $genome


name_list=(*.fq) # make a list of all R1.fastq files in the folder

Input1=${name_list[$SLURM_ARRAY_TASK_ID]} # don't change this. take the nth ($SGE_TASK_ID-th) file in name_list

OutputSam=`echo $Input1 | sed 's/.fq/_SE.sam/'`
####################


Output1=`echo $Input1 | sed 's/.fq/.sai/'`

echo $Output1
echo $Input1

bwa aln $genome $Input1 > $Output1

echo $OutputSam

bwa samse $genome $Output1 $Input1 > $OutputSam

#samse 	bwa samse [-n maxOcc] <in.db.fasta> <in.sai> <in.fq> > <out.sam>
#Generate alignments in the SAM format given single-end reads. Repetitive hits will be randomly chosen.



OutputTemp=`echo $OutputSam | sed 's/.sam/.temp/'`
echo $OutputTemp

Output3=`echo $OutputSam | sed 's/.sam/.nsrt.bam/'`
echo $Output3
samtools sort -O bam -o $Output3 -n -T $OutputTemp $OutputSam

Output4=`echo $Output3 | sed 's/.bam/.fxm.bam/'`
echo $Output4
samtools fixmate -O bam $Output3 $Output4
## don't remove unmapped reads here (-r), picard will complain pair info is incorrect

Output5=`echo $Output4 | sed 's/.bam/.srt.bam/'`
echo $Output5
samtools sort -O bam -o $Output5 -T $OutputTemp $Output4
