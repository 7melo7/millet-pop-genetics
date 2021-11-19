##/usr/bin/bash
#!/bin/bash
#PBS -l nodes=1:ppn=5
#PBS -l mem=20b
#PBS -l walltime=40:00:00
#PBS -d ./
#PBS -j oe
#PBS -V

cd $PBS_O_WORKDIR

start=`date +%s`

CPU=$PBS_NP
if [ ! $CPU ]; then
   CPU=2
fi

N=$PBS_ARRAYID
if [ ! $N ]; then
    N=1
fi

echo "$CPU"
echo "$N"

vcf=BC_516_merged.SNP.vcf.gz
vcftools=/public1/home/guowl/software/vcftools_0.1.13/bin/vcftools


#pops=("C1" "C2" "C3" "C")
pops=("C")
window_size=(10000 20000 50000 100000)
window_step=(1000 2000 5000 10000)

# calculate the tajimaD for each group
#mkdir ../04_output_files/tajimaD
for i in ${pops[*]};do
#    mkdir ../04_output_files/tajimaD/${i}
    vk tajima ${window_size[${N}]} ${window_step[${N}]} \
    ../02_input_files/${i}.vcf.gz > ../04_output_files/tajimaD/${i}/${i}.win_${window_size[${N}]}.tajima 
done


end=`date +%s`
runtime=$((end-start))

echo "Start: $start"
echo "End: $end"
echo "Run time: $runtime"

echo "Done"

