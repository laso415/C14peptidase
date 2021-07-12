#!/bin/bash
#phylogeny -  extract and trim sequences, align using MAFFT and reconstruct using IQ tree

# add outgroup species
cat outgroup.fasta metacaspase.fasta > metacaspase_ph.fasta
cat outgroup.fasta orthocaspase.fasta > orthocaspase_ph.fasta

# trim selected sequences using PeptidaseC14.hmm file
hmmalign --trim Peptidase_C14.hmm metacaspase_ph.fasta > metacaspase_hmmalign_ph.fasta
hmmalign --trim P20.hmm orthocaspase_ph.fasta > orthocaspase_hmmalign_ph.fasta

# seqmagick to remove gaps
seqmagick mogrify --ungap metacaspase_hmmalign_ph.fasta
seqmagick mogrify --ungap orthocaspase_hmmalign_ph.fasta

# mafft alignment
mafft --thread 4 --threadtb 5 --threadit 0 --reorder --auto --clustalout metacaspase_hmmalign_ph.fa > metacaspase_hmmalign_mafft_ph.aln
mafft --thread 4 --threadtb 5 --threadit 0 --reorder --auto --clustalout orthocaspase_hmmalign_ph.fa > orthocaspase_hmmalign_mafft_ph.aln

# IQ tree substitution model selection
iqtree -s metacaspase_hmmalign_mafft_ph.aln
iqtree -s orthocaspase_hmmalign_mafft_ph.aln 

# IQ tree phylogenetic reconstruction [x=subsitution model]
iqtree -s metacaspase_hmmalign_mafft_ph.aln -m x -bb 1000 -redo
iqtree -s orthocaspase_hmmalign_mafft_ph.aln -m x -bb 1000 -redo

