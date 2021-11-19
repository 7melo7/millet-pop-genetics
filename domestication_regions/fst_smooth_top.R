library(readr)
library(dplyr)

setwd("~/project/domestication_regions")
pop_pair <- c("C3_vs_W", "C2_vs_W", "C1_vs_W", "C_vs_W", "C1_vs_C2", "C1_vs_C3")

for(i in pop_pair){
    fst <- read_tsv(file = paste0("~/project/PI_tajimaD_Fst_calculation/04_output_files/fst/smooth/", i, ".fst.smooth.100kb.10kb.txt")
                    , col_select = c(1, 3, 4, 5))
    fst_top5_regions <- slice_max(fst, AVAE, prop = 0.05) %>% select(1, 3, 4)
    write_tsv(fst_top5_regions, file = paste0("smooth_fst/fst_top5/",i,".fst.top5.smooth.100k.10k.txt"))
}
