#!/usr/bin/env python
# coding: utf-8

# In[3]:


# GENERAL INSTRUCTION: 
# make sure scripts are at the folder where the input files are. 
# make sure argument #1 is the .csv file from Isoseq3_cluster and 
#                       following the naming conventioon of 
#                       "*.clustered.cluster_report.csv"
# make sure argument #2 is the .bed file from TAMA_collapse and 
#                       following the naming conventioon of 
#                       "*.collapsed_trans_read.bed" 
#==========================================================================

import re
import sys

inFile_csv_name= sys.argv[1]
inFile_bed_name= sys.argv[2]
prefix = inFile_csv_name[:-28]

infile_cluster = open(inFile_csv_name, "r")
infile_trans_read = open(inFile_bed_name,"r")

trans_dict = {}
isoseqID_cluster_dict = {}

for line in infile_trans_read:
    info = line.strip().split("\t")[3]
    GeneID = info.split(";")[0].split(".")[0]
    TranscriptID = info.split(";")[0]
    IsoseqID = int(info.split("/")[-1])
    
    trans_dict[TranscriptID] = IsoseqID
infile_trans_read.close()
print('DONE populating trans_dict')

for line in infile_cluster:
    if line.startswith("t"):
        info_line = line.strip().split(",")

        transcript_id = int(info_line[0].split("/")[-1])
        read_id = int(info_line[1].split("/")[-2])
        
        if transcript_id not in isoseqID_cluster_dict.keys():
            isoseqID_cluster_dict[transcript_id] = [read_id]
        else:
            isoseqID_cluster_dict[transcript_id].append(read_id)
        
infile_cluster.close()
print('DONE populating IsoseqID_dict')


# with open(inFile,'r') as i:
#     lines = i.readlines()

# processedLines = manipulateData(lines)

# with open(outFile,'w') as o:
#     for line in processedLines:
#         o.write(line)


# In[ ]:


outfile1_name = prefix+"readID_Isoseq3ClusteredTranscriptID_TAMAcollapseID.txt"
outfile1= open(outfile1_name, "w")

outfile1.write("\t".join(["TAMA_GeneID", "TAMA_TranscriptID",                         "isoseq3_clustered_TranscriptID",                         "readID"])+"\n")

for gene_id,transcript_ID in trans_dict.items():
    gene_name = gene_id.split(".")[0]
    if transcript_ID in isoseqID_cluster_dict.keys():
        for read_id in isoseqID_cluster_dict[transcript_ID]:
            # loop through the list to write multiple times
            outlist = [gene_name, gene_id, str(transcript_ID), str(read_id)]
            outfile1.write("\t".join(outlist)+"\n")

print("DONE WRITING table 1")
outfile1.close()


# In[ ]:


outfile2_name = prefix+"TAMAcollapseID_readCounts.txt"
outfile2 = open(outfile2_name, "w")

outfile2.write("\t".join(["TAMA_GeneID", "TAMA_TranscriptID",                         "Number of reads (readIDs) per transcript"+"\n"]))
for gene_id,transcript_ID in trans_dict.items():
    gene_name = gene_id.split(".")[0]
    if transcript_ID in isoseqID_cluster_dict.keys():
        outlist = [gene_name, gene_id, str(len(isoseqID_cluster_dict[transcript_ID]))]
        outfile2.write("\t".join(outlist)+"\n")

print("DONE WRITING table 2")
outfile2.close()


# In[ ]:


outfile3_name = prefix+"TAMAcollapseID_readCounts_forSQANTI3.txt"
outfile3 = open(outfile3_name, "w")

outfile3.write("\t".join(["pbid", "count_fl"+"\n"]))

for gene_id,transcript_ID in trans_dict.items():
    gene_name = gene_id.split(".")[0]
    if transcript_ID in isoseqID_cluster_dict.keys():
        outlist = [gene_id, str(len(isoseqID_cluster_dict[transcript_ID]))]
        outfile3.write("\t".join(outlist)+"\n")

print("DONE WRITING table 3")
outfile3.close()

