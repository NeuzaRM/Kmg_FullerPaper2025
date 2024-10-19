#!/bin/bash
#SBATCH -J CAGEr   # name of the job
#SBATCH --mem-per-cpu=10G     # reserve 30G (per processor) of memory for the job
#SBATCH -t 24:0:0    # the job will be killed after 24hr if still not completed
#SBATCH -p batch    # the queue to send it to. Keep this as it is.
#SBATCH --account=mtfuller   # SUNID of your PI


cd $SLURM_SUBMIT_DIR



for input in *_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr_fw_count.txt
do
output1=`echo $input | sed 's/_trimmed_clean_Aligned.sortedByCoord.out.Q255.chr_fw_count.txt/_fw_ctts.txt/'`
awk '{ if ($3 > 0) { print } }' $input | awk '{print $1, $2, "+", $3}' | awk -v OFS='\t' '{$4=sprintf("%.0f",$4)}7' > $output1

input2=`echo $input | sed 's/_fw/_rv/'`
output2=`echo $output1 | sed 's/_fw/_rv/'`
awk '{ if ($3 > 0) { print } }' $input2 | awk '{print $1, $2, "-", $3}' | awk -v OFS='\t' '{$4=sprintf("%.0f",$4)}7' > $output2

output3=`echo $output2 | sed 's/_rv//'`
cat $output1 $output2 | sort -k1,1 -k2,2n > $output3
done
