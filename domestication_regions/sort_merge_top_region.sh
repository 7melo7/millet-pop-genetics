#!/usr/bin/bash

#top_size=(1 5 10)
#top_index=("pi" "fst" "xpclr")

top_size=(10)
top_index=("tajimaD")

#for i in ${top_index[*]};do
#    for j in ${top_size[*]};do
#        for k in `ls ${i}_top/${i}_top${j}`;do
#            echo ${k}
#            sort -k1,1 -k2,2n ${i}_top/${i}_top${j}/${k} > ${i}_top/${i}_top${j}_sorted/${k}
#            bedtools merge -i ${i}_top/${i}_top${j}_sorted/${k} > ${i}_top/${i}_top${j}_merged/${k}
#        done
#    done
#done

index="fst"

for i in `ls smooth_${index}/${index}_top5`;do
    sort -k1,1 -k2,2n smooth_${index}/${index}_top5/${i} > smooth_${index}/${index}_top5_sorted/${i}
    bedtools merge -i smooth_${index}/${index}_top5_sorted/${i} > smooth_${index}/${index}_top5_merged/${i}
done
