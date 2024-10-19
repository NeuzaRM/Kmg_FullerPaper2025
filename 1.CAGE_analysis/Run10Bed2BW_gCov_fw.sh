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


bedtools genomecov -i BamGal4.1_R1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.345270795 -bg -5 -strand + > BamGal4.1_R1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_fw.bg

bedtools genomecov -i BamGal4.2_R1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.325443159 -bg -5 -strand + > BamGal4.2_R1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_fw.bg

bedtools genomecov -i K1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.430721133 -bg -5 -strand + > K1_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_fw.bg

bedtools genomecov -i K2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed \
-g dm6.ucsc.chrom.sizes \
-scale 0.456557462 -bg -5 -strand + > K2_trimmed_Aligned.sortedByCoord.out.Q255.chr.bed_fw.bg



for Input in *.Q255.chr.bed_fw.bg
do
	Output=`echo $Input | sed 's/.bed_fw.bg/.fw.bw/'`
	bedGraphToBigWig $Input dm6.ucsc.chrom.sizes $Output
done
