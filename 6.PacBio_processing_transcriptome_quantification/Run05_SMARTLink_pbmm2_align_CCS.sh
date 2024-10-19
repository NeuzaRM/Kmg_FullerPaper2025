#!/bin/bash
#SBATCH -J SMARTLink_pbmm2   # name of the job
#SBATCH --mem=50G     # reserve 10G (per processor) of memory for the job
#SBATCH --cpus-per-task=16
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --array=0


module load pbmm2
module list


#####################
# in line 7 (#SBATCH --array=0-9), note counting starts from 0 now!, if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 0-10 to 0-2.

name_list=(*clustered.hq.bam) # make a list of all input files in the folder

Input=${name_list[$SLURM_ARRAY_TASK_ID]} # don't change this line
# take the nth ($SGE_TASK_ID-th) file in name_list

reference_fasta=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Drosophila_melanogaster.BDGP6.32.dna.toplevel.fa  # location in cluster

Output=`echo $Input | sed 's/clustered.hq.bam/aligned.sorted.bam/'`

#####################

pbmm2 align \
  $Input \
  $reference_fasta \
  $Output \
  --preset ISOSEQ \
  --sort

  # https://www.pacb.com/wp-content/uploads/SMRT_Tools_Reference_Guide_v90.pdf
