#### Bone HB data ##############################################################
library(tidyverse)
library(tximport)
library(xlsx)

if(FALSE){
P <- "/media/triller/TOSHIBA\ EXT/Data/RNAseq/nonunion/"

bone_metadata <- read.table("./local/bone_metadata.tsv", sep = "\t", header = TRUE)
## only HB samples from 2D
bone_metadata <- bone_metadata %>% dplyr::filter(Condition == "2D")

## samples used (the samples Andre_S1 and Andre_S3 were swaped, for that reasen S3 is read in for S1 abd S1 for S3!)
samples_read_in <- bone_metadata$read_in
samples <- bone_metadata$Sample_file_name

## tximport data (read data directly from salmon output, quant.sf files)
fs <- file.path(paste0(P, "GS_rnaInput_", samples_read_in , ".csv", "/star_salmon/", samples_read_in, "/quant.sf"))
names(fs) <- samples
## tx2gene always the same for the same reference genome
tx2gene <- read.table(paste0(P, "GS_rnaInput_", samples_read_in[1] , ".csv", "/star_salmon/salmon_tx2gene.tsv"))
tx_data <- tximport(fs, type = "salmon", tx2gene = tx2gene, countsFromAbundance = "lengthScaledTPM")
rownames(bone_metadata) <- bone_metadata$Sample_file_name
}

saveRDS("./local/bone_tximport.rds")

tx_data$countsFromAbundance
