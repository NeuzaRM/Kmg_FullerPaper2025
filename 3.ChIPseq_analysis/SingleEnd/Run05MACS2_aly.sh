#!/bin/bash
#SBATCH -J MACS2   # name of the job
#SBATCH --mem=20G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI


module add MACS2

cd trim_SE



macs2 callpeak \
-t JK2666_ChIP-antiHA-AlyHAWT-rep1-TAGCTTGT_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-c JK2666_Input-antiHA-AlyHAWT-rep1-CAGATCTG_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-f BAM \
-g 1.2e8 \
--name ChIP_AlyHA_WT_rep1 \
--outdir macs2_aly \
--tsize 75 \
--keep-dup auto \
--nomodel --extsize 220 \
--nomodel \
-B


macs2 callpeak \
-t JK4380_ChIP-antiHA-AlyHAWT-rep2-TTAGGCAT_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-c JK4380_Input-antiHA-AlyHAWT-rep2-ATCACGTT_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-f BAM \
-g 1.2e8 \
--name ChIP_AlyHA_WT_rep2 \
--outdir macs2_aly \
--tsize 75 \
--keep-dup auto \
--nomodel --extsize 220 \
--nomodel \
-B


macs2 callpeak \
-t JK2666_ChIP-antiHA-AlyHAkmgKD-rep1-CTTGTACT_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-c JK2666_Input-antiHA-AlyHAkmgKD-rep1-GATCAGCG_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-f BAM \
-g 1.2e8 \
--name ChIP_AlyHA_KmgKD_rep1 \
--outdir macs2_aly \
--tsize 75 \
--keep-dup auto \
--nomodel --extsize 220 \
--nomodel \
-B


macs2 callpeak \
-t JK4380_ChIP-antiHA-AlyHAkmgKD-rep2-TGACCACT_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-c JK4380_Input-antiHA-AlyHAkmgKD-rep2-CGATGTTT_trimmed_SE.nsrt.fxm.srt.Q20.chr.bam \
-f BAM \
-g 1.2e8 \
--name ChIP_AlyHA_KmgKD_rep2 \
--outdir macs2_aly \
--tsize 75 \
--keep-dup auto \
--nomodel --extsize 220 \
--nomodel \
-B
