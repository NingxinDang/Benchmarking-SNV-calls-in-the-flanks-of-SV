#!/usr/bin/perl -w
use strict;

my $input=shift;
my $path=shift;
open(IN, "gzip -dc $input|");
open(BED, "> $path/01.know.SNV.bed");
open(VCF, "> $path/01.know.SNV.vcf");

while(<IN>){
	chomp;
	if(/^#/){
		print VCF "$_\n";
	}else{
		my @line=split(/\t/,$_);
		my $leftpoint=$line[1]-1;
		my $rightpoint=$line[1];
		my $alt=(split(/,/ , $line[4]))[0];
		print VCF "$line[0]\t$line[1]\t$line[2]\t$line[3]\t$alt\t$line[5]\t$line[6]\tPASS\t$line[8]\t$line[9]\n";
		print BED "$line[0]\t$leftpoint\t$rightpoint\tSNP\t$alt\t0\n";
	}
}
close IN;

		
		
