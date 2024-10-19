#!/bin/bash
#SBATCH -J TAMA_merge   # name of the job
#SBATCH --mem=300G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI


module load tama/b0.0.0


cd $SLURM_SUBMIT_DIR     # all the output of the file will be in the same directory as the .sh script

###########
#https://github.com/GenomeRIK/tama/wiki/Tama-Merge
###########


tama_merge.py \
-f filelist_BamGal4_KmgKD.txt \
-p TAMA_merge_BamGal4_KmgKD \
-e common_ends \
-a 78 \
-m 10 \
-z 80 \
-d merge_dup

# same as: Run06_TAMA_collapse.sh
# -a 78 # CAGEseq parallel analysis: 70bp cluster interquantile width that includes 90% of clusters
# -z 80 # 3'seq parallel analysis: 56bp cluster interquantile width that includes 90% of clusters




#python /scg/apps/software/tama/b0.0.0/tama/tama_merge.py

#-h, --help  show this help message and exit
#  -f F        File list
#  -p P        Output prefix
#  -e E        Collapse exon ends flag: common_ends or longest_ends (Default is common_ends)
#  -a A        5 prime threshold (Default is 10)
#  -m M        Exon ends threshold/ splice junction threshold (Default is 10)
#  -z Z        3 prime threshold (Default is 10)
#  -d D        Flag for merging duplicate transcript groups (default no_merge quits when duplicates are found, merge_dup will merge duplicates)
#  -s S        Use gene and transcript ID from a merge source. Specify source name from filelist file here.
#  -cds CDS    Use CDS from a merge source. Specify source name from filelist file here.


# for building the File list:
# use cap_flag: capped
