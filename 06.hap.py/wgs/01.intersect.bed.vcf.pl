#!/usr/bin/perl -w
use strict;

my $bed=shift;
my $outdir=shift;

print "#!/bin/sh\n";
print "#PBS -l nodes=1:ppn=2\n";
print "#PBS -l walltime=7200:00:00\n";
print "#PBS -q batch\n";
print "eval \"\$(conda shell.bash hook)\"\n";
print "conda activate benchmark\n";
open(IN, "< /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/06.hap.py/01.intersect_snv_path_name_list");
while(<IN>){
	chomp;
	my@line=split(/\t/,$_);
	print "bedtools intersect -a $line[0] -b $bed -header > $outdir/$line[1]\n";
}
close IN;
