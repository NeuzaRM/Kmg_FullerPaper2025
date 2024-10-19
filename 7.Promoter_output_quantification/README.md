# Analysis pipeline for the publication:



#### 12. Promoter output quantification

12.1. Define promoters

Intersect transcript TSS with consensus CAGE clusters (from CAGE analysis) keeping the ID of the consensus cluster, which will be the promoter ID.

Run20a_Make_CAGE_bedFiles.R
`sbatch Run20b_bedtools_intersect_CAGE.sh`

outputs:
TAMA_merge_BamGal4_KmgKD_TSS_cClusterID.bed
cCluster_CtrlClusterID.bed
cCluster_KmgKDClusterID.bed


12.2. Make input files for DEseq

Run21_Make_CountTable_Promoter_output.R
Outputs:
PromoterCounts_*
sampleTable_*


12.3. Run DEseq to quantify promoter expression

`sbatch Run22_DEseq_promoterCounts.sh`
DESeq2_Promoters_*


Copy results to a new folder "Results_analysis"
Run23_DEseq_output_for_graphs.R


#### 13. Define cryptic promoters

13.1. Which promoters have annotated TSSs?

Convert reference gtf (Drosophila_melanogaster.BDGP6.32.109.gtf) into .bed:
`sbatch Run24a_GTFtoBED_annoTSSs.sh`
GTFtoBED_annoTSSs.py

Get TSS coordinates of annotated transcripts:
Run24b_GetAnnotTSSs.RMD

Intersect with promoters (CAGE cClusters)
`sbatch Run24c_bedtools_CAGEcClusters_annoTSS.sh`


13.2. Define Cryptic Promoters
Run25_DefineCrypticPromoters.RMD


13.3. Visualize promoter expression in different genetic backgrounds
Run26_PromoterExpression_KmgKD_otherGenes_readCounts.RMD


13.4 Make BED files with Promoter and Gene coordinates.

Run27_TSSandGene_coordinates.RMD
`sbatch Run27a_bedtools_.sh`


The output files were used for downstream analysis - deeptools:
https://deeptools.readthedocs.io/en/latest/content/tools/computeMatrix.html
https://deeptools.readthedocs.io/en/latest/content/tools/plotHeatmap.html
