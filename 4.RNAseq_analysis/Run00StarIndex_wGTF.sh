#!/bin/bash
#SBATCH -J index   # name of the job
#SBATCH --mem-per-cpu=20G     # reserve 30G (per processor) of memory for the job
#SBATCH -t 12:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI
#SBATCH --cpus-per-task=4


mkdir -p STAR_indexed_wGTF # make directory for output


module add star/2.7.9a

STAR --runThreadN 4 \
--runMode genomeGenerate \
--genomeDir /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/ShortReads_RNAseq/STAR_indexed_wGTF \
--genomeFastaFiles /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Drosophila_melanogaster.BDGP6.32.dna.toplevel.fa \
--sjdbGTFfile /labs/mtfuller/ProjectCompleteIsoform/KmgProject_20240409/Drosophila_melanogaster.BDGP6.32.109.gtf
