#!/usr/bin/env python
# coding: utf-8

# In[23]:


# make sure scripts are at the folder where the input files are.
# make sure argument #1 is the _merge.txt file from and  following
#                          the naming conventioon of
#                          "*_merge.txt"
# make sure argument #2 is the samplesFile.txt file that have the name of each
#                          condition type, which is the prefix of "*_TAMAcollapseID_readCounts_forSQANTI3.txt"
#==========================================================================


# For making Table 4
import re
import sys

inFile_name= sys.argv[1]
inFile2_name = sys.argv[2]
prefix = inFile_name[:-9]
outFile_name = prefix + "TAMAmergeID_TAMAcollapseID.txt"


# For Table 4.
inFile = open(inFile_name,"r")
inFile2 = open(inFile2_name, "r")
outFile = open(outFile_name,"w")

header_dict = {}
out_header_list = ["TAMA_merge_transcriptID"]
counter = 0
for line in inFile2:
    out_header_list.append(line.strip()+"_TAMA_collapse_TranscriptID")
    header_dict.update({line.strip(): counter})
    counter += 1

inFile2.close()

# Writing header line for output file.
outFile.write("\t".join(out_header_list)+"\n")

out_dic = {}
for line in inFile:
    info = line.strip().split("\t")[3]
    TAMA_ID = info.split(";")[0]
    Condition_Type = info.split(";")[1].split("_")[0]
    Old_ID = info.split(";")[1].split("_")[1]

    if TAMA_ID not in out_dic.keys():
        # loop through and fill all value to be "NA"
        out_dic[TAMA_ID] = []
        for x in range (len(header_dict)):
            out_dic[TAMA_ID].append("NA")

    if Condition_Type in header_dict.keys():
        out_dic[TAMA_ID][header_dict[Condition_Type]] = Old_ID
    else:
        print("Something is wrong")
        print(line)
        break

inFile.close()

for key,value in out_dic.items():
    out_list = [key]
    for old_id in value:
        out_list.append(old_id)
    outFile.write("\t".join(out_list)+"\n")

outFile.close()


# In[14]:





# In[15]:





# In[ ]:
