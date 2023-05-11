if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("DESeq2", force = TRUE)

if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("apeglm")

library(apeglm)
library(DESeq2)
library(ggplot2)



Input_count = "/Users/46705/Desktop/Genom_analys"
Input_info = "/Users/46705/Desktop/Genom_analys/culture.csv"
output = "/Users/46705/Desktop/Genom_analys"

##newway

sampleFiles <- list.files(path = Input_count,pattern = ".txt")
sampleCondition = read.csv(Input_info, row.names = 1)
sampleCondition <- sampleCondition[,c("culture")]
sampleTable <- data.frame(sampleName = gsub("_out_HTseq.txt", "", sampleFiles), 
                          fileName = sampleFiles,
                          condition = sampleCondition)

sampleTable$condition <- factor(sampleTable$condition)


library("DESeq2")
ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                                       directory = Input_count,
                                       design= ~ condition)
ddsHTSeq

dds <- DESeq(ddsHTSeq)
keep <- rowSums(counts(dds)) >= 10
dds <- dds[keep,]
res <- results(dds, name="condition_continues_vs_chalcopyrite")
res <- results(dds, contrast = c("condition", "chalcopyrite", "continues"))

resultsNames(dds)
reslfc = lfcShrink(dds, coef = "condition_continues_vs_chalcopyrite", type = "apeglm")

reslfc

summary(res)

resOrdered <- res[order(res$pvalue),]
summary(reslfc)

vsd = vst(dds)
plotPCA(vsd, intgroup=c("condition", "sizeFactor"))

plotMA(res, ylim=c(-2,2))
plotMA(reslfc, ylim=c(-2,2))


sum(res$padj < 0.1, na.rm=TRUE)
plotCounts(dds, gene=which.min(res$padj), intgroup="condition")
