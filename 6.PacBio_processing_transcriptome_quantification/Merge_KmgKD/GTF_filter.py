#!/usr/bin/env python
# coding: utf-8

# In[5]:


# GENERAL INSTRUCTION:
# make sure scripts are at the folder where the input files are.
# make sure argument #1 is the filtered_transcripts.txt
# make sure argument #2 is the .gtf file and following the naming
#                          conventioon of "*_corrected.gtf"
#
#==========================================================================

import re
import sys

inFile_filter_transcript_name= sys.argv[1]
inFile_gtf_name= sys.argv[2]
prefix = inFile_gtf_name[:-14]
outFile_gtf_name=prefix+"_corrected_filtered.gtf"

in_transcript = open(inFile_filter_transcript_name, "r")

transcript_list = []
for line in in_transcript:
    transcript_ID = line.strip()
    transcript_list.append(transcript_ID)
in_transcript.close()

transcript_set = set(transcript_list)

in_unfiltered = open(inFile_gtf_name, "r")
out_filtered = open(outFile_gtf_name, "w")

for line in in_unfiltered:
    transcript_info  = line.strip().split("\t")[8].split(";")[0]
    x = re.search("\".+\"",transcript_info)
    clean_transcript_info = x.group()[1:-1]
    if clean_transcript_info in transcript_set:
        out_filtered.write(line)

in_unfiltered.close()
out_filtered.close()


# In[4]:





# In[5]:





# In[8]:





# In[9]:





# In[ ]:
