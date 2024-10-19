#!/bin/bash
#SBATCH -J MACS2   # name of the job
#SBATCH --mem=20G     # reserve 10G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI


module add MACS2

cd trim_PE

# Kmg, Dany bind along gene body of many genes. That's why I'm using --broad
# These are all PE reads


macs2 callpeak \
-t ChIPaKmg_WT_rep1__PE.nsrt.fxm.srt.Q20.chr.bam \
-c INPUTaKmg_WT_rep1__PE.nsrt.fxm.srt.Q20.chr.bam \
-f BAMPE \
-g 1.2e8 \
--name ChIP_Kmg_WT_rep1_narrow \
--outdir macs2_narrow \
--keep-dup auto \
--nomodel \
-B



macs2 callpeak \
-t ChIPaKmg_WT_rep2__PE.nsrt.fxm.srt.Q20.chr.bam \
-c INPUTaKmg_WT_rep2__PE.nsrt.fxm.srt.Q20.chr.bam \
-f BAMPE \
-g 1.2e8 \
--name ChIP_Kmg_WT_rep2_narrow \
--outdir macs2_narrow \
--keep-dup auto \
--nomodel \
-B


macs2 callpeak \
-t ChIPaKmg_Mi2KD_rep1__PE.nsrt.fxm.srt.Q20.chr.bam \
-c INPUTaKmg_Mi2KD_rep1__PE.nsrt.fxm.srt.Q20.chr.bam \
-f BAMPE \
-g 1.2e8 \
--name ChIP_Kmg_Mi2KD_rep1_narrow \
--outdir macs2_narrow \
--keep-dup auto \
--nomodel \
-B



macs2 callpeak \
-t ChIPaKmg_Mi2KD_rep2__PE.nsrt.fxm.srt.Q20.chr.bam \
-c INPUTaKmg_Mi2KD_rep2__PE.nsrt.fxm.srt.Q20.chr.bam \
-f BAMPE \
-g 1.2e8 \
--name ChIP_Kmg_Mi2KD_rep2_narrow \
--outdir macs2_narrow \
--keep-dup auto \
--nomodel \
-B




macs2 callpeak \
-t ChIPaKmg_DanyKD_rep1__PE.nsrt.fxm.srt.Q20.chr.bam \
-c INPUTaKmg_DanyKD_rep1__PE.nsrt.fxm.srt.Q20.chr.bam \
-f BAMPE \
-g 1.2e8 \
--name ChIP_Kmg_DanyKD_rep1_narrow \
--outdir macs2_narrow \
--keep-dup auto \
--nomodel \
-B



macs2 callpeak \
-t ChIPaKmg_DanyKD_rep2__PE.nsrt.fxm.srt.Q20.chr.bam \
-c INPUTaKmg_DanyKD_rep2__PE.nsrt.fxm.srt.Q20.chr.bam \
-f BAMPE \
-g 1.2e8 \
--name ChIP_Kmg_DanyKD_rep2_narrow \
--outdir macs2_narrow \
--keep-dup auto \
--nomodel \
-B


macs2 callpeak \
-t ChIPaKmg_SimjKD_rep1__PE.nsrt.fxm.srt.Q20.chr.bam \
-c INPUTaKmg_SimjKD_rep1__PE.nsrt.fxm.srt.Q20.chr.bam \
-f BAMPE \
-g 1.2e8 \
--name ChIP_Kmg_SimjKD_rep1_narrow \
--outdir macs2_narrow \
--keep-dup auto \
--nomodel \
-B


macs2 callpeak \
-t ChIPaKmg_SimjKD_rep2__PE.nsrt.fxm.srt.Q20.chr.bam \
-c INPUTaKmg_SimjKD_rep2__PE.nsrt.fxm.srt.Q20.chr.bam \
-f BAMPE \
-g 1.2e8 \
--name ChIP_Kmg_SimjKD_rep2_narrow \
--outdir macs2_narrow \
--keep-dup auto \
--nomodel \
-B


macs2 callpeak \
-t ChIPaV5Dany_Hom_wt_rep1__PE.nsrt.fxm.srt.Q20.chr.bam \
-c INPUTaV5Dany_Hom_wt_rep1__PE.nsrt.fxm.srt.Q20.chr.bam \
-f BAMPE \
-g 1.2e8 \
--name ChIP_V5Dany_wt_rep1_narrow \
--outdir macs2_narrow \
--keep-dup auto \
--nomodel \
-B



macs2 callpeak \
-t ChIPaV5Dany_Hom_wt_rep2__PE.nsrt.fxm.srt.Q20.chr.bam \
-c INPUTaV5Dany_Hom_wt_rep2__PE.nsrt.fxm.srt.Q20.chr.bam \
-f BAMPE \
-g 1.2e8 \
--name ChIP_V5Dany_wt_rep2_narrow \
--outdir macs2_narrow \
--keep-dup auto \
--nomodel \
-B







#https://pypi.org/project/MACS2/
