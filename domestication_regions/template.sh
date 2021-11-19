##/usr/bin/bash
#!/bin/bash
#PBS -N region_workflow
#PBS -l nodes=1:ppn=5
#PBS -l walltime=9999:00:00
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

base_dir=/public1/home/guowl/project/domestication_regions

mapfile -t methods < $base_dir/methods
mapfile -t topsize < $base_dir/topsize

method=${methods[${N}]}
size=${topsize[${N}]}

#mkdir ${method}_${size}_enrichment
#mkdir ${method}_${size}_gene_list
#mkdir ${method}_${size}_regions 
#python3 region_merge_filter.py ${size} ${method} >> ${size}_${method}.stat 
Rscript region_enrichment.R ${method} ${size}

end=`date +%s`
runtime=$((end-start))

echo "Start: $start"
echo "End: $end"
echo "Run time: $runtime"

echo "Done"

