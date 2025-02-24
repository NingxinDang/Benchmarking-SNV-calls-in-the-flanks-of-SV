#!/usr/bin/perl -w
use strict;
my $path=shift;
my $flag=shift;
open(IN,"< /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/06.hap.py/02.vcf.list");
while(<IN>){
	chomp;
	print "less $path/$flag/$_.summary.csv|grep 'SNP,PASS'|tr ',' \'\\t\' >>  $path/$flag.happy.summary.txt\n";
	
}
close IN;
print "paste /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/06.hap.py/02.happy.sample.info.list $path/$flag.happy.summary.txt|awk \'{print \$0\"\\t\"\"$flag\"}\'   > $path/$flag.happy.summary.add.sample.txt\n";
print "cat /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/06.hap.py/02.happy.header.list $path/$flag.happy.summary.add.sample.txt > $path/$flag.happy.summary.add.header.xls\n";
print "rm $path/$flag.happy.summary.txt $path/$flag.happy.summary.add.sample.txt\n";

