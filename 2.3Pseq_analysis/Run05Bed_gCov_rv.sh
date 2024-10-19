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

module list



bedtools genomecov -ibam ./3Pseq-BAMgal4-1-ACCAGT_S3_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bam \
-g ./dm6.ucsc.chrom.sizes \
-d -3 -strand - > 3Pseq-BAMgal4-1-ACCAGT_S3_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr_rv_count.txt

bedtools genomecov -ibam ./3Pseq-BAMgal4-2-TGCACG_S4_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bam \
-g ./dm6.ucsc.chrom.sizes \
-d -3 -strand - > 3Pseq-BAMgal4-2-TGCACG_S4_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr_rv_count.txt

bedtools genomecov -ibam ./3Pseq-KmgKD-1-CAGCGT_S1_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bam \
-g ./dm6.ucsc.chrom.sizes \
-d -3 -strand - > 3Pseq-KmgKD-1-CAGCGT_S1_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr_rv_count.txt

bedtools genomecov -ibam ./3Pseq-KmgKD-2-GATCAC_S2_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr.bam \
-g ./dm6.ucsc.chrom.sizes \
-d -3 -strand - > 3Pseq-KmgKD-2-GATCAC_S2_R1_001_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr_rv_count.txt
