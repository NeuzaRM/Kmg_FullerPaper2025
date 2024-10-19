

library(tidyr)
library(dplyr)
library(stringr)
library(tidyverse)



CAGE_ctrl <- read.csv("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\CAGE\\Results\\clusterTSS_ctrl.txt", sep = "\t", header = TRUE, stringsAsFactors = FALSE)

CAGE_ctrl <- CAGE_ctrl[c(2,3,4,1,7,5)]

CAGE_ctrl$chr <- str_replace(CAGE_ctrl$chr, "chr", "")

CAGE_ctrl$cluster = paste0('Cluster_Ctrl_', CAGE_ctrl$cluster)

head(CAGE_ctrl)


write.table(CAGE_ctrl, "C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\CAGE\\Results\\CtrlCluster_CAGE.bed", sep="\t", row.names = FALSE, col.names = FALSE, quote=FALSE)

###


CAGE_kmg <- read.csv("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\CAGE\\Results\\clusterTSS_KmgKD.txt", sep = "\t", header = TRUE, stringsAsFactors = FALSE)

CAGE_kmg <- CAGE_kmg[c(2,3,4,1,7,5)]

CAGE_kmg$chr <- str_replace(CAGE_kmg$chr, "chr", "")

CAGE_kmg$cluster = paste0('Cluster_KmgKD_', CAGE_kmg$cluster)

head(CAGE_kmg)


write.table(CAGE_kmg, "C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\CAGE\\Results\\KmgKDCluster_CAGE.bed", sep="\t", row.names = FALSE, col.names = FALSE, quote=FALSE)


