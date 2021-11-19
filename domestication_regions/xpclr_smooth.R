library(tidyverse)
library(readr)

setwd("~/project/domestication_regions/smooth_xpclr")



vs_names <- c("C1_vs_W", "C2_vs_W", "C3_vs_W", "C1_vs_C2", "C_vs_W", "C1_vs_C3")

for(i in vs_names){
    xpclr <- read_delim(paste0("~/project/XPCLR_calculation/04_output_files/smooth/", i,".smooth.100kb.10kb.txt"),
                        , col_types="iidii")

    xpclr <- xpclr %>% filter(AVAE!="Inf")

    top5_regions <- slice_max(xpclr, AVAE, prop = 0.05)
    top5_regions <- select(top5_regions, 1, 4, 5, 3) %>% arrange(START)

    write_tsv(top5_regions, file = paste0("xpclr_top5/",i,".smooth.top5.100kb.10kb.txt"))
}




