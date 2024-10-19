#!/bin/bash
#SBATCH -J tama_collapse   # name of the job
#SBATCH --mem=20G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --array=0


cd $SLURM_SUBMIT_DIR     # all the output of the file will be in the same directory as the .sh script

module load samtools
module load tama/b0.0.0
module list

#module load cufflinks/2.2.1

#module load biopython/1.70
#module load pysam


#####################
# in line 7 (#SBATCH --array=0-9), note counting starts from 0 now!, if have more than 1 libraries, for example, 3 libraries (each have R1 and R2 for paired end) change 0-10 to 0-2.

name_list=(*aligned.sorted.bam) # make a list of all input files in the folder

Input=${name_list[$SLURM_ARRAY_TASK_ID]} # don't change this line
# take the nth ($SGE_TASK_ID-th) file in name_list


Output=`echo $Input | sed 's/aligned.sorted.bam/_TAMA.collapsed/'`

reference_fasta=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Drosophila_melanogaster.BDGP6.32.dna.toplevel.fa  # location in cluster

#####################
# https://github.com/GenomeRIK/tama/wiki/Tama-Collapse
#####################


tama_collapse.py \
-s $Input \
-b BAM \
-f $reference_fasta \
-p $Output \
-e common_ends \
-x capped \
-a 78 \
-m 10 \
-z 80 \
-sj sj_priority \
-vc 5 \
-log log_off

# Our libraries are not 5'capped, but I don't want them to collaps the 5'ends too much.
# I will then filter based on CAGE

# -a 78 # CAGEseq parallel analysis: 70bp cluster interquantile width that includes 90% of clusters
# -z 80 # 3'seq parallel analysis: 56bp cluster interquantile width that includes 90% of clusters


#-h, --help  show this help message and exit
#  -s S        Sorted sam/bam file (required)(if using BAM file please use -b BAM flag as well)
#  -f F        Fasta file (required)
#  -p P        Output prefix (required)
#  -x X        Capped flag: capped or no_cap
#  -e E        Collapse exon ends flag: common_ends or longest_ends (default common_ends)
#  -c C        Coverage (default 99)
#  -i I        Identity (default 85)
#  -icm ICM    Identity calculation method (default ident_cov for including coverage) (alternate is ident_map for excluding hard and soft clipping)
#  -a A        5 prime threshold (default 10)
#  -m M        Exon/Splice junction threshold (default 10)
#  -z Z        3 prime threshold (default 10)
#  -d D        Flag for merging duplicate transcript groups (default is merge_dup will merge duplicates ,no_merge quits when duplicates are found)
# -sj SJ      Use error threshold to prioritize the use of splice junction information from collapsing transcripts(default no_priority, activate with sj_priority)
# -sjt SJT    Threshold for detecting errors near splice junctions (default is 10bp)
#  -lde LDE    Threshold for amount of local density error near splice junctions that is allowed (default is 1000 errors which practically means no threshold is applied)
#  -ses SES    Simple error symbol. Use this to pick the symbol used to represent matches in the simple error string for LDE output.
#  -b   BAM    Use BAM instead of SAM
#  -log LOG    Turns off long log output of collapsing process. (default on, use log_off to turn off)
#  -v   V      Prints out version date and exits.
#  -rm  RM     Run mode allows you to use original or low_mem mode, default is original
#  -vc  VC     Variation coverage threshold: Default 5 reads


#https://github.com/GenomeRIK/tama/discussions/44

#python tama_convert_bed_gtf_ensembl_no_cds.py bed_file output_file

name_list2=(*_TAMA.collapsed.bed) # make a list of all input files in the folder

Input2=${name_list2[$SLURM_ARRAY_TASK_ID2]} # don't change this line
# take the nth ($SGE_TASK_ID-th) file in name_list

Output2=`echo $Input2 | sed 's/_TAMA.collapsed.bed/_TAMA.collapsed.gtf/'`


python /scg/apps/software/tama/b0.0.0/tama/tama_go/format_converter/tama_convert_bed_gtf_ensembl_no_cds.py $Input2 $Output2
