#!/bin/bash
#SBATCH -J bam_to_bw
#SBATCH --mem-per-cpu=6G
#SBATCH -t 12:0:0
#SBATCH -p batch
#SBATCH --account=mtfuller
#SBATCH --cpus-per-task=8


cd $SLURM_SUBMIT_DIR

cd trim_SE

module add legacy/scg4
module add deepTools/3.1.0
module add samtools
module list


for Input in *_SE.nsrt.fxm.srt.bam
do
	echo $Input
	Output0=`echo $Input | sed 's/.bam/.Q20.chr.bam/'`
	echo $Output0

	samtools index $Input  # has to index before -view
	samtools view -b -q 20 $Input 2L 2R 3L 3R 4 X Y > $Output0
	# [-q minMapQ] (mapping quality)
	samtools index $Output0


#--numberOfProcessors (-p)
	Output=`echo $Input | sed 's/.bam/.bw/'`
	bamCoverage --bam $Output0 -o $Output -p 8 --binSize 1 --normalizeUsing CPM --extendReads 300
done

# Single-end: Requires a user specified value for the final fragment length. Reads that already exceed this fragment length will not be extended.
