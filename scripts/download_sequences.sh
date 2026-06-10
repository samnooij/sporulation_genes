#!/usr/bin/env bash
set -euo pipefail

# Download sequences as FASTA files - reading gene and protein IDs
# from a tab-separated table file.

genes_table="${1:-sporulation_genes.tsv}"

# Read the table and convert relevant columns to bash arrays
accessions=( $( grep -v "gene" ${genes_table} | cut -f 3) )
uniprot_ids=( $(grep -v "gene" ${genes_table} | cut -f 4) )

echo "[$(date +"%Y-%m-%d %H:%M:%S")] - Found ${#accessions[@]} accession IDs and ${#uniprot_ids[@]} UniProt IDs"

mkdir -p sequences/protein
echo "[$(date +"%Y-%m-%d %H:%M:%S")] - Downloading protein sequences"
# UniProt (protein) sequences may be retrieved from:
# https://rest.uniprot.org/uniprotkb/${uniprot_id}.fasta
# for example: https://rest.uniprot.org/uniprotkb/P06534.fasta

for uniprot_id in ${uniprot_ids[@]}
do
    if [ ! -s sequences/protein/${uniprot_id}.fasta ]
    # If the file does not exist or have size 0
    then
        curl -O --output-dir sequences/protein\
        https://rest.uniprot.org/uniprotkb/${uniprot_id}.fasta
        # Wait a second between downloads to give the server time to breathe
        sleep 1
    else
        echo "Skipping ${uniprot_id}: downloaded before!"
    fi
done

mkdir -p sequences/gene
echo "[$(date +"%Y-%m-%d %H:%M:%S")] - Downloading gene sequences"
# ENA/GenBank (nucleotide/gene) sequences may be retrieved from:
# https://www.ebi.ac.uk/ena/browser/api/fasta/${accession}
# for example: https://www.ebi.ac.uk/ena/browser/api/fasta/AAA22786.1

for accession in ${accessions[@]}
do
    if [ ! -s sequences/gene/${accession}.fasta ]
    then
        curl -o sequences/gene/${accession}.fasta\
        https://www.ebi.ac.uk/ena/browser/api/fasta/${accession}
        # Wait a second between downloads to give the server time to breathe
        sleep 1
    else
        echo "Skipping ${accession}: downloaded before!"
    fi
done

echo "[$(date +"%Y-%m-%d %H:%M:%S")] - Done!"
ls -lh sequences/*
