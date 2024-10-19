

library(tidyr)
library(dplyr)
library(stringr)




setwd("C:\\Users\\neuza\\Documents\\Posdoc_Fuller\\LongReads_RNAseq\\PacBio\\analysis_scripts\\KmgProject_20240409\\Merge_KmgKD\\SQANTI3_filtered\\tappAS\\tappAS_outputs\\Promoter_quantif\\Results_analysis")


sample_name="_Topi"


## Load counts
DE_normalized_counts <- read.table(paste0('DE_normalized_counts',sample_name,'.txt'), sep = "\t", header = TRUE)
head(DE_normalized_counts)

##load differential expression
DE_results <- read.table(paste0('DE_results_all',sample_name,'.txt'), sep = "\t", header = TRUE)
head(DE_results)




colnames(DE_normalized_counts)<- c("GeneID","condition_X1","condition_X2","condition_Y1", "condition_Y2")
DE_results <- rename(DE_results, GeneID = X)

data <- inner_join(DE_normalized_counts, DE_results, by = "GeneID" )

data2 <- data %>% mutate(condition_Y_Ave = (condition_Y1+condition_Y2)/2, condition_X_Ave = (condition_X1+condition_X2)/2)

data2 <- data2[c(1,13,12,7,11)]
head(data2)
dput(head(str(data2)))




## save table for analysis


write.table(data2,file=paste0("Results",sample_name,".txt"), sep="\t", row.names = FALSE, col.names = TRUE, quote=FALSE)


