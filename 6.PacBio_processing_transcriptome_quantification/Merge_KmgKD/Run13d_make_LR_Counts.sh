#!/bin/bash
#SBATCH -J makeLRcounts   # name of the job
#SBATCH --mem=10G     # reserve 10G (per processor) of memory for the job
#SBATCH --cpus-per-task=8
#SBATCH -t 2:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI


module add python/2.7


file1=./samplesFile_table5.txt

#file1: samplesFile_table5.txt - with the names of the files *TAMAcollapseID_readCounts_forSQANTI3.txt (output of Run13b_make_LR_Counts.sh)

file2=./*TAMAmergeID_TAMAcollapseID.txt

#file2: *TAMAmergeID_TAMAcollapseID.txt (output of Run13c_make_LR_Counts.sh)
#VERY IMPORTANT: make sure the order of file1 (samplesFile_table5.txt) matches the order of columns in file2

#prefix1 is the prefix you want your output to have

#it will output 1 file:
#*_LRreadCounts_forSQANTI3.txt

#python MakingTable5.py $file1 $file2 prefix1

python MakingTable5.py $file1 $file2 BamGal4_KmgKD_
