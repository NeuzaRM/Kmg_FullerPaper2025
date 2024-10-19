

library(tidyr)
library(dplyr)
library(stringr)
library(tidyverse)



FullTable_Transcript_cCAGE <- read.table("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\tappAS_outputs\\Promoter_quantif\\TAMA_merge_BamGal4_KmgKD_TSS_cClusterID.bed", sep = "\t", header = FALSE, stringsAsFactors = FALSE)

FullTable_Transcript_cCAGE <- FullTable_Transcript_cCAGE[c(4,10)]

colnames(FullTable_Transcript_cCAGE) <- c('Transcript', 'CAGE_cCluster')

FullTable_Transcript_cCAGE$CAGE_cCluster = paste0('cCluster_', FullTable_Transcript_cCAGE$CAGE_cCluster)

head(FullTable_Transcript_cCAGE)


## Filter transcripts

Filtered_transcripts <- read.table("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\tappAS_outputs\\tappAS_Transcripts_filtered_KmgKD.txt", sep = "\t", header = FALSE, stringsAsFactors = FALSE)


Transcripts_cCAGE <- FullTable_Transcript_cCAGE %>% filter(Transcript %in% Filtered_transcripts$V1)

head(Transcripts_cCAGE)


write.table(Transcripts_cCAGE, "C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\tappAS_outputs\\Promoter_quantif\\Transcripts_cClusters_ALL.txt", sep="\t", row.names = FALSE, col.names = TRUE, quote=FALSE)


##############

# MAKE files for DESeq analysis


# Make counts table from Kallisto output
# Use "est_counts" from abundance.tsv - need to transform into a matrix of integer values

# Make sampleTable_"sampleName"


#############################

setwd("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS")


BamGal4_1 <- read.table("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\kallisto_out_BamGal4_1\\abundance.tsv", sep = "\t", header = TRUE)

BamGal4_1 <- BamGal4_1[c(1,4)]

colnames(BamGal4_1) <- c('Transcript', 'est_counts')

BamGal4_1_CAGE <- left_join(BamGal4_1, Transcripts_cCAGE, by = "Transcript")

BamGal4_1_CAGE <- BamGal4_1_CAGE %>% group_by(CAGE_cCluster) %>% dplyr::summarise(promoterCounts=sum(est_counts))

BamGal4_1_CAGE$promoterCounts <- as.integer(BamGal4_1_CAGE$promoterCounts) 

#NA come from transcripts that were filtered in tappAS (not in file: tappAS_Transcripts_filtered_KmgKD.txt). Remove them!
BamGal4_1_CAGE <- BamGal4_1_CAGE %>% drop_na()

head(BamGal4_1_CAGE)

write.table(BamGal4_1_CAGE,file=("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\tappAS_outputs\\Promoter_quantif\\PromoterCounts_BamGal4_1.txt"), sep="\t", row.names = FALSE, col.names = FALSE, quote=FALSE)




###

BamGal4_2 <- read.table("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\kallisto_out_BamGal4_2\\abundance.tsv", sep = "\t", header = TRUE)

BamGal4_2 <- BamGal4_2[c(1,4)]

colnames(BamGal4_2) <- c('Transcript', 'est_counts')

BamGal4_2_CAGE <- left_join(BamGal4_2, Transcripts_cCAGE, by = "Transcript")

BamGal4_2_CAGE <- BamGal4_2_CAGE %>% group_by(CAGE_cCluster) %>% dplyr::summarise(promoterCounts=sum(est_counts))

BamGal4_2_CAGE$promoterCounts <- as.integer(BamGal4_2_CAGE$promoterCounts) 

#NA come from transcripts that were filtered in tappAS (not in file: tappAS_Transcripts_filtered_KmgKD.txt). Remove them!
BamGal4_2_CAGE <- BamGal4_2_CAGE %>% drop_na()

head(BamGal4_2_CAGE)

write.table(BamGal4_2_CAGE,file=("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\tappAS_outputs\\Promoter_quantif\\PromoterCounts_BamGal4_2.txt"), sep="\t", row.names = FALSE, col.names = FALSE, quote=FALSE)


#############

# Run the rest of the scrip for each sample:

sample_name="KmgKD"

sample_name1="KmgKD_1"

sample_name2="KmgKD_2"


####

path1 <- paste0("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\kallisto_out_",sample_name1,"\\abundance.tsv")

table1 <- read.table(path1, sep = "\t", header = TRUE)

table1 <- table1[c(1,4)]

colnames(table1) <- c('Transcript', 'est_counts')

table1_CAGE <- left_join(table1, Transcripts_cCAGE, by = "Transcript")

table1_CAGE <- table1_CAGE %>% group_by(CAGE_cCluster) %>% dplyr::summarise(promoterCounts=sum(est_counts))

table1_CAGE$promoterCounts <- as.integer(table1_CAGE$promoterCounts) 

#NA come from transcripts that were filtered in tappAS (not in file: tappAS_Transcripts_filtered_KmgKD.txt). Remove them!
table1_CAGE <- table1_CAGE %>% drop_na()

head(table1_CAGE)


write.table(table1_CAGE,file=paste0("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\tappAS_outputs\\Promoter_quantif\\PromoterCounts_",sample_name1,".txt"), sep="\t", row.names = FALSE, col.names = FALSE, quote=FALSE)


####


path2 <- paste0("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\kallisto_out_",sample_name2,"\\abundance.tsv")

table2 <- read.table(path2, sep = "\t", header = TRUE)

table2 <- table2[c(1,4)]

colnames(table2) <- c('Transcript', 'est_counts')

table2_CAGE <- left_join(table2, Transcripts_cCAGE, by = "Transcript")

table2_CAGE <- table2_CAGE %>% group_by(CAGE_cCluster) %>% dplyr::summarise(promoterCounts=sum(est_counts))

table2_CAGE$promoterCounts <- as.integer(table2_CAGE$promoterCounts) 

#NA come from transcripts that were filtered in tappAS (not in file: tappAS_Transcripts_filtered_KmgKD.txt). Remove them!
table2_CAGE <- table2_CAGE %>% drop_na()

head(table2_CAGE)


write.table(table2_CAGE,file=paste0("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\tappAS_outputs\\Promoter_quantif\\PromoterCounts_",sample_name2,".txt"), sep="\t", row.names = FALSE, col.names = FALSE, quote=FALSE)


############################


# Make sampleTable


Table <- tibble(V1 = c('sampleName', 'PromoterCounts_BamGal4_1.txt', 'PromoterCounts_BamGal4_2.txt', paste0("PromoterCounts_",sample_name1,".txt"), paste0("PromoterCounts_",sample_name2,".txt")), 
                      V2 = c('fileName','PromoterCounts_BamGal4_1.txt', 'PromoterCounts_BamGal4_2.txt', paste0("PromoterCounts_",sample_name1,".txt"), paste0("PromoterCounts_",sample_name2,".txt")),       
                      V3 = c('condition', 'control', 'control', 'test', 'test'))

sampleTable <- Table %>% unite(new_var, V1, V2, V3, sep=",")

head(sampleTable)

write.table(sampleTable,file=paste0("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\tappAS_outputs\\Promoter_quantif\\sampleTable_",sample_name,".txt"), sep="\t", row.names = FALSE, col.names = FALSE, quote=FALSE)


