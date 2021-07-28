#!/bin/bash
# Hmmsearch sequences to Peptidase_C14 HMM profile
hmmsearch --domtblout C14_hmmsearch.txt -E0.00001 Peptidase_C14.hmm C14.fasta

# Get ID of sequences with E<=0.00001
awk '{print $1}' C14_hmmsearch.txt > C14_hmmsearch_ID

# filter 989.fasta to only possess sequences with E<=0.00001 [The extract_select_seqs.py script can be found at https://github.com/PiscatorX/barcode-rapidus/blob/master/extract_select_seqs.py ]
./extract_select_seqs.py -l C14_hmmsearch_ID C14.fasta > C14_hmmsearch.fasta

#Align sequences to Peptidase_C14 HMM profile
hmmalign --trim Peptidase_C14.hmm C14_filtered.fasta > C14_filtered.sto

#Alignment is used to visually inspect the alignment and save the final alignment


