library(tidyverse)
library(readr)
library(clusterProfiler)

args <- commandArgs(T)
gene_list <- args[1]

# read the standard Gene Ontology and KEGG annotation database
go_db <- read_tsv("~/dataset/mizi/go.db.tsv")
ko_db <- read_tsv("~/dataset/mizi/kegg.db.tsv")

# read genes from regions
set_genes <- read_tsv(paste0("gene_list/", gene_list), col_names = c("gene"))
set_genes <- as.vector(set_genes$gene)
        
if(length(set_genes)==0){
    next
}
# read longmi whole genome Gene Onotology and KEGG annotation
longmi_go <- read_tsv("~/dataset/mizi/longmi.go.tsv", col_names = c("gene", "GOID"))
#longmi_go <- read_tsv("/public1/home/liuyang/Project/58.function_anno/InterProScan/Pmlongmi4.go.tsv", col_names = c("gene", "GOID"))
#longmi_go <- read_tsv("~/dataset/mizi/longmi.go.tsv", col_names = c("gene", "GOID"))
longmi_ko <- read_tsv("~/dataset/mizi/longmi.kegg.tsv", col_names = c("gene", "KO"))

# prepare enricher data
go_term2gene <- left_join(longmi_go, go_db, by="GOID") %>% select("GOID", "gene")
go_term2name <- left_join(longmi_go, go_db, by="GOID") %>% select("GOID", "TERM")

names(go_term2gene) <- c("go_term", "gene")
names(go_term2name) <- c("go_term", "name")

kegg_term2gene <- left_join(longmi_ko, ko_db, by="KO") %>% select("KO", "gene")
kegg_term2name <- left_join(longmi_ko, ko_db, by="KO") %>% select("KO", "INFO")

names(kegg_term2gene) <- c("ko_term", "gene")
names(kegg_term2name) <- c("ko_term", "name")

# go enrich
go_enrich <- enricher(gene = set_genes, pvalueCutoff = 0.05, pAdjustMethod = "BH",
                     TERM2GENE = go_term2gene, TERM2NAME = go_term2name)
if(is.null(go_enrich)){
    next
}
go_enrich_result <- as_tibble(go_enrich@result) %>% arrange(p.adjust) %>% select("ID", "Description", "p.adjust")

write_tsv(go_enrich_result, file = paste0("enrichment/", gene_list, ".go.enrich.tsv"))

# go DAG plot
#pdf(file=paste0("enrichment/plot/", j, ".win_", i, ".go.bp.tree.pdf"), width=10, height=15)
#plotGOgraph(go_enrich)
#dev.off()

#pdf(file=paste0("enrichment/plot/", j, ".win_", i, ".go.mf.tree.pdf"), width=10, height=15)
#plotGOgraph(go_enrich.MF)
#dev.off()

#pdf(file=paste0("enrichment/plot/", j, ".win_", i, ".go.cc.tree.pdf"), width=10, height=15)
#plotGOgraph(go_enrich.CC)
#dev.off()
#barplot(c3_go_enrich, showCategory = 40)

# kegg enrich
ko_enrich <- enricher(gene = set_genes, pvalueCutoff = 0.05, pAdjustMethod = "BH",
                         TERM2GENE = kegg_term2gene, TERM2NAME = kegg_term2name)
if (is.null(ko_enrich)){
    next
}
ko_enrich_result <- as_tibble(ko_enrich@result) %>% arrange(p.adjust) %>% select("ID", "Description", "p.adjust")

write_tsv(ko_enrich_result, file = paste0("enrichment/", gene_list, ".ko.enrich.tsv"))
#barplot(all_ko_enrich, showCategory = 40)





