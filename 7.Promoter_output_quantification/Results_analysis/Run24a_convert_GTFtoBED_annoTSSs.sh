#!/bin/bash
#SBATCH -J GTFtoBED   # name of the job
#SBATCH --mem=20G     # reserve 3G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI


module add python/2.7


reference_gtf=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Drosophila_melanogaster.BDGP6.32.109.gtf

#output file will be "reference_gtf_transcriptCoordinates.bed"


python GTFtoBED_annoTSSs.py $reference_gtf
