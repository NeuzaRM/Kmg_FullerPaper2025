#!/bin/bash
#SBATCH -J makeLRcounts   # name of the job
#SBATCH --mem=10G     # reserve 10G (per processor) of memory for the job
#SBATCH --cpus-per-task=8
#SBATCH -t 2:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI


module add python/2.7


file1=./*_merge.txt

file2=./samplesFile_table4.txt

python MakingTable4.py $file1 $file2

#file1 is the  *_merge.txt: output of Run09_TAMA_merge.sh
#make sure argument #2 is the samplesFile_table4.txt file that have the name of each condition type, which is the prefix of "*_TAMAcollapseID_readCounts_forSQANTI3.txt"

#it will output 1 file
#*TAMAmergeID_TAMAcollapseID.txt <-- this is table 4
