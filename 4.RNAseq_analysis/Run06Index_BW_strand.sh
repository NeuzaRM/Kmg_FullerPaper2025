#!/bin/bash
#SBATCH -J index_bw   # name of the job
#SBATCH --mem=30G     # reserve 30G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --cpus-per-task=4
#SBATCH --array=0-3



module load deeptools

module add samtools
module list


cd trim_PE

####################
# change number of libraries in line 8 (#SBATCH --array=0-9), note counting starts from 0 now!

chrm_size=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Drosophila_melanogaster.BDGP6.32.dna.toplevel.fa.fai # the .fai file in the genome folder

name_list=(*.sortedByCoord.out.bam)
################


Input=${name_list[$SLURM_ARRAY_TASK_ID]}

#samtools flagstat $Input   # statistics on the bam file

#samtools index $Input   # index the bam file for fast access
#done in Run05

Output1=`echo $Input | sed 's/.bam/_fw.bw/'`
bamCoverage -b $Input -o $Output1 --normalizeUsing CPM -p 4 --binSize 1 --filterRNAstrand forward

Output2=`echo $Input | sed 's/.bam/_rv.bw/'`
bamCoverage -b $Input -o $Output2 --normalizeUsing CPM -p 4 --binSize 1 --filterRNAstrand reverse

# normalize for library size
