
#make List of transcripts included in tappAS_BamGal4_KmgKD_20240409 (with Low count values cutoff: 1.0 CPM)
#n=37552


library(tidyverse)
library(tidyr)
library(dplyr)
library(stringr)


transcripts_full <- read.table("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\tappAS_outputs\\tappAS_Transcripts_filtered_KmgKD.tsv", sep = "\t", header = FALSE)

nrow(transcripts_full)

transcripts <- transcripts_full[c(1)]


write.table(transcripts, "C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\tappAS_outputs\\tappAS_Transcripts_filtered_KmgKD.txt", sep="\t", row.names = FALSE, col.names = FALSE, quote=FALSE)



