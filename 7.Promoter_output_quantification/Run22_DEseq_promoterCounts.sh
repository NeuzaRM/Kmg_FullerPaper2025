#!/bin/bash
#SBATCH -J DE   # name of the job
#SBATCH --mem=20G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI


cd $SLURM_SUBMIT_DIR

module add r


Rscript DESeq2_Promoters_DanyKD.R
Rscript DESeq2_Promoters_KmgKD.R
Rscript DESeq2_Promoters_Aly.R
Rscript DESeq2_Promoters_KmgKD_aly.R
Rscript DESeq2_Promoters_KmgKD_sa.R
Rscript DESeq2_Promoters_Mi2KD.R
Rscript DESeq2_Promoters_Sa.R
Rscript DESeq2_Promoters_SimjKD.R
Rscript DESeq2_Promoters_Spt5KD.R
Rscript DESeq2_Promoters_Topi.R
