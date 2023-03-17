#### Bone HB data ##############################################################
library(tidyverse)
library(tximport)
library(xlsx)
source("./../../nonunion_bone/analysis/scripts/helper_functions.R")

metadata <- get_metadata()
metadata$Timecourse <- factor(metadata$Timecourse, levels = sort(unique(metadata$Timecourse)))
metadata$Batch <- factor(metadata$Batch, levels = sort(unique(metadata$Batch)))
metadata$Sex <- factor(metadata$Sex, levels = sort(unique(metadata$Sex)))
metadata$Type <- factor(metadata$Type, levels = c("HB", "CA", "NU") )
metadata$Age.patient <- factor(metadata$Age.patient)


P <- "/media/triller/TOSHIBA\ EXT/Data/RNAseq/nonunion/"

