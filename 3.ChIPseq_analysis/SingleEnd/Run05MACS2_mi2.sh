#!/bin/bash
#SBATCH -J MACS2   # name of the job
#SBATCH --mem=20G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI


module add MACS2

cd trim_SE


macs2 callpeak \
-t JK2553_ChIP-antidMi2-WT-rep1-ACAGTGGT_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-c JK2553_Input-antidMi2-WT-rep1-ATCACGTT_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-f BAM \
-g 1.2e8 \
--name ChIP_Mi2_WT_rep1 \
--outdir macs2_Mi2 \
--tsize 75 \
--keep-dup auto \
--nomodel --extsize 220 \
--nomodel \
--broad \
--broad-cutoff 0.01 \
-B




macs2 callpeak \
-t JK2553_ChIP-antidMi2-WT-rep2-GCCAATGT_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-c JK2553_Input-antidMi2-WT-rep2-CGATGTTT_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-f BAM \
-g 1.2e8 \
--name ChIP_Mi2_WT_rep2 \
--outdir macs2_Mi2 \
--tsize 75 \
--keep-dup auto \
--nomodel --extsize 220 \
--nomodel \
--broad \
--broad-cutoff 0.01 \
-B




macs2 callpeak \
-t JK2553_ChIP-antidMi2-kmgKD-rep1-CAGATCTG_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-c JK2553_Input-antidMi2-kmgKD-rep1-TTAGGCAT_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-f BAM \
-g 1.2e8 \
--name ChIP_Mi2_KmgKD_rep1 \
--outdir macs2_Mi2 \
--tsize 75 \
--keep-dup auto \
--nomodel --extsize 220 \
--nomodel \
--broad \
--broad-cutoff 0.01 \
-B




macs2 callpeak \
-t JK2553_ChIP-antidMi2-kmgKD-rep2-ACTTGATG_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-c JK2553_Input-antidMi2-kmgKD-rep2-TGACCACT_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-f BAM \
-g 1.2e8 \
--name ChIP_Mi2_KmgKD_rep2 \
--outdir macs2_Mi2 \
--tsize 75 \
--keep-dup auto \
--nomodel --extsize 220 \
--nomodel \
--broad \
--broad-cutoff 0.01 \
-B


# narrow

macs2 callpeak \
-t JK2553_ChIP-antidMi2-WT-rep1-ACAGTGGT_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-c JK2553_Input-antidMi2-WT-rep1-ATCACGTT_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-f BAM \
-g 1.2e8 \
--name ChIP_Mi2_WT_rep1_narrow \
--outdir macs2_Mi2 \
--tsize 75 \
--keep-dup auto \
--nomodel --extsize 220 \
--nomodel \
-B




macs2 callpeak \
-t JK2553_ChIP-antidMi2-WT-rep2-GCCAATGT_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-c JK2553_Input-antidMi2-WT-rep2-CGATGTTT_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-f BAM \
-g 1.2e8 \
--name ChIP_Mi2_WT_rep2_narrow \
--outdir macs2_Mi2 \
--tsize 75 \
--keep-dup auto \
--nomodel --extsize 220 \
--nomodel \
-B




macs2 callpeak \
-t JK2553_ChIP-antidMi2-kmgKD-rep1-CAGATCTG_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-c JK2553_Input-antidMi2-kmgKD-rep1-TTAGGCAT_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-f BAM \
-g 1.2e8 \
--name ChIP_Mi2_KmgKD_rep1_narrow \
--outdir macs2_Mi2 \
--tsize 75 \
--keep-dup auto \
--nomodel --extsize 220 \
--nomodel \
-B




macs2 callpeak \
-t JK2553_ChIP-antidMi2-kmgKD-rep2-ACTTGATG_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-c JK2553_Input-antidMi2-kmgKD-rep2-TGACCACT_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-f BAM \
-g 1.2e8 \
--name ChIP_Mi2_KmgKD_rep2_narrow \
--outdir macs2_Mi2 \
--tsize 75 \
--keep-dup auto \
--nomodel --extsize 220 \
--nomodel \
-B
