#!/bin/bash
#SBATCH -J makeFileList   # name of the job
#SBATCH --mem=3G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI


touch file_name.txt    # create a file
echo BamGal4_1_TAMA.collapsed_forMerge.bed > file_name.txt
echo BamGal4_2_TAMA.collapsed_forMerge.bed >> file_name.txt
echo KmgKD_1_TAMA.collapsed_forMerge.bed >> file_name.txt
echo KmgKD_2_TAMA.collapsed_forMerge.bed >> file_name.txt


touch cap_flag.txt    # create a file
echo capped > cap_flag.txt
echo capped >> cap_flag.txt
echo capped >> cap_flag.txt
echo capped >> cap_flag.txt


touch merge_priority.txt    # create a file
echo 1,1,1 > merge_priority.txt
echo 1,1,1 >> merge_priority.txt
echo 1,1,1 >> merge_priority.txt
echo 1,1,1 >> merge_priority.txt

# do not put "_" on names
touch source_name.txt    # create a file
echo BamGal4rep1 > source_name.txt
echo BamGal4rep2 >> source_name.txt
echo KmgKDrep1 >> source_name.txt
echo KmgKDrep2 >> source_name.txt

paste file_name.txt cap_flag.txt merge_priority.txt source_name.txt > filelist_BamGal4_KmgKD.txt
