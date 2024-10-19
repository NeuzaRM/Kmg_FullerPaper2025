#!/usr/bin/env python
# coding: utf-8

# In[10]:


# make sure scripts are at the folder where the input files are. 

# make sure argument #1 is the classification file form SQANTI3 output, with the 
#                          naming convention of "*_classfication.txt"
# make sure argument #2 is the GFF3 file you want to fix, with the naming
#                          convention of "*_tappAS.gff3"

#==========================================================================

import re
import sys

inFile_AAname= sys.argv[1]
inFile_gff3name = sys.argv[2]
prefix = inFile_gff3name[:-5]
outfile_name = prefix+"_protFIX.gff3"

# Step 1. 
# Figure out AA sequence for every transcript. 


in_AAseq = open(inFile_AAname, "r")
AA_dict = {}
for line in in_AAseq:
    if line.startswith("G"):
        Gene_ID = line.strip().split("\t")[0].split(".")[0]
        Transcript_ID = line.strip().split("\t")[0]
        AA_sequence= line.strip().split("\t")[46]
        if Gene_ID not in AA_dict.keys():
            AA_dict[Gene_ID] = {Transcript_ID: AA_sequence}        
        else:
            AA_dict[Gene_ID].update({Transcript_ID: AA_sequence})
in_AAseq.close()


# In[11]:


# Step 2. 
# Collapse transcript information.

Clean_AA_dict = {}

for gene in AA_dict.keys():
    Clean_AA_dict[gene] = {}
    Memory_dict = {}
    for transcript, AAseq in AA_dict[gene].items():
        if AAseq != "NA":
            if AAseq not in Memory_dict.values():
                Memory_dict[transcript] = AAseq
                Clean_AA_dict[gene].update({transcript: transcript})
            else:
            # I have seen this amino acid sequence before. 
                # First find the transcript ID that code for same AA. 
                for key,value in Memory_dict.items():
                    if value == AAseq:
                        duplicate_transcript = key
                        break
                Clean_AA_dict[gene].update({transcript:duplicate_transcript})
        else:
            Clean_AA_dict[gene].update({transcript: transcript})
            


# In[12]:


import re

in_TAMA = open(inFile_gff3name, "r")

out_TAMA = open(outfile_name, "w")


for line in in_TAMA:
    info_line = line.strip().split("\t")
    Gene_ID = line.strip().split("\t")[0].split(".")[0]
    Transcript_ID = line.strip().split("\t")[0]
    
    #The AA sequence is unique, no need to change
    if Transcript_ID == Clean_AA_dict[Gene_ID][Transcript_ID]:
        output_line = line
    
    #The AA sequence is duplicate, gotta change the output_line
    else:    
        # Stuff that needs to be change is in info_line[8]
        # Need to change ID, Name, and Desc
        old_str = "Protein_"+Transcript_ID
        new_str = "Protein_"+Clean_AA_dict[Gene_ID][Transcript_ID]
        output_line = re.sub(old_str, new_str, line)
    
    outlist = output_line.strip().split("\t")
    outlist[8] = re.sub(":", "_", outlist[8])
    outlist[8] = re.sub("\'", "", outlist[8])
    output_line = "\t".join(outlist) + "\n"
    out_TAMA.write(output_line)
        
in_TAMA.close()
out_TAMA.close()


# In[ ]:




