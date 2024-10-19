#!/bin/bash
#SBATCH -J bam_to_bw
#SBATCH --mem-per-cpu=6G
#SBATCH -t 12:0:0
#SBATCH -p batch
#SBATCH --account=mtfuller
#SBATCH --cpus-per-task=8


cd $SLURM_SUBMIT_DIR

cd trim_PE

module add legacy/scg4
module add deepTools/3.1.0
module add samtools
module list


for Input in *_PE.nsrt.fxm.srt.bam
do
	echo $Input
	Output0=`echo $Input | sed 's/.bam/.Q20.chr.bam/'`
	echo $Output0

	samtools index $Input  # has to index before -view
	samtools view -b -q 20 $Input 2L 2R 3L 3R 4 X Y > $Output0
	# [-q minMapQ] (mapping quality)
	samtools index $Output0

	#Output1=`echo $Input | sed 's/.bam/_bin10.bw/'`
	#bamCoverage --bam $Output0 -o $Output1 -p 8 --binSize 10 --normalizeUsing CPM --extendReads
#--numberOfProcessors (-p)
	Output2=`echo $Output0 | sed 's/.bam/_bin1.bw/'`
	bamCoverage --bam $Output0 -o $Output2 -p 8 --binSize 1 --normalizeUsing CPM --extendReads
done
