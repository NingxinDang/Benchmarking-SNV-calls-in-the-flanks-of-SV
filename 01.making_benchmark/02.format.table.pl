#!/use/bin/perl -w
use strict;

my $header=shift;
my $headerALL=shift;
my $info=shift;
my $path=shift;
my $sample=shift;

open(OUT, "> $path/$sample.xls");
open(AT, "> $path/$sample.Tier1_Tier2.xls");
open(IN,"< $header");
while(<IN>){
	chomp;
	print OUT "$_\n" ;
}
open(INT,"< $headerALL");
while(<INT>){
        chomp;
        print AT "$_\n" ;
}
open(BED, "< $info");
while(<BED>){
	chomp;
	my @line=split(/\t/,$_);
	my $left=$line[20]+$line[24];
	my $right=$line[31]+$line[35];
	my $f1=join("\t",@line[0 .. 13],$left,$right);
	print OUT "$f1\n";
	my $g=join("\t",@line[0 .. 13],$line[20],"Tier1",$line[24],"Tier2",$line[31],"Tier1",$line[35],"Tier2");
	print AT "$g\n";
}	
close BED;
close OUT;
close AT;

