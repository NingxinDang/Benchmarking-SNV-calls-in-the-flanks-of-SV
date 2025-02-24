#!/usr/bin/perl -w
use strict;
my $bed=shift;
my $truth_vcf=shift;
my $query_vcf=shift;
my $flag=shift;
my $threads=shift;
my $output=shift;
my $ref="/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa";

print"#!/bin/sh\n";
print"##PBS -l nodes=1:ppn=2\n";
print"##PBS -l walltime=7200:00:00\n";
print"eval \"\$(conda shell.bash hook)\"\n";
print"conda activate truvari\n";
print"export HGREF=/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";

open(IN,"< /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/06.hifi.hap.py/vcf.path.list");
while(<IN>){
	chomp;
	my @line=split(/\t/,$_);
	print"~/software/miniconda3/envs/truvari/bin/hap.py $truth_vcf $query_vcf/$flag/$line[1] -f $bed -r $ref --threads $threads -o $output/$flag/$line[1] \n";
}
close IN;
