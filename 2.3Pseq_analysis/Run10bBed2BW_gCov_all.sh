#!/bin/bash -l
#SBATCH -J Bed2Bw
#SBATCH -p standard
#SBATCH --mem=20G
#SBATCH -t 12:0:0
#SBATCH -p batch
#SBATCH --account=mtfuller


cd $SLURM_SUBMIT_DIR
# this needs 6G of memory. 3G didn't let some of the library run.
module add bedtools/2.25.0
module add ucsc_tools


bedtools genomecov -i 3Pseq-BAMgal4-1-ACCAGT_S3_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.220981377 -bg -3 > 3Pseq-BAMgal4-1-ACCAGT_S3_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bed.bg

bedtools genomecov -i 3Pseq-BAMgal4-2-TGCACG_S4_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.225634345 -bg -3 > 3Pseq-BAMgal4-2-TGCACG_S4_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bed.bg

bedtools genomecov -i 3Pseq-KmgKD-1-CAGCGT_S1_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.200285956 -bg -3 > 3Pseq-KmgKD-1-CAGCGT_S1_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bed.bg

bedtools genomecov -i 3Pseq-KmgKD-2-GATCAC_S2_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.185859746 -bg -3 > 3Pseq-KmgKD-2-GATCAC_S2_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bed.bg


for Input in *.Q255.chr.bed.bg
do
	Output=`echo $Input | sed 's/.bed.bg/.bw/'`
	bedGraphToBigWig $Input dm6.ucsc.chrom.sizes $Output
done
