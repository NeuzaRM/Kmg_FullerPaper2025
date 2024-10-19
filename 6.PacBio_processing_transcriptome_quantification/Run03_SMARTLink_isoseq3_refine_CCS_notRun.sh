#!/bin/bash
#SBATCH -J SMARTLink_isoseq3_refine   # name of the job
#SBATCH --mem=30G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH --cpus-per-task=8
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --array=0



module load IsoSeq/3.4.0
module list


#####################
# in line 7 (#SBATCH --array=0-9), note counting starts from 0 now!, if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 0-10 to 0-2.

# *ccs.bam if lima run scipped

name_list=(*fl.NEB_5p--NEB_Clontech_3p.bam) # make a list of all input files in the folder

Input=${name_list[$SLURM_ARRAY_TASK_ID]} # don't change this line
# take the nth ($SGE_TASK_ID-th) file in name_list


Output=`echo $Input | sed 's/fl.NEB_5p--NEB_Clontech_3p.bam/flnc.bam/'`


#####################

isoseq3 refine \
  $Input \
  IsoSeqPrimers_v2.fasta \
  $Output \
  --require-polya

  # https://www.pacb.com/wp-content/uploads/SMRT_Tools_Reference_Guide_v90.pdf
