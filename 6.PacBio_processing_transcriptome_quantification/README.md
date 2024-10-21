# Analysis pipeline for the publication:


## Long-Reads (PacBio)

Library was made with protocol: https://www.pacb.com/wp-content/uploads/Procedure-Checklist-Iso-Seq-Express-Template-Preparation-for-Sequel-and-Sequel-II-Systems.pdf

Iso-Seq™ Express Template Preparation for Sequel® and Sequel II Systems  
Notes on protocol: ProNex Bead Volume: 95ul

Sequencing done with CZBioHub (Angela Detweiler): Sequel II System


## Iso-Seq pipeline:  
https://github.com/GenomeRIK/tama/wiki  
https://github.com/PacificBiosciences/IsoSeq  

#### 1. Circular consensus Sequence (CCS) calling.  
This step was run by CZBioHub  

`sbatch Run01_SMARTLink_CCS_notRun.sh`

#### 2. Full Length Non-Chimeric (FLNC) read generation
This step was run by CZBioHub  

fasta file with adapter sequences: "IsoSeqPrimers_v2.fasta"  

`sbatch Run02_SMARTLink_lima_v2_notRun.sh`


#### 3. Cluster/Polish
This step was run by CZBioHub

`sbatch Run03_SMARTLink_isoseq3_refine_CCS_notRun.sh`

From now on, the analysis was done by us.

`sbatch Run04_SMARTLink_isoseq3_cluster_CCS.sh`


#### 4. Minimap2 mapping to the reference genome assembly

Genome assembly: BDGP6.32 (GCA_000001215.4)  
https://feb2023.archive.ensembl.org/Drosophila_melanogaster/Info/Index

Genome assembly fasta file: "Drosophila_melanogaster.BDGP6.32.dna.toplevel.fa"

`sbatch Run05_SMARTLink_pbmm2_align_CCS.sh`

<br>

#### 5. Collapse redundant transcript models - TAMA Collapse

https://github.com/GenomeRIK/tama/wiki/Tama-Collapse

`sbatch Run06_TAMA_collapse.sh`

-x capped #Our libraries are not 5'capped, but I don't want them to collapse the 5'ends too much. We can then filter based on CAGE  
-a 78 # CAGEseq parallel analysis: 78bp cluster interquantile width that includes 90% of clusters  
-z 80 # 3'seq parallel analysis: 80bp cluster interquantile width that includes 90% of clusters  


#### 6. Merge transcriptome annotations

`sbatch Run06b_TAMA_convert_toMerge.sh`

Create a new folder: "Merge_KmgKD"

Copy these files into "Merge_KmgKD" folder:  
`sbatch Run07_copy_files.sh`  
*_TAMA.collapsed.gtf  
*_TAMA.collapsed_trans_read.bed  



`sbatch Run08_makefileList_forTAMAmerge.sh`  
filelist_BamGal4_KmgKD.txt

`sbatch Run09_TAMA_merge.sh`  
Same values as in: Run06_TAMA_collapse.sh  
-a 78 # CAGEseq parallel analysis: 78bp cluster interquantile width that includes 90% of clusters  
-z 80 # 3'seq parallel analysis: 80bp cluster interquantile width that includes 90% of clusters  


#### 7. Run SQANTI3 - quality control

Convert .bed output of TAMA Merge to .gtf  
`sbatch Run10_TAMA_convertBed2Gtf.sh`

Run SQUANTI3:  
https://github.com/ConesaLab/SQANTI3/wiki/Running-SQANTI3-Quality-Control

`sbatch Run11_SQANTI3.sh`


$Input #TAMA_merge_BamGal4_KmgKD.gtf  
$reference_gtf #Drosophila_melanogaster.BDGP6.32.109.gtf  
$reference_fasta #Drosophila_melanogaster.BDGP6.32.dna.toplevel.fa

$short_reads #short_reads_FileNames.fofn  
RNAseq data: 150 PE, sequenced using NOVAseq (with Novogene)



#### 8. Filter transcripts

Keep transcripts that:  
• TSS overlap with CAGE clusters  
• TTS overlap with 3'seq clusters  
• have all junctions with Short-Reads coverage  
• do not have RT switching artifact  

Make files to run bedtools:  
Run12a_MakeFiles_ForBedtools.R  

Use transcript coordinates output from Run09_TAMA_merge: TAMA_merge_BamGal4_KmgKD.bed  
Make a file with transcription start sites (TSS) coordinates: TAMA_merge_BamGal4_KmgKD_TSS.bed  
Make a file with transcription termination sites (TTS) coordinates: TAMA_merge_BamGal4_KmgKD_TTS.bed  

Check whether TSS coordinates intersects with CAGE clusters.  
Check whether TTS coordinates intersects with 3'Seq clusters.  
NOTE: Cluster coordinates have 'chr' on chromosome names. Need to remove that first.  
CAGE: consensusCluster_CAGE.bed  
3'seq: consensusCluster_3Pseq.bed  


`sbatch Run12b_bedtools_intersect_CAGE_3Pseq.sh`  
outputs:  
TAMA_merge_BamGal4_KmgKD_TSS_CAGE.bed  
TAMA_merge_BamGal4_KmgKD_TTS_3Pseq.bed  


Analyze results and make a list of transcripts that pass all the above filters.  
Run12c_filter_SQANTI3.R  
other inputs:  
*_classification.txt (output of Run11_SQANTI3.sh)  
*_junctions.txt  

outputs:  
Run12c_filter_SQANTI3.pdf  
filtered_transcripts.txt  


Filter the .gtf file (output of Run11_SQANTI3.sh)  
`sbatch Run12d_filterGTF.sh`  
GTF_filter.py  


