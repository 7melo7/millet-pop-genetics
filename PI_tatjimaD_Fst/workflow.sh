#!/bin/bash

population_group=("C1" "C2" "C3" "W")
window_size=("10kb" "20kb" "50kb" "100kb")

echo "Four types of MIZI samples: ${population_group[*]}"
echo "caculate with four different window size: ${window_size[*]}"

# prepare the sample information files

#echo "spliting the populations"
#for i in ${population_group[*]}; do
#    cut -f1,12 ../02_input_files/Mizi.pop.structure.txt | grep ${i} | cut -f1 > ../03_intermediate_files/${i}.samples.txt 
#done

# prepare the merged variant call information file
echo "linking the vcf data."
# ln -s /public1/home/chenjf/Share/Millet_Data/04.SNP_calling_replace_6strain/BC_516_merge.pass.SNP_INDEL.6_update.MAF_0.05.Miss_0.2.SNP.noprefix.vcf.gz \
# /public1/home/guowl/project/PI_tajimaD_Fst_calculation/02_input_files/BC_516_merged.SNP.vcf.gz



qsub calculate_pi_tajimaD_fst.sh
