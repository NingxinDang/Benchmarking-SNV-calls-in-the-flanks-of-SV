#!/usr/bin/perl -w
use strict;
my $vcf=shift;
my $list=shift;
my %hash=();
open(INT,"< $list");
while(<INT>){
	chomp;
	$hash{$_}=1;
}
close INT;
open(IN, "gzip -dc $vcf|");
while(<IN>){
	chomp;
	my @line=split(/\t/,$_);
	if(/^#/){
		print"$_\n";
	}else{
		my $id=join("_",$line[0],$line[1]);
		if(exists $hash{$id} ){
			next;
		}elsif($line[9]=~/\.\|1/ || $line[9]=~/\.\/1/ || $line[9]=~/1\|\./ || $line[9]=~/1\/\./){
			next;
		}else{
			print"$_\n";
		}
	}
}
close IN;
		
