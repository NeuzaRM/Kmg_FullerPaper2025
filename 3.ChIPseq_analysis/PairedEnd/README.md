## ChIPseq


#### 1. index the genome.

`sbatch Run00_BWA_index.sh`

#### 2. trim reads
`sbatch Run02Trim_PE.sh`

#### 3. map to genome
`sbatch Run03BWAsrt_PE.sh`

#### 4. filter, index and generate .bw files
`sbatch Run04BamtoBW_filterQ20.sh`

#### 5. call peaks with MACS2
`sbatch Run05MACS2_narrow.sh`
