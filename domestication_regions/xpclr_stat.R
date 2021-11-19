library(tidyverse)
library(readr)

args <- commandArgs(TRUE)
window_size <- args[1]
print(paste0("window size: ", window_size, " gWin(Morgan)"))

setwd("~/project/domestication_regions/")


xpclr_headers <- c("chr", "block", "snp", "start", "genetic_pos", "score", "max_s")

#vs_names <- c("C1_vs_W", "C2_vs_W", "C3_vs_W", "C1_vs_C2", "C_vs_W", "C1C3_vs_W")
vs_names <- c("C2_vs_C1", "C3_vs_C1")

for(i in vs_names){
    xpclr <- read_delim(paste0("~/project/XPCLR_calculation/04_output_files/merged_results/", i,".win_", window_size, ".txt"),
                        col_names = xpclr_headers, col_types="iiidddd")
    xpclr <- xpclr %>% filter(score!="inf")
    xpclr$score <- as.double(xpclr$score)
    top10_regions <- slice_max(xpclr, score, prop = 0.1) %>% select(1,4,6)
    top10_regions$end <- top10_regions$start + as.double(window_size)*10000000
    top10_regions <- select(top10_regions, 1, 2, 4, 3) %>% arrange(start)

    top5_regions <- slice_max(xpclr, score, prop = 0.05) %>% select(1,4,6)
    top5_regions$end <- top5_regions$start + as.double(window_size)*10000000
    top5_regions <- select(top5_regions, 1, 2, 4, 3) %>% arrange(start)

    top1_regions <- slice_max(xpclr, score, prop = 0.01) %>% select(1,4,6)
    top1_regions$end <- top1_regions$start + as.double(window_size)*10000000
    top1_regions <- select(top1_regions, 1, 2, 4, 3) %>% arrange(start)

    write_tsv(top10_regions, file = paste0("xpclr_top10/",i,".win_", as.character(window_size),".regions.txt"))
    write_tsv(top5_regions, file = paste0("xpclr_top5/",i,".win_", as.character(window_size),".regions.txt"))
    write_tsv(top1_regions, file = paste0("xpclr_top1/",i,".win_", as.character(window_size),".regions.txt"))
}




