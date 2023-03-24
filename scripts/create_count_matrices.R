#### Bone data ##############################################################
library(tidyverse)
library(tximport)
library(xlsx)



if(FALSE){
P <- "/media/triller/TOSHIBA\ EXT/Data/RNAseq/nonunion/"

bone_metadata <- read.table("./local/bone_metadata.tsv", sep = "\t", header = TRUE)
## only from 2D
bone_metadata <- bone_metadata %>% dplyr::filter(Condition == "2D")


## samples used (the samples Andre_S1 and Andre_S3 were swaped, for that reasen S3 is read in for S1 abd S1 for S3!)
samples_read_in <- bone_metadata$read_in
samples <- bone_metadata$GS_Code



 ## tximport data (read data directly from salmon output, quant.sf files)
fs <- file.path(paste0(P, "GS_rnaInput_", samples_read_in , ".csv", "/star_salmon/", samples_read_in, "/quant.sf"))
names(fs) <- samples
## tx2gene always the same for the same reference genome
tx2gene <- read.table(paste0(P, "GS_rnaInput_", samples_read_in[1] , ".csv", "/star_salmon/salmon_tx2gene.tsv"))
tx_data <- tximport(fs, type = "salmon", tx2gene = tx2gene, countsFromAbundance = "lengthScaledTPM")
saveRDS(tx_data,"./local/bone_tximport_lengthScaledTPM.rds")
counts <- tx_data[["abundance"]]
counts <- counts %>% as.data.frame() %>% tibble::rownames_to_column("gene")
write.table(counts, "./local/bone_tximport_lengthScaledTPM.tsv", quote = TRUE, sep = "\t", col.names = TRUE, row.names = FALSE )


}

#### prostate cancer data (rapalink) ###########################################

if(FALSE){
P <- "/media/triller/TOSHIBA\ EXT/Data/RNAseq/rapalink/"

rapalink_metadata <- read.table("./local/rapalink_metadata.txt", sep = "\t", header = TRUE)

samples <- rapalink_metadata$GenomeScanID

fs <- file.path(paste0(P, "GS_", samples, "/star_salmon/", samples, "/quant.sf"))
names(fs) <- samples
tx2gene <- read.table(paste0(P, "GS_", samples[1] , "/star_salmon/salmon_tx2gene.tsv"))
tx_data <- tximport(fs, type = "salmon", tx2gene = tx2gene, countsFromAbundance = "lengthScaledTPM")
saveRDS(tx_data,"./local/rapalink_tximport_lengthScaledTPM.rds")
counts <- tx_data[["abundance"]]
counts <- counts %>% as.data.frame() %>% tibble::rownames_to_column("gene")
write.table(counts, "./local/rapalink_tximport_lengthScaledTPM.tsv", quote = TRUE, sep = "\t", col.names = TRUE, row.names = FALSE )
}
