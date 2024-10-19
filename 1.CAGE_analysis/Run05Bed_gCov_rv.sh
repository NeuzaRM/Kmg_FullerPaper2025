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


# Dan had:
#bedtools genomecov -i ./B1_trimmed_Aligned.sortedByCoord.out.chr.bed \
#-g ../dm6.ucsc.chrom.sizes \
#-d -5 -strand + > B1_trimmed_Aligned.sortedByCoord.out.chr.bed_fw_count.txt

#I don't have the .bed files. bedtools also reads .bam files, so I run:



bedtools genomecov -ibam ./BamGal4.1_R1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bam \
-g ../dm6.ucsc.chrom.sizes \
-d -5 -strand - > BamGal4.1_R1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_rv_count.txt

bedtools genomecov -ibam ./BamGal4.2_R1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bam \
-g ../dm6.ucsc.chrom.sizes \
-d -5 -strand - > BamGal4.2_R1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_rv_count.txt

bedtools genomecov -ibam ./K1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bam \
-g ../dm6.ucsc.chrom.sizes \
-d -5 -strand - > K1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_rv_count.txt

bedtools genomecov -ibam ./K2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bam \
-g ../dm6.ucsc.chrom.sizes \
-d -5 -strand - > K2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_rv_count.txt
