
#make input for tappAS using Kallisto output from SQANTI3 - short reads


library(tidyverse)
library(tidyr)
library(dplyr)
library(stringr)


#just need to change:
#sample_name=""
#sample_name1=""
#sample_name2=""



setwd("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS")


BamGal4_1 <- read.table("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\kallisto_out_BamGal4_1\\abundance.tsv", sep = "\t", header = TRUE)

BamGal4_1 <- BamGal4_1[c(1,4)]

colnames(BamGal4_1) <- c('target_id', 'BamGal4_1')

head(BamGal4_1)



BamGal4_2 <- read.table("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\kallisto_out_BamGal4_2\\abundance.tsv", sep = "\t", header = TRUE)

BamGal4_2 <- BamGal4_2[c(1,4)]

colnames(BamGal4_2) <- c('target_id', 'BamGal4_2')

head(BamGal4_2)


#############

sample_name="KmgKD"


sample_name1="KmgKD_1"
path1 <- paste0("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\kallisto_out_",sample_name1,"\\abundance.tsv")

table1 <- read.table(path1, sep = "\t", header = TRUE)

table1 <- table1[c(1,4)]

colnames(table1) <- c('target_id', sample_name1)

head(table1)



sample_name2="KmgKD_2"
path2 <- paste0("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\kallisto_out_",sample_name2,"\\abundance.tsv")

table2 <- read.table(path2, sep = "\t", header = TRUE)

table2 <- table2[c(1,4)]

colnames(table2) <- c('target_id', sample_name2)

head(table2)



table3 <- full_join(BamGal4_1, BamGal4_2, by = "target_id")

table4 <- full_join(table3, table1, by = "target_id")

table_full <- full_join(table4, table2, by = "target_id")


colnames(table_full) <- c('', 'BamGal4_1', 'BamGal4_2', sample_name1, sample_name2)

head(table_full)


write.table(table_full,file=paste0("expressionMatrix_SR_Tappas_",sample_name,".txt"), sep="\t", row.names = FALSE, col.names = TRUE, quote=FALSE)


############################


# Experimental design


experimentalDesign <- tibble(Sample = c('BamGal4_1', 'BamGal4_2', sample_name1, sample_name2), 
                             Group = rep(c("Control", "Test"), each=2))

head(experimentalDesign)


write.table(experimentalDesign,file=paste0("experimentalDesign_",sample_name,".txt"), sep="\t", row.names = FALSE, col.names = TRUE, quote=FALSE)


