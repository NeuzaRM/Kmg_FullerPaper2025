#!/bin/bash
#SBATCH -J SMARTLink_isoseq3_cluster_bam   # name of the job
#SBATCH --mem=70G     # reserve 10G (per processor) of memory for the job
#SBATCH --cpus-per-task=16
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --array=0


cd $SLURM_SUBMIT_DIR     # all the output of the file will be in the same directory as the .sh script


module load IsoSeq/3.4.0
module list


#####################
# in line 8 (#SBATCH --array=0-9), note counting starts from 0 now!, if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 0-10 to 0-2.

name_list=(*flnc.bam) # make a list of all input files in the folder


Input=${name_list[$SLURM_ARRAY_TASK_ID]} # don't change this line
# take the nth ($SGE_TASK_ID-th) file in name_list


Output=`echo $Input | sed 's/flnc.bam/clustered.bam/'`

#####################

isoseq3 cluster \
  $Input \
  $Output \
  --use-qvs

  # the default POA consensus uses 10 reads, this sets it for 100 (isoseq quality)

  # https://www.pacb.com/wp-content/uploads/SMRT_Tools_Reference_Guide_v90.pdf
