#!/bin/bash
#SBATCH -J SMARTLink_lima   # name of the job
#SBATCH --mem=20G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --array=0



module load lima
module list


#####################
# in line 7 (#SBATCH --array=0-9), note counting starts from 0 now!, if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 0-10 to 0-2.

name_list=(*hifi_reads.bam) # make a list of all input files in the folder


Input=${name_list[$SLURM_ARRAY_TASK_ID]} # don't change this line


Output=`echo $Input | sed 's/hifi_reads.bam/fl.bam/'`

#####################

lima \
  $Input \
  IsoSeqPrimers_v2.fasta \
  $Output \
  --isoseq

  #--peek-guess

  # https://www.pacb.com/wp-content/uploads/SMRT_Tools_Reference_Guide_v90.pdf
