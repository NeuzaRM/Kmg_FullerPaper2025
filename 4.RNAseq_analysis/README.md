## RNAseq


Libraries were made with protocol:  
NEBNext® Ultra II Directional RNA Library Prep Kit for Illumina

Sequencing was performed by Novogene. NovaSeq, Illumina Sequencing PE150.



#### 1. index the genome.

`sbatch Run00StarIndex_wGTF.sh`

#### 2. trim reads
`sbatch Run02Trim_PE.sh`

#### 3. map to genome
`sbatch Run03Map_pass1.sh`

`sbatch Run04Map_pass2.sh`

#### 4. Index and generate .bw files

Not strand specific  
`sbatch Run05Index_BW.sh`

Strand specific  
`sbatch Run06Index_BW_strand.sh`
