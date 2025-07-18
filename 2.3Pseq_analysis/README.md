## 3'Seq

Library was made with protocol: QuantSeq 3‘ mRNA-Seq Library Prep Kit - FWD  
Following sample preparation as in Gallicchio et al. (2024).

Sequencing was performed by the Stanford University Genomics Facility on an Illumina NextSeq 500 platform as in Berry et al. (2022).



#### 1. index the genome.
CAGEr uses BSgenome.Dmelanogaster.UCSC.dm6, so did the mapping to UCSC genome, which required a different index.

`sbatch Run00Index.sh`

#### 2. remove the adapter contamination, polyA read through, and low quality tails
`sbatch Run02_3seq_Trimming.sh`

#### 3.map to genome with STAR (76bp is long enough to may include splicing junctions)
`sbatch Run03Map_pass2.sh`


#### 4. filter and index
Filter the .bam file to only include uniquely mapped reads and reads on the main chromosomes, then index the filtered .bam file

`sbatch Run04bIndex_Stats_corrected.sh`

<br>

#### 5. CAGEr build clusters

Because this data was used to filter our PacBio long-reads, we used the same pipeline as of CAGE analysis to generate consensus clusters.
Instead of TSS (transcription start sites) we worked with TTS (transcription termination sites).  
As for our CAGE analysis, this pipeline was adapted from: https://github.com/danrlu/Fuller_Lab_paper  
D. Lu, H.S. Sin, C. Lu and M. T. Fuller (GEO: GSE145975)



#### 5.1 use bedtools to count number of TTS (3' of reads) at each genomic location
note the output from these scripts have no strand information, so had to count each strand separately
```{bash}
sbatch Run05Bed_gCov_fw.sh
sbatch Run05Bed_gCov_rv.sh
```

#### 5.2 convert the output from Run05 to ctts.txt format (see CAGEr manual) as CAGEr input
`sbatch Run06convert_ctss.sh`

#### 5.3 run CAGEr to build TTS clusters

Note: I had to remove "3Pseq-" from "3Pseq-BAMgal4-1-ACCAGT_S3_R1_001_ctts" because CAGEr doesn't accept file names starting with numbers.

`sbatch Run07CAGEr.sh`


<br>

#### 6. count reads in TSS clusters
#### 6.1 convert .bam to .bed file keeping only the most 3' 1bp of the read (TTS).
This script first convert .bam to .bed (then used in step 7 below), they only keep the most 3' 1bp in .adj.srt.bed which is preparation for the next step.

`sbatch Run08_B2B_adjBed.sh`

#### 6.2 use the consensus TTS clusters built by CAGEr, and the adjusted .adj.srt.bed file from 6.1 to count TTS expression level for each consensus TTS cluster.
`sbatch Run09a_prepareFile.sh`

`sbatch Run09Bedtools_coverage_array.sh`

<br>

#### 7. create strand specific .bigwig for genomic viewer
#### 7.1 calculate normalization factor
For each library, count total number of reads in .bed files generated in step 6.1 using `wc -l`, then calculate 10000000/total reads as the scale factor for the next step. This number is effectively 10x RPM to avoid data range less than 1.

#### 7.2 create normalized .bw files
The input is the .bed file containing ENTIRE reads generated in step 6.1. Here use bedtools to only keep 1bp at the 3' of reads, then convert to .bedgraph with `bedtools genomecov` and `-scale` option is the number from 7.1, then covert to .bw.

Split forward and reverse strand to be used for genomic viewer:

`Run10Bed2BW_gCov_fw.sh`

`Run10Bed2BW_gCov_rv.sh`

Combines both strands to be used for plotting CAGE heatmaps in the paper:

`Run10bBed2BW_gCov_all.sh`

<br>

===================

Trim Galore version: 0.4.4_dev

Cutadapt version: 1.16

STAR/2.5.4b

samtools/1.9

bedtools/2.27.1

gcc/5.2.0

python/2.7

ucsc_tools/377

R/3.4.4
