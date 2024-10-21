library(DESeq2)
library(tidyr)
library(dplyr)
library(magrittr) # for %>%


sample_name="_KmgKD"


# Differential expression analysis

sampleTable <- read.csv(paste0('sampleTable',sample_name,'.txt'))

dds <- DESeqDataSetFromHTSeqCount(sampleTable=sampleTable, design=~condition)

dds$condition <- relevel(dds$condition, ref="control") # set the level to be compared with


# Control Promoters: 50 promoters with log2FC most similar to the “mode” value

dds <- estimateSizeFactors(dds,controlGenes=rownames(dds) %in% c("cCluster_32323", "cCluster_17627", "cCluster_39844", "cCluster_34135", "cCluster_39751", "cCluster_16347", "cCluster_16967", "cCluster_15893", "cCluster_17890", "cCluster_42504",
"cCluster_19264", "cCluster_28925", "cCluster_39662", "cCluster_8234", "cCluster_5950",  "cCluster_30704", "cCluster_28303", "cCluster_2290",  "cCluster_32862", "cCluster_18657",
"cCluster_8642",  "cCluster_42440", "cCluster_29192", "cCluster_41655", "cCluster_35928", "cCluster_18454", "cCluster_31655", "cCluster_12049", "cCluster_11514", "cCluster_10458",
"cCluster_9694",  "cCluster_34625", "cCluster_18977", "cCluster_34362", "cCluster_20668", "cCluster_23392", "cCluster_37973", "cCluster_2989",  "cCluster_3090",  "cCluster_9659", 
"cCluster_11317", "cCluster_11058", "cCluster_141", "cCluster_42290", "cCluster_34012", "cCluster_7059", "cCluster_20353", "cCluster_34068", "cCluster_43307", "cCluster_12142"))


dds <- DESeq(dds)


res <- results(dds)
resOrdered <- res[order(res$padj),]



write.table(resOrdered,file=paste0("DE_results_all_MODEesf",sample_name,".txt"),sep = "\t",col.names=NA)
# col.names=NA is necessary otherwise 1st column will not have a header and format is a mess


write.table(counts(dds,normalized=TRUE),file=paste0("DE_normalized_counts_MODEesf",sample_name,".txt"),sep = "\t",col.names=NA)








