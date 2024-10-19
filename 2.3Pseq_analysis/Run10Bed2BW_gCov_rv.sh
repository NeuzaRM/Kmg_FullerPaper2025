#!/bin/bash -l
#SBATCH -J Bed2Bw
#SBATCH -p standard
#SBATCH --mem=40G
#SBATCH -t 12:0:0
#SBATCH -p batch
#SBATCH --account=mtfuller


cd $SLURM_SUBMIT_DIR
# this needs 6G of memory. 3G didn't let some of the library run.
module add bedtools
module add ucsc_tools



bedtools genomecov -i 3Pseq-BAMgal4-1-ACCAGT_S3_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.220981377 -bg -3 -strand - > 3Pseq-BAMgal4-1-ACCAGT_S3_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bed_rv.bg

bedtools genomecov -i 3Pseq-BAMgal4-2-TGCACG_S4_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.225634345 -bg -3 -strand - > 3Pseq-BAMgal4-2-TGCACG_S4_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bed_rv.bg

bedtools genomecov -i 3Pseq-KmgKD-1-CAGCGT_S1_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.200285956 -bg -3 -strand - > 3Pseq-KmgKD-1-CAGCGT_S1_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bed_rv.bg

bedtools genomecov -i 3Pseq-KmgKD-2-GATCAC_S2_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.185859746 -bg -3 -strand - > 3Pseq-KmgKD-2-GATCAC_S2_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bed_rv.bg


for Input in *.Q255.chr.bed_rv.bg
do
	Output=`echo $Input | sed 's/.bed_rv.bg/.rv.bw/'`
	bedGraphToBigWig $Input dm6.ucsc.chrom.sizes $Output
done
