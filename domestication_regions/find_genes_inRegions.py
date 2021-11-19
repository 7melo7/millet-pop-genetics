#!/usr/bin/python
# coding=utf-8
import argparse

parser = argparse.ArgumentParser(description="example:\n\tpython find_gene_inRegions.py --region regions.txt --bed spe.bed -o gene.list")
parser.add_argument("--region", type=str)
parser.add_argument("--bed", type=str)
parser.add_argument("-o", type=str, default="gene.list")
args = parser.parse_args()


def read_bed(filename):
	bed_list = []
	with open(filename, 'r') as f:
		for i in f.readlines()[1:]:
			temp = i.strip().split("\t")
			bed_list.append([int(temp[0]), int(temp[1]), int(temp[2]), temp[3]])
	return bed_list



def read_gene_regions(filename):
	region_list = []
	with open(filename, 'r') as f:
		for i in f.readlines()[1:]:
			temp = i.strip().split("\t")
			region_list.append([int(temp[0]), int(temp[1]), int(temp[2])])
	return region_list


def find_genes_inRegion(bed_list, region_list, filename):
	gene_list = []
	for i in region_list:
		for j in bed_list:
			if(j[0] == i[0] and j[1]>i[1] and j[2]<i[2]):
				gene_list.append(j[3]+'\n')

	with open(filename, 'w') as f:
		f.writelines(gene_list)	




if __name__ == "__main__":
	bed_list = read_bed(args.bed)
	region_list = read_gene_regions(args.region)
	find_genes_inRegion(bed_list, region_list, args.o)
