# Bulk RNA-Seq Pipeline to generate raw counts in bash
This repository contains a bash script which is used to build a bulk RNA sequence pipeline and an R script for obtaining gene ids.

### Requirements:
•	FastQC (v0.11.9)
•	Trimmomatic (v0.39)
•	HISAT2 (v2.2.1)
•	featureCounts (v2.0.3)
•	R (v4.2.1)

### Data used:
GSM1220264: MOV10 overexpression 1; Homo sapiens; RNA-Seq - SRA - NCBI (nih.gov)
(FMRP-associated MOV10 facilitates and antagonizes miRNA-mediated regulation)
(.fastq read file)

### Result:
The txt file generated at the end of the pipeline contains seven fields.
Out of these, the first (Geneid) and the last (raw counts) column were extracted using R script (demo.R)
From this data, the ensembl ids with raw counts > 0 are extracted and these ensemble ids are converted to gene ids and symbols. 
 

### Conclusion:
For some of the gene ids the counts are 0 but there are certain numbers corresponding to certain gene ids with their corresponding counts.
Since featureCounts is run with only one sample in this case, there is only one column corresponding to counts but if featureCounts is run with multiple bam files, there would be multiple columns corresponding to multiple samples and each of these columns would have counts that will correspond to the gene ids.
These counts are raw counts and these counts can be eventually used to generate a count matrix from GEOquery package in R which can be used to perform differential gene expression analysis for further studies.
