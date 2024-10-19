#!/bin/bash
#SBATCH -J FixGFF3   # name of the job
#SBATCH --mem=10G     # reserve 10G (per processor) of memory for the job
#SBATCH --cpus-per-task=8
#SBATCH -t 2:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI


module add python/2.7


file1=./*_classification.txt

file2=./*.gff3

# make sure argument #1 is the classification file form SQANTI3 output, with the
#                          naming convention of "*_classfication.txt"
# make sure argument #2 is the GFF3 file you want to fix, with the naming
#                          convention of "*_tappAS.gff3"

python FixGFF3_for_tappAS.py $file1 $file2
