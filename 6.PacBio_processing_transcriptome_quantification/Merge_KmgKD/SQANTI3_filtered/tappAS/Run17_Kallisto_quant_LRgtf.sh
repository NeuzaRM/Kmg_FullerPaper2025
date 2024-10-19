#!/bin/bash
#SBATCH -J kallisto   # name of the job
#SBATCH --mem=100G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 36:0:0    # the job will be killed after 24hr if still not completed
#SBATCH --cpus-per-task=8
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI

module load kallisto

cd $SLURM_SUBMIT_DIR     # all the output of the file will be in the same directory as the .sh script

###########
#https://pachterlab.github.io/kallisto/starting
###########

#use the gtf output from SQANTI3 (corrected and filtered)

LR_gtf=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/SQANTI3_filtered/TAMA_merge_BamGal4_KmgKD_corrected_filtered_corrected.gtf

chrom=/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Merge_KmgKD/SQANTI3_filtered/tappAS/chrNameLength.txt


#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_BamGal4_1 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/BamGal4_1_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/BamGal4_1_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_BamGal4_2 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/BamGal4_2_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/BamGal4_2_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_KmgKD_1 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/KmgKD__1_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/KmgKD__1_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_KmgKD_2 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/KmgKD__2_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/KmgKD__2_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_DanyKD_1 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/DanyKD__1_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/DanyKD__1_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_DanyKD_2 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/DanyKD__2_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/DanyKD__2_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_Mi2KD_1 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Mi2KD__1_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Mi2KD__1_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_Mi2KD_2 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Mi2KD__2_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Mi2KD__2_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_Topi_1 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Topi_1_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Topi_1_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_Topi_2 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Topi_2_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Topi_2_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_Spt5KD_1 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Spt5KD_1_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Spt5KD_1_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_Spt5KD_2 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Spt5KD_2_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Spt5KD_2_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_Sa_1 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Sa_1_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Sa_1_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_Sa_2 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Sa_2_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Sa_2_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_Topi_1 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Topi_1_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Topi_1_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_Topi_2 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Topi_2_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/Topi_2_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_Aly_1 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/aly_1_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/aly_1_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_Aly_2 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/aly_2_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/aly_2_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_SimjKD_1 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/SimjKD__1_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/SimjKD__1_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_SimjKD_2 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/SimjKD__2_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/SimjKD__2_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_KmgKD_sa_1 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/KmgKD_sa_1_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/KmgKD_sa_1_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_KmgKD_sa_2 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/KmgKD_sa_2_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/KmgKD_sa_2_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_KmgKD_aly_1 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/KmgKD-aly-1_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/KmgKD-aly-1_R2.fastq

#####################

kallisto quant \
-i transcripts.idx \
-b 30 \
-o kallisto_out_KmgKD_aly_2 \
--gtf $LR_gtf \
--chromosomes $chrom \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/KmgKD-aly-2_R1.fastq \
/labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/Other_KDs/KmgKD-aly-2_R2.fastq
