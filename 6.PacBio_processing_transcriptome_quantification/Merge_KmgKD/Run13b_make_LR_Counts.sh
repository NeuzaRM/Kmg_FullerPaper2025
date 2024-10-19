#!/bin/bash
#SBATCH -J makeLRcounts   # name of the job
#SBATCH --mem=10G     # reserve 10G (per processor) of memory for the job
#SBATCH --cpus-per-task=8
#SBATCH -t 2:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --array=0-3

module add python/2.7
module list

cd $SLURM_SUBMIT_DIR     # all the output of the file will be in the same directory as the .sh script


name_list1=(*clustered.cluster_report.csv) # make a list of all input files in the folder

file1=${name_list1[$SLURM_ARRAY_TASK_ID]} # don't change this line
# take the nth ($SGE_TASK_ID-th) file in name_list


file2=`echo $file1 | sed 's/clustered.cluster_report.csv/TAMA.collapsed_trans_read.bed/'`

#MakingTable1_2_3

python MakingTable1_2_3.py $file1 $file2


#file1 should be: *clustered.cluster_report.csv: output of Run04_SMARTLink_isoseq3_cluster_CCS.sh
#file2 should be: *TAMA.collapsed_trans_read.bed: output of Run06_TAMA_collapse.sh

#it will output 3 files
#*readID_Isoseq3ClusteredTranscriptID_TAMAcollapseID.txt <-- this is table 1
#*TAMAcollapseID_readCounts.txt <-- this is table 2
#*TAMAcollapseID_readCounts_forSQANTI3.txt <-- this is table 3
