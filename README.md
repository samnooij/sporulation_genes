# Sporulation genes

Sporulation genes listed in the file `sporulation_genes.tsv` are
the genes identified by
[Galperin et al., 2012](https://doi.org/10.1111/j.1462-2920.2012.02841.x)
and supplemented with
[Galperin et al., 2022](https://doi.org/10.1128/jb.00079-22).
See their 2012 [table 3](https://enviromicro-journals.onlinelibrary.wiley.com/doi/10.1111/j.1462-2920.2012.02841.x#t3),
and 2022 [table 1](https://journals.asm.org/doi/10.1128/jb.00079-22#T1).

Next, their sequences were looked up online in UniProt, using for example
https://www.uniprot.org/uniprotkb?query=(gene%3Aspo0a)+AND+(organism_id%3A224308)

Genes were searched by name, preferentially using the sequences for _Bacillus subtilis_
(strain 168) as reference. If _B. subtilis_ did not have the gene, a close
relative was selected if possible and otherwise an organism for which
the gene had been annotated as associated with sporulation/germination.
(That being the case for _gerC_, which was not present in _Bacillus_,
but _Paenibacillus illinoisensis_ has this gene annotated as
'Spore germination protein'.)

For each gene found this way, the UniProt ID was saved in the column `uniprot_id`,
and the respective coding sequence accession ID was saved in `accession`.
These may be used to download the protein and gene sequences from UniProt
or GenBank using a script.
