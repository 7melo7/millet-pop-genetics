#!/usr/bin/bash
top_size=(5 10)

for i in ${top_size[*]};do
    for j in `ls xpclr_top/xpclr_top${i}_merged`;do
        bedtools intersect -wa -a longmi.bed -b xpclr_top/xpclr_top${i}_merged/${j} > \
        tmp_regions.txt
        mkdir xpclr_top/xpclr_top${i}_merged/gene_list
        cut -f4 tmp_regions.txt | sort | uniq > xpclr_top/xpclr_top${i}_merged/gene_list/${j}.gene.list
    done
done
