#!/bin/bash
#SBATCH -J gtf2bed   # name of the job
#SBATCH --mem=3G     # reserve 3G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --array=0

module load tama/b0.0.0


#https://github.com/GenomeRIK/tama/wiki/TAMA-GO:-Formatting

#python tama_convert_bed_gtf_ensembl_no_cds.py bed_file output_file


name_list=(*_TAMA.collapsed.gtf) # make a list of all input files in the folder

Input=${name_list[$SLURM_ARRAY_TASK_ID]} # don't change this line
# take the nth ($SGE_TASK_ID-th) file in name_list


Output=`echo $Input | sed 's/_TAMA.collapsed.gtf/_TAMA.collapsed_forMerge.bed/'`

python /scg/apps/software/tama/b0.0.0/tama/tama_go/format_converter/tama_format_gtf_to_bed12_ensembl.py $Input $Output
