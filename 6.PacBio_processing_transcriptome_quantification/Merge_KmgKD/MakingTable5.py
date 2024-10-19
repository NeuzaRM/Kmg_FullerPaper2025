#!/usr/bin/env python
# coding: utf-8

# In[26]:


# make sure scripts are at the folder where the input files are. 

# make sure argument #1 is the .txt that have the name of each table 3 for each
#                          condition type. See example file for template
#                          Table5_example.txt
# make sure argument #2 is the appropriate table 4
# make sure the order of your list of files in file1 is in the same order as 
#                        your header for file2
#           
# make sure argument #3 is the prefix for your output file
#==========================================================================


# For making Table 5
import re
import sys

inFile1_name= sys.argv[1]
inFile2_name= sys.argv[2]
prefix = sys.argv[3]
outFile_name = prefix+"_LRreadCounts_forSQANTI3.txt"

# First creat dictionary for each conditions and counts

Final_dict = {}

inFile1 = open(inFile1_name, "r")
header_counter = 0
for line in inFile1:
    current_inFile = open(line.strip(), "r")
    current_dict = {}
    for line2 in current_inFile:
        if line2.startswith("G"):
            ID = line2.strip().split("\t")[0]
            count = line2.strip().split("\t")[1]
            current_dict[ID] = count
    current_inFile.close()
    Final_dict.update({header_counter:current_dict})
    header_counter += 1

inFile1.close()

#======================================
# Actually start to populate my table 5
out_dic_5 = {}

inFile2 = open(inFile2_name,"r")

for line in inFile2:
    if line.startswith("G"):
        info_line = line.strip().split("\t")
        
        if info_line[0] not in out_dic_5.keys():
            out_dic_5[info_line[0]]=[]
            for x in range (header_counter):
                out_dic_5[info_line[0]].append("NA")

        for i in range (header_counter):
            if info_line[i+1] != "NA":
                out_dic_5[info_line[0]][i] = Final_dict[i][info_line[i+1]]
inFile2.close()


#======================================
outFile = open(outFile_name,"w")


inFile1 = open(inFile1_name, "r")
out_header_list = ["superPBID"]
for line in inFile1:
    out_header_list.append(line.strip()[:-41])
inFile1.close()

# Writing header line for output file. 
outFile.write("\t".join(out_header_list)+"\n")

for key,value in out_dic_5.items():
    out_list = [key]
    for old_count in value:
        out_list.append(old_count)
    outFile.write("\t".join(out_list)+"\n")

outFile.close()


# In[ ]:




