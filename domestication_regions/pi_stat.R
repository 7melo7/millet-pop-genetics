library(ggplot2)
library(readr)
library(dplyr)


# there are 3 PI dataset including 10k win 1k step, 20k win 2k step, 50k win 5k step, 100k win 10k step

win_args <- c("10000", "20000", "50000", "100000")
pops <- c("C2", "C3", "W")

# create the 10k window PI datasets

for(i in win_args){
    PI <- read_tsv(paste0("../PI_tajimaD_Fst_calculation/04_output_files/pi/C1/C1.win_", i, ".windowed.pi"), col_types="iiiid")
    PI$POP <- "C1"
    for(j in pops){
        temp <- read_tsv(paste0("../PI_tajimaD_Fst_calculation/04_output_files/pi/", j,"/", j, ".win_", i,".windowed.pi"),
                                     col_types="iiiid")
        temp$POP <- j
        PI <- bind_rows(PI, temp) %>% na.omit()
    }
    PI_stat <- PI %>% group_by(POP) %>% summarise(agv_pi = mean(PI),
                                                  sd_pi = sd(PI),
                                                  min_pi = min(PI),
                                                  max_pi = max(PI))
    write_tsv(PI_stat, file=paste0("pi.win", i,".stat.txt"))
}



