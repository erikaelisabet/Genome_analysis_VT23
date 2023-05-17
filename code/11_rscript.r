if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")

BiocManager::install("DESeq2", force = TRUE)
BiocManager::install("apeglm")
BiocManager::install("heatmaps")
BiocManager::install("pheatmap")


library(apeglm)
library(DESeq2)
library(ggplot2)
library("pheatmap")

Input_count = "/Users/46705/Desktop/Genom_analys"
Input_info = "/Users/46705/Desktop/Genom_analys/culture.csv"
output = "/Users/46705/Desktop/Genom_analys"


sampleFiles <- list.files(path = Input_count,pattern = ".txt")
sampleCondition = read.csv(Input_info, row.names = 1)
sampleCondition <- sampleCondition[,c("culture")]
sampleTable <- data.frame(sampleName = gsub("_out_HTseq.txt", "", sampleFiles), 
                          fileName = sampleFiles,
                          condition = sampleCondition)

sampleTable$condition <- factor(sampleTable$condition)

ddsHTSeq <- DESeqDataSetFromHTSeqCount(sampleTable = sampleTable,
                                       directory = Input_count,
                                       design= ~ condition)
dds <- DESeq(ddsHTSeq)
keep <- rowSums(counts(dds)) >= 100
dds <- dds[keep,]
res <- results(dds, name="condition_continues_vs_chalcopyrite")
res <- results(dds, contrast = c("condition", "chalcopyrite", "continues"))

resultsNames(dds)
reslfc = lfcShrink(dds, coef = "condition_continues_vs_chalcopyrite", type = "apeglm")

summaryy <- summary(reslfc)
write.csv(summaryy, "resulfc_summary.csv" , row.names=TRUE)

resOrdered_l2fc <- res[order(abs(res$log2FoldChange), decreasing = TRUE),]

vsd = vst(dds)
plotPCA(vsd, intgroup=c("condition"))

plotMA(res, ylim=c(-2,2))
plotMA(reslfc, ylim=c(-2,2))


sum(res$padj < 0.0010, na.rm=TRUE)
plotCounts(dds, gene=which.max(abs(res$log2FoldChange)), intgroup="condition")

significant <- rownames(resOrdered_l2fc[1:20, ])

colData(dds2) 
dds2 <- vst(dds)

colData(dds2)$sizeFactor <- c("29", "30", "31", "32", "33")
colnames(colData(dds2)) <- c("condition", "sample name")
df <- as.data.frame(colData(dds2)[,c("condition", "sample name")])
pheatmap(assay(dds2)[rownames(dds2) %in% significant, ], cluster_rows=FALSE, show_rownames=TRUE,
         cluster_cols=TRUE, annotation_col=df)


write.csv(resOrdered_l2fc, "resOrdered_l2fc.csv" , row.names=TRUE)