#### 9. Run SQANTI3 - quantify

9.1. Make Long-Reads counts file

`sbatch Run13a_make_LR_Counts.sh`

`sbatch Run13b_make_LR_Counts.sh`  
MakingTable1_2_3.py

`sbatch Run13c_make_LR_Counts.sh`  
MakingTable4.py  
samplesFile_table4.txt (these are the names used in: Run08_makefileList_forTAMAmerge.sh, source_name.txt)  

`sbatch Run13d_make_LR_Counts.sh`  
MakingTable5.py  
samplesFile_table5.txt  

Final output:  
BamGal4_KmgKD_LRreadCounts_forSQANTI3.txt



9.2. Run SQANTI3 - quantify

Run the following in a new folder: "SQANTI3_filtered":  
`sbatch Run14_SQANTI3_filtered.sh`

$Input #TAMA_merge_BamGal4_KmgKD_corrected_filtered.gtf  
$reference_gtf #Drosophila_melanogaster.BDGP6.32.109.gtf  
$reference_fasta #Drosophila_melanogaster.BDGP6.32.dna.toplevel.fa  

$short_reads #short_reads_FileNames.fofn  
RNAseq data: 150 PE, sequenced using NOVAseq (with Novogene)  

$FL_counts #BamGal4_KmgKD_LRreadCounts_forSQANTI3.txt

$tappAS_annotation_gff3 #Drosophila_melanogaster.BDGP6.32.105_tappAS.gff3 (file given to us by tappAS authors)  
$polyA_motif_list #polyA_motif_list.fa (from publication: )  
$cage_peaks #consensusCluster_CAGE.bed (from CAGE parallel analysis)  
$polyA_peaks #consensusCluster_3Pseq.bed (from 3'Seq parallel analysis)  


Outputs:  
TAMA_merge_BamGal4_KmgKD_corrected_filtered_SQANTI3_report.pdf  
TAMA_merge_BamGal4_KmgKD_corrected_filtered_classification.txt  
TAMA_merge_BamGal4_KmgKD_corrected_filtered_corrected.gtf  
TAMA_merge_BamGal4_KmgKD_corrected_filtered_corrected.gff3  
(and more)  


9.3. Fix GFF3 file before tappAS:  
`sbatch Run15_FixGFF3_for_tappAS.sh`  
FixGFF3_for_tappAS.py

It seems that to name proteins the authors added “Protein_” to the start of the transcript isoform name. So even if 2 transcripts code for the same protein, they get different names.  
-use *_classification.txt output from SQANTI3 to check for protein sequence.  
-all proteins with the same sequence, get named the same  

Also, when loading the file on tappAS I was getting: [ERROR] Invalid annotation line (invalid character used for ID).  
Replace all the ":" by "_"  
Replace all the "'" by ""  



#### 10. Make input files for tappAS

https://app.tappas.org/

You need 3 input files for tappAS:  
Features file: gff3 file, result of 9.3 (TAMA_merge_BamGal4_KmgKD_corrected_filtered_corrected_protFIX.gff3)  
Design File: (experimentalDesign.txt)  
Matrix Data File: (expressionMatrix_SR_tappAS.txt)  

Create a new folder "tappAS", and run the following inside:

10.1. Make input files for tappAS

Quantify transcript expression using short-read RNAseq data (KmgKD and other KDs)

`sbatch Run16a_copy_chrNameLength.sh`

`sbatch Run16b_Kallisto_index.sh`

`sbatch Run17_Kallisto_quant_LRgtf.sh`

Copy Kallisto_out_condition folders to computer and run the following R script for each condition:  
Run18_Make_tappAS_inputs.R  

Outputs:  
experimentalDesign_condition.txt  
expressionMatrix_SR_Tappas_condition.txt  


#### 11. Run tappAS

To open tappAS, go to cmd and run:

java -jar tappas.jar  (not enough memory - 0.24)

-Xmxn Specifies the maximum size, in bytes, of the memory allocation pool.

tappAS needs 1200:  
java -Xmx1200m -jar tappas.jar

my PC only gives it 1.13G.. don't know why! and can't change it

11.1. tappAS for BamGal4/KmgKD

Name: Project_Kmg_20240409_KmgKD  
Species: Drosophila  
Specify annotation's features file location:  
Experiment Type: Two-Group Comparison  
Design File: experimentalDesign_condition.txt  
Matrix Data File: expressionMatrix_SR_Tappas_condition.txt  

Select - Normalize data by TMM method  
Select - Expression Values Filter (Low count values cutoff: 1.0 CPM & Coefficient of variation cutoff: 100%)

Transcripts Filter: Do not filter Transcripts


Create a new folder "tappAS_outputs":

Run19_Make_FilteredTranscripts_KmgKD.R  
output: tappAS_Transcripts_KmgKD_filtered.txt


11.2. Filter gtf file to include only transcripts filtered by tappAS  
transcripts to include: tappAS_Transcripts_KmgKD_filtered.txt

`sbatch Run19b_filterGTF_tappASfiltered.sh`   
GTF_tappASfiltered.py


11.3. Add CDS information to gtf file  
using GFF3 (same as for tappAS)

`sbatch Run19c_addCDS_toGTF.sh`  
addCDS_toGTF.py



11.3. tappAS for BamGal4/OtherKDs

Name: tappAS_BamGal4_KmgKD_20240409_OtherKD  
Do NOT Select - Expression Values Filter  
Transcripts Filter: List of transcripts included in tappAS_BamGal4_KmgKD_20240409 (with Low count values cutoff: 1.0 CPM) - tappAS_Transcripts_KmgKD_filtered.txt
