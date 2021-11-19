#!/usr/bin/bash

top_size=(5)
pops=("C1_vs_C2" "C1_vs_C3" "C1_vs_W" "C2_vs_W" "C3_vs_W" "C_vs_W")

for i in ${top_size[*]};do
    for j in ${pops[*]};do
        # filter by xpclr, fst, pi

        #bedtools intersect -wa -a xpclr_top/xpclr_top${i}_merged/${j}.win_0.002.regions.txt \
        #-b pi_top/pi_top${i}_merged/${j}.top${i}.pi.win_20000.regions.txt > tmp
        #bedtools intersect -wa -a tmp -b fst_top/fst_top${i}_merged/${j}.fst.top${i}.win_20000.regions.txt > \
        #regions/${j}.top${i}.20kb.regions.txt
        #rm tmp
        # filter by xpclr, fst
        bedtools intersect -a xpclr_top/xpclr_top${i}_merged/${j}.win_0.01.regions.txt \
        -b fst_top/fst_top${i}_merged/${j}.fst.top${i}.win_100000.regions.txt > \
        regions_tmp/${j}.xpclr.fst.top${i}.win_100000.regions.txt
        bedtools intersect -a regions_tmp/${j}.xpclr.fst.top${i}.win_100000.regions.txt \
        -b pi_top/pi_top50_merged/${j}.top50.pi.win_100000.regions.txt > \
        regions/${j}.top${i}.100kb.regions.txt

        bedtools intersect -wa -a longmi.bed -b regions_tmp/${j}.xpclr.fst.top${i}.win_100000.regions.txt > \
        gene_list_tmp/${j}.top${i}.100kb.gene.txt
        bedtools intersect -wa -a longmi.bed -b regions/${j}.top${i}.100kb.regions.txt > \
        gene_list/${j}.top${i}.100kb.gene.txt

        bedtools intersect -a xpclr_top/xpclr_top${i}_merged/${j}.win_0.001.regions.txt \
        -b fst_top/fst_top${i}_merged/${j}.fst.top${i}.win_10000.regions.txt > \
        regions_tmp/${j}.xpclr.fst.top${i}.win_10000.regions.txt
        bedtools intersect -a regions_tmp/${j}.xpclr.fst.top${i}.win_10000.regions.txt \
        -b pi_top/pi_top50_merged/${j}.top50.pi.win_10000.regions.txt > \
        regions/${j}.top${i}.10kb.regions.txt

        bedtools intersect -wa -a longmi.bed -b regions_tmp/${j}.xpclr.fst.top${i}.win_10000.regions.txt > \
        gene_list_tmp/${j}.top${i}.10kb.gene.txt
        bedtools intersect -wa -a longmi.bed -b regions/${j}.top${i}.10kb.regions.txt > \
        gene_list/${j}.top${i}.10kb.gene.txt

        bedtools intersect -a xpclr_top/xpclr_top${i}_merged/${j}.win_0.005.regions.txt \
        -b fst_top/fst_top${i}_merged/${j}.fst.top${i}.win_50000.regions.txt > \
        regions_tmp/${j}.xpclr.fst.top${i}.win_50000.regions.txt
        bedtools intersect -a regions_tmp/${j}.xpclr.fst.top${i}.win_50000.regions.txt \
        -b pi_top/pi_top50_merged/${j}.top50.pi.win_50000.regions.txt > \
        regions/${j}.top${i}.50kb.regions.txt

        bedtools intersect -wa -a longmi.bed -b regions_tmp/${j}.xpclr.fst.top${i}.win_50000.regions.txt > \
        gene_list_tmp/${j}.top${i}.50kb.gene.txt
        bedtools intersect -wa -a longmi.bed -b regions/${j}.top${i}.50kb.regions.txt > \
        gene_list/${j}.top${i}.50kb.gene.txt


        bedtools intersect -a xpclr_top/xpclr_top${i}_merged/${j}.win_0.002.regions.txt \
        -b fst_top/fst_top${i}_merged/${j}.fst.top${i}.win_20000.regions.txt > \
        regions_tmp/${j}.xpclr.fst.top${i}.win_20000.regions.txt
        bedtools intersect -a regions_tmp/${j}.xpclr.fst.top${i}.win_20000.regions.txt \
        -b pi_top/pi_top50_merged/${j}.top50.pi.win_20000.regions.txt > \
        regions/${j}.top${i}.20kb.regions.txt

        bedtools intersect -wa -a longmi.bed -b regions_tmp/${j}.xpclr.fst.top${i}.win_20000.regions.txt > \
        gene_list_tmp/${j}.top${i}.20kb.gene.txt
        bedtools intersect -wa -a longmi.bed -b regions/${j}.top${i}.20kb.regions.txt > \
        gene_list/${j}.top${i}.20kb.gene.txt

    done
done

for i in `ls gene_list`;do
    cut -f4 gene_list/${i} | sort | uniq > tmp
    mv tmp gene_list/${i}
done

for i in `ls gene_list_tmp`;do
    cut -f4 gene_list_tmp/${i} | sort | uniq > tmp
    mv tmp gene_list_tmp/${i}
done

