from genomeRegion.merge import overlap_regions 
from genomeRegion.basic import region_list_stat

paras = ["0.002", "0.005", "0.01"]
pops = ["C1_vs_C2", "C1_vs_C3", "C1_vs_W", "C2_vs_W", "C3_vs_W"]


for i in pops:
    for j in paras:
        overlap_regions("regions/"+i+".win_0.001.final.txt", "regions/"+i+".win_"+j+".final.txt", \
                        filename="tmp/"+i+".win_0.001_"+j+".overlap.region.txt", header=False)
        print(i+'\t0.01\tvs\t'+j+"\tstat:")
        region_list_stat("tmp/"+i+".win_0.001_"+j+".overlap.region.txt", header=False)
