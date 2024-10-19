#!/bin/bash
#SBATCH -J tama_go   # name of the job
#SBATCH --mem=30G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 16:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --array=0

module load samtools
module load tama/b0.0.0
module list

name_list=(*_BamGal4_KmgKD.bed) # make a list of all input files in the folder

Input=${name_list[$SLURM_ARRAY_TASK_ID]} # don't change this line
# take the nth ($SGE_TASK_ID-th) file in name_list


#https://github.com/GenomeRIK/tama/wiki/TAMA-GO:-Formatting

#python tama_convert_bed_gtf_ensembl_no_cds.py bed_file output_file


Output=`echo $Input | sed 's/.bed/.gtf/'`

python /scg/apps/software/tama/b0.0.0/tama/tama_go/format_converter/tama_convert_bed_gtf_ensembl_no_cds.py $Input $Output
