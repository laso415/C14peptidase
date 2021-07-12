#!/bin/bash
# search for p20 subunit using the p20 HMM profile
hmmsearch --domtblout p20.txt -E0.00001 P20.hmm C14_filtered_HC.fasta

# search for immunoglobulin subunits using the HMM profiles
hmmsearch --domtblout ig.txt -E0.00001 ig.hmm C14_filtered_HC.fasta
hmmsearch --domtblout ig2.txt -E0.00001 ig2.hmm C14_filtered_HC.fasta
hmmsearch --domtblout ig3.txt -E0.00001 ig3.hmm C14_filtered_HC.fasta

# search for p10 subunit using the p20 HMM profile
hmmsearch --domtblout p10.txt -E0.00001 P10.hmm C14_filtered_HC.fasta

# get IDs 
awk '{print $1}' p20.txt > p20_hmmsearch_ID
awk '{print $1}' p10.txt > p10_hmmsearch_ID
awk '{print $1}' ig.txt > ig_hmmsearch_ID
awk '{print $1}' ig2.txt > ig2_hmmsearch_ID
awk '{print $1}' ig3.txt > ig3_hmmsearch_ID

# sort lists
sort p20_hmmsearch_ID > p20_hmmsearch_ID_sorted
sort p10_hmmsearch_ID > p10_hmmsearch_ID_sorted
sort ig_hmmsearch_ID > ig_hmmsearch_ID_sorted
sort ig2_hmmsearch_ID > ig2_hmmsearch_ID_sorted
sort ig3_hmmsearch_ID > ig3_hmmsearch_ID_sorted

# remove duplicates in the list
uniq p20_hmmsearch_ID_sorted > p20_hmmsearch_ID_sorted_uniq
uniq p10_hmmsearch_ID_sorted > p10_hmmsearch_ID_sorted_uniq
uniq ig_hmmsearch_ID_sorted > ig_hmmsearch_ID_sorted_uniq
uniq ig2_hmmsearch_ID_sorted > ig2_hmmsearch_ID_sorted_uniq
uniq ig3_hmmsearch_ID_sorted > ig3_hmmsearch_ID_sorted_uniq

#find the orthocaspases
comm -23 p20_hmmsearch_ID_sorted_uniq p10_hmmsearch_ID_sorted_uniq > orthocaspase_ID
./extract_select_seqs.py -l orthocaspase_ID C14_filtered_HC.fasta
mv extract_C14_filtered_HC.fasta orthocaspase.fasta

#find the metacaspases
mv p10_hmmsearch_ID_sorted_uniq metacaspase_ID
./extract_select_seqs.py -l metacaspase_ID C14_filtered_HC.fasta
mv extract_C14_filtered_HC.fasta metacaspase.fasta


