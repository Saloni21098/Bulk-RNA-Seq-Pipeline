# 24-03-2024
# script to obtain Ensembl IDs and raw counts from MOV10_OE1_featurecounts.txt and 
# convert ensembl ids to gene ids
# setwd("C:/Users/salon/OneDrive/Desktop/DeSeq2")

# Load the libraries
library(tidyverse)
library(biomaRt)

data <- read.table(file = 'MOV10_OE1_featurecounts.txt', header = T)
df <- data.frame(data)
ensembl_id <- df[,c(1,7)]

# Reshaping data
ensembl_id <- ensembl_id %>% 
  rename(Ensembl_Id = Geneid , Raw_counts = HISAT2.MOV10_OE1_trimmed_sorted.bam) %>% 
  filter(Raw_counts > 0)

# conversion of ensembl_id to gene_id using biomaRt
listEnsembl()
ensembl <- useEnsembl(biomart = 'genes')
dataset <- listDatasets(ensembl)

ensembl_con <- useMart('ensembl', dataset = 'hsapiens_gene_ensembl')

attr <- listAttributes(ensembl_con)
fil <- listFilters(ensembl_con)

output <- getBM(attributes = c('ensembl_gene_id', 'external_gene_name'),
      filters = 'ensembl_gene_id',
      values = ensembl_id$Ensembl_Id,
      mart = ensembl_con)

result <- data.frame(output)

