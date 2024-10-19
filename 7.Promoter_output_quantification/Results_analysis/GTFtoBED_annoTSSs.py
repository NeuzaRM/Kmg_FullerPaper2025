#!/usr/bin/env python
# coding: utf-8

# In[31]:


# make sure scripts are at the folder where the input files are. 

# make sure argument #1 is the gtf
# the output bed file will be at the location of the scripts
#==========================================================================

import re
import sys

inFile_GTFname= sys.argv[1]
prefix = inFile_GTFname.strip().split("/")[-1][:-4]
outFile_BEDname = prefix+"_transcriptCoordinates.bed"



# Step 1. 
# Open the gtf and read through each line

inFile = open(inFile_GTFname, "r")
outFile = open(outFile_BEDname, "w")

# Step 2. 
# Write header line for outfile. 
outlist_header = ["chr","Start","End","transcriptID","geneID","Strand"]
outFile.write("\t".join(outlist_header)+"\n")

# Step3. 
# Go through each line, find the transcript line, and get all the necessary
# informatin. 
for line in inFile:
    if not line.startswith("#"):
        current_line = line.strip().split("\t")
        if current_line[2] == "transcript":
            chrom = current_line[0]
            nuc_start = current_line[3]
            nuc_end = current_line[4]
            strand = current_line[6]
            
            info = current_line[8].strip().split(";")
            for item in info:
                item = item.strip()
                if item.startswith("gene_id"):
                    gene_id = re.search(r'"(.*?)"', item).group()[1:-1]
                    continue
                elif item.startswith("transcript_id"):
                    tran_id = re.search(r'"(.*?)"', item).group()[1:-1]
                    continue
                else:
                    pass

            outlist = [chrom, nuc_start, nuc_end, tran_id, gene_id, strand]

            outFile.write("\t".join(outlist)+"\n")
 
        
inFile.close()
outFile.close()


# In[ ]:




