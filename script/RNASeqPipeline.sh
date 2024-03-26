#!/bin/bash

SECONDS=0

# change working directory
cd /home/saloni123/RNASeq_Pipeline/


# STEP 1: Run fastqc
fastqc data/MOV10_OE1.fastq -o data/


# run trimmomatic to trim reads with poor quality
# java -jar "/usr/share/java/trimmomatic-0.39.jar" SE -threads 4 data/MOV10_OE1.fastq data/MOV10_OE1_trimmed.fastq TRAILING:10 -phred33
# echo "Trimmomatic finished running!"

# fastqc data/MOV10_OE1_trimmed.fastq -o data/

# STEP 2: Run HISAT2
# mkdir HISAT2
# get the genome indices
# wget https://genome-idx.s3.amazonaws.com/hisat/grch38_genome.tar.gz
# tar -xf grch38_genome.tar.gz -C /home/saloni123/RNASeq_Pipeline/HISAT2


# run alignment
hisat2 -q --rna-strandness R -x HISAT2/grch38/genome -U data/MOV10_OE1_trimmed.fastq -S HISAT2/MOV10_OE1_trimmed.sam
samtools view -S -b HISAT2/MOV10_OE1_trimmed.sam | samtools sort -o HISAT2/MOV10_OE1_trimmed_sorted.bam
# samtools view -h HISAT2/MOV10_OE1_trimmed_sorted.bam | less
echo "HISAT2 finished running!"



# STEP 3: Run featureCounts - Quantification

# get gtf
# wget http://ftp.ensembl.org/pub/release-106/gtf/homo_sapiens/Homo_sapiens.GRCh38.106.gtf.gz
# sudo apt install subread 

featureCounts -s 2 -a hg38/Homo_sapiens.GRCh38.106.gtf -o quants/MOV10_OE1_featurecounts.txt HISAT2/MOV10_OE1_trimmed_sorted.bam
echo "featureCounts finished running!"

duration=$SECONDS
echo "$(($duration / 60)) minutes and $(($duration %60)) seconds elapsed." 