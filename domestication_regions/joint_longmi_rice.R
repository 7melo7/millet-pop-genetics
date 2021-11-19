library(dplyr)
library(readr)
library(tidyverse)

setwd("D:\\guowl_project\\population_genetics\\domestication_regions_filtering")

c1_gene <- read_tsv("c1.filter.gene.list", col_names = c("longmi_gene"))
c2_gene <- read_tsv("c2.filter.gene.list", col_names = c("longmi_gene"))
c3_gene <- read_tsv("c3.filter.gene.list", col_names = c("longmi_gene"))

longmi2rice <- read_tsv("Longmi_gene2rice.txt", col_names = c("longmi_gene", "rice_gene"))
rice_annotation <- read_tsv("Longmi_rice_geneInfo.table.txt")

longmi2rice <- left_join(longmi2rice, rice_annotation, by=c("rice_gene"))

c1_2_rice <- left_join(c1_gene, longmi2rice, by=c("longmi_gene")) %>% drop_na("rice_gene")
c2_2_rice <- left_join(c2_gene, longmi2rice, by=c("longmi_gene")) %>% drop_na("rice_gene")
c3_2_rice <- left_join(c3_gene, longmi2rice, by=c("longmi_gene")) %>% drop_na("rice_gene")

write_tsv(c1_2_rice, file = "c1_rice.gene.txt")
write_tsv(c2_2_rice, file = "c2_rice.gene.txt")
write_tsv(c3_2_rice, file = "c3_rice.gene.txt")
