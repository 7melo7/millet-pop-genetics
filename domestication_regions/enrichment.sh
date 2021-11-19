#!/usr/bin/bash

for i in `ls gene_list`;do
    Rscript region_enrichment.R ${i}
done
