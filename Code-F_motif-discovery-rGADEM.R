# The approach is based on Unsupervised motif discovery tutorial from https://compgenomr.github.io/book/motif-discovery.html

# read the CTCF peaks created in the peak calling part of the tutorial
ctcf_peaks = read.table('../motif-analysis/CTCF_peaks.txt', header=TRUE)



# install the R package 'rGADEM' and 'GenomicRanges' package using Bioconductor package manager

BiocManager::install("rGADEM")
BiocManager::install("GenomicRanges")
BiocManager::install("Biostrings")

library(GenomicRanges)

# convert the peaks into a GRanges object
ctcf_peaks = makeGRangesFromDataFrame(ctcf_peaks, keep.extra.columns = TRUE)

# order the peaks by qvalue, and take top 250 peaks
ctcf_peaks = ctcf_peaks[order(ctcf_peaks$qvalue)]
ctcf_peaks = head(ctcf_peaks, n = 500)

# merge nearby CTCF peaks
ctcf_peaks = reduce(ctcf_peaks)

# expand the CTCF peaks
ctcf_peaks_resized = resize(ctcf_peaks, width = 50, fix='center')

library(Biostrings)
library(dplyr)

prom_core_data= read.csv(file = '../motif-analysis/train_prom_core_seq.tsv', header = TRUE, sep='\t', stringsAsFactors = FALSE)
prom_300_data= read.csv(file = '../motif-analysis/train_prom300_seq.tsv', header = TRUE, sep='\t', stringsAsFactors = FALSE)
enh_cohn_data= read.csv(file = '../motif-analysis/train_enhancer_cohn_seq.tsv', header = TRUE, sep='\t', stringsAsFactors = FALSE)

# We target 'DNAStringSet' of the 'Biostrings' package
prom_core_dna_seqs= DNAStringSet(prom_core_data$sequence[1:2000])
prom300_dna_seqs_1000= DNAStringSet(prom_300_data$sequence[1:1000])
enh_500_dna_seqs_1000= DNAStringSet(enh_cohn_data$sequence[1:1000])

library(rGADEM)

novel_motifs_2000_prom_core= novel_motifs
novel_motifs_2000_prom_core_wordGrp4= novel_motifs

# prom 300
novel_motifs_prom300= GADEM(prom300_dna_seqs_1000, seed = 123, nmotifs = 10, verbose=1, genome = 'Hsapiens', stopCriterion=5, numEM=80, maxSpaceWidth=0, maskR = 1)

# enhancers cohn 500
novel_motifs_enh500= GADEM(enh_500_dna_seqs_1000, seed = 123, nmotifs = 10, verbose=1, genome = 'Hsapiens', stopCriterion=5, numEM=80, maxSpaceWidth=0, maskR = 1)
