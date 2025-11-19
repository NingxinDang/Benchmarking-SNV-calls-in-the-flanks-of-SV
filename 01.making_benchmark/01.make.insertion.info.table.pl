#!/usr/bin/perl -w
use strict;

my $file=shift;
my $pwd=shift;
my $name=shift;
my $flag=shift;
my $snv1=shift;
my $snv2=shift;
open (IN, "gzip -dc $file|");
open (OUT, "> $pwd/00.$name.$flag.ins.region.bed");
open(L1, "> $pwd/$name.$flag.left.0.100.ins.bed");
open(R1, "> $pwd/$name.$flag.right.0.100.ins.bed");
open(L2, "> $pwd/$name.$flag.left.0.200.ins.bed");
open(R2, "> $pwd/$name.$flag.right.0.200.ins.bed");
open(L3, "> $pwd/$name.$flag.left.0.300.ins.bed");
open(R3, "> $pwd/$name.$flag.right.0.300.ins.bed");
open(L4, "> $pwd/$name.$flag.left.0.400.ins.bed");
open(R4, "> $pwd/$name.$flag.right.0.400.ins.bed");
open(L5, "> $pwd/$name.$flag.left.0.500.ins.bed");
open(R5, "> $pwd/$name.$flag.right.0.500.ins.bed");
open(L6, "> $pwd/$name.$flag.left.0.600.ins.bed");
open(R6, "> $pwd/$name.$flag.right.0.600.ins.bed");
open(L7, "> $pwd/$name.$flag.left.0.700.ins.bed");
open(R7, "> $pwd/$name.$flag.right.0.700.ins.bed");
open(L8, "> $pwd/$name.$flag.left.0.800.ins.bed");
open(R8, "> $pwd/$name.$flag.right.0.800.ins.bed");
open(L9, "> $pwd/$name.$flag.left.0.900.ins.bed");
open(R9, "> $pwd/$name.$flag.right.0.900.ins.bed");
open(L10, "> $pwd/$name.$flag.left.0.1000.ins.bed");
open(R10, "> $pwd/$name.$flag.right.0.1000.ins.bed");
open(HEADER, ">  $pwd/00.$name.all.header");
open(HEADERT, ">  $pwd/00.$name.header");
print HEADER "#chrom\tpos\tgenotype\tdata\tsv_len\tsv_length\tsupport_technology\trepeat_mask\tSD\tsimple_repeats\tSTR\tVNTR\tEXON\tCDs\tLeft_SNV1\tFlag1\tLeft_SNV2\tFlag2\tRight_SNV1\tFlag3\tRight_SNV2\tFlag4\n";
print HEADERT "#chrom\tpos\tgenotype\tdata\tsv_len\tsv_length\tsupport_technology\trepeat_mask\tSD\tsimple_repeats\tSTR\tVNTR\tEXON\tCDs\tLeft_SNV\tRight_SNV\n";
while(<IN>){
	chomp;
	if(/#/){
		next;
	}else{
		my @line=split(/\t/,$_);
		my @info=split(/;/,$line[7]);
		my $sup_set=();
		my $length=();
		my $len=();
		my $rm=();
		my $sd=();
		my $sr=();
		my $str=();
		my $vntr=();
		my $exon=();
		my $cds=();
		$len=length($line[4]);
		foreach my $i(@info){
			if($i=~/^SVLEN=/){
				$length=(split(/=/,$i))[1];
				$length=abs($length);
			}elsif($i=~/^R_RM=/){
				$rm=(split(/=/,$i))[1];
			}elsif($i=~/^R_SD=/){
				$sd=(split(/=/,$i))[1];
			}elsif($i=~/^R_SR=/){
				$sr=(split(/=/,$i))[1];
			}elsif($i=~/^R_STR=/){
				$str=(split(/=/,$i))[1];
			}elsif($i=~/^R_VNTR=/){
				$vntr=(split(/=/,$i))[1];
			}elsif($i=~/^R_Exon=/){
				$exon=(split(/=/,$i))[1];
			}elsif($i=~/^R_CDS=/){
				$cds=(split(/=/,$i))[1];
			}elsif($i=~/^SUPP_Set/){
				$sup_set=(split(/=/,$i))[1];
			}
		}
		my $right_breakpoint=$line[1]+1;
                my $left_breakpoint=$line[1];
                my $left_100=$left_breakpoint-100;
                my $left_200=$left_breakpoint-200;
		my $left_300=$left_breakpoint-300;
		my $left_400=$left_breakpoint-400;
		my $left_500=$left_breakpoint-500;
		my $left_600=$left_breakpoint-600;
		my $left_700=$left_breakpoint-700;
		my $left_800=$left_breakpoint-800;
		my $left_900=$left_breakpoint-900;
		my $left_1000=$left_breakpoint-1000;
                my $right_100=$right_breakpoint+100;
                my $right_200=$right_breakpoint+200;
		my $right_300=$right_breakpoint+300;
		my $right_400=$right_breakpoint+400;
		my $right_500=$right_breakpoint+500;
		my $right_600=$right_breakpoint+600;
		my $right_700=$right_breakpoint+700;
		my $right_800=$right_breakpoint+800;
		my $right_900=$right_breakpoint+900;
		my $right_1000=$right_breakpoint+1000;
		if($line[9]=~/1\|1/ || $line[9]=~/1\/1/ ){
			print OUT  "$line[0]\t$line[1]\thomozygous\t$flag\t$len\t$length\t$sup_set\t$rm\t$sd\t$sr\t$str\t$vntr\t$exon\t$cds\n";
			print L1  "$line[0]\t$left_100\t$left_breakpoint\n";
			print R1  "$line[0]\t$right_breakpoint\t$right_100\n";
			print L2  "$line[0]\t$left_200\t$left_breakpoint\n";
			print R2  "$line[0]\t$right_breakpoint\t$right_200\n";
			print L3  "$line[0]\t$left_300\t$left_breakpoint\n";
                        print R3  "$line[0]\t$right_breakpoint\t$right_300\n";
			print L4  "$line[0]\t$left_400\t$left_breakpoint\n";
                        print R4  "$line[0]\t$right_breakpoint\t$right_400\n";
			print L5  "$line[0]\t$left_500\t$left_breakpoint\n";
                        print R5  "$line[0]\t$right_breakpoint\t$right_500\n";
			print L6  "$line[0]\t$left_600\t$left_breakpoint\n";
                        print R6  "$line[0]\t$right_breakpoint\t$right_600\n";
			print L7  "$line[0]\t$left_700\t$left_breakpoint\n";
                        print R7  "$line[0]\t$right_breakpoint\t$right_700\n";
			print L8  "$line[0]\t$left_800\t$left_breakpoint\n";
                        print R8  "$line[0]\t$right_breakpoint\t$right_800\n";
			print L9  "$line[0]\t$left_900\t$left_breakpoint\n";
                        print R9  "$line[0]\t$right_breakpoint\t$right_900\n";
			print L10  "$line[0]\t$left_1000\t$left_breakpoint\n";
                        print R10  "$line[0]\t$right_breakpoint\t$right_1000\n";
		}elsif($line[9]=~/0\/1/ || $line[9]=~/0\|1/ || $line[9]=~/1\|0/ || $line[9]=~/1\/0/){
			print OUT  "$line[0]\t$line[1]\theterozygous\t$flag\t$len\t$length\t$sup_set\t$rm\t$sd\t$sr\t$str\t$vntr\t$exon\t$cds\n";
			print L1  "$line[0]\t$left_100\t$left_breakpoint\n";
                        print R1  "$line[0]\t$right_breakpoint\t$right_100\n";
                        print L2  "$line[0]\t$left_200\t$left_breakpoint\n";
                        print R2  "$line[0]\t$right_breakpoint\t$right_200\n";
                        print L3  "$line[0]\t$left_300\t$left_breakpoint\n";
                        print R3  "$line[0]\t$right_breakpoint\t$right_300\n";
                        print L4  "$line[0]\t$left_400\t$left_breakpoint\n";
                        print R4  "$line[0]\t$right_breakpoint\t$right_400\n";
                        print L5  "$line[0]\t$left_500\t$left_breakpoint\n";
                        print R5  "$line[0]\t$right_breakpoint\t$right_500\n";
                        print L6  "$line[0]\t$left_600\t$left_breakpoint\n";
                        print R6  "$line[0]\t$right_breakpoint\t$right_600\n";
                        print L7  "$line[0]\t$left_700\t$left_breakpoint\n";
                        print R7  "$line[0]\t$right_breakpoint\t$right_700\n";
                        print L8  "$line[0]\t$left_800\t$left_breakpoint\n";
                        print R8  "$line[0]\t$right_breakpoint\t$right_800\n";
                        print L9  "$line[0]\t$left_900\t$left_breakpoint\n";
                        print R9  "$line[0]\t$right_breakpoint\t$right_900\n";
                        print L10  "$line[0]\t$left_1000\t$left_breakpoint\n";
                        print R10  "$line[0]\t$right_breakpoint\t$right_1000\n";
				
		}
	}
}
close IN;
close OUT;
close L1;

open(WORK, "> $pwd/01.$name.insetion.$flag.snv.sh");
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.100.ins.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.100.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.200.ins.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.200.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.300.ins.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.300.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.400.ins.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.400.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.500.ins.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.500.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.600.ins.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.600.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.700.ins.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.700.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.800.ins.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.800.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.900.ins.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.900.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.1000.ins.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.1000.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.100.ins.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.100.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.200.ins.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.200.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.300.ins.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.300.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.400.ins.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.400.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.500.ins.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.500.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.600.ins.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.600.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.700.ins.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.700.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.800.ins.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.800.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.900.ins.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.900.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.1000.ins.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.1000.ins.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.100.ins.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.100.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.200.ins.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.200.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.300.ins.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.300.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.400.ins.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.400.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.500.ins.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.500.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.600.ins.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.600.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.700.ins.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.700.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.800.ins.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.800.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.900.ins.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.900.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.1000.ins.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.1000.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.100.ins.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.100.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.200.ins.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.200.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.300.ins.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.300.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.400.ins.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.400.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.500.ins.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.500.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.600.ins.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.600.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.700.ins.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.700.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.800.ins.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.800.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.900.ins.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.900.ins.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.1000.ins.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.1000.ins.tier2.snv.count.txt\n";
close WORK;
open(WORK1, "> $pwd/02.$name.insetion.$flag.merge.snv.sh");
print WORK1 "paste $pwd/00.$name.$flag.ins.region.bed $pwd/$name.$flag.left.0.100.ins.bed $pwd/$name.$flag.left.0.100.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.100.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.100.ins.bed $pwd/$name.$flag.right.0.100.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.100.ins.tier2.snv.count.txt > $pwd/$name.$flag.0.100.ins.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.100.ins.bed $pwd/$name.$flag.left.0.100.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.100.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.100.ins.bed $pwd/$name.$flag.right.0.100.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.100.ins.tier2.snv.count.txt\n";
print WORK1 "paste $pwd/00.$name.$flag.ins.region.bed $pwd/$name.$flag.left.0.200.ins.bed $pwd/$name.$flag.left.0.200.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.200.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.200.ins.bed $pwd/$name.$flag.right.0.200.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.200.ins.tier2.snv.count.txt > $pwd/$name.$flag.0.200.ins.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.200.ins.bed $pwd/$name.$flag.left.0.200.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.200.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.200.ins.bed $pwd/$name.$flag.right.0.200.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.200.ins.tier2.snv.count.txt\n";
print WORK1 "paste $pwd/00.$name.$flag.ins.region.bed $pwd/$name.$flag.left.0.300.ins.bed $pwd/$name.$flag.left.0.300.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.300.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.300.ins.bed $pwd/$name.$flag.right.0.300.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.300.ins.tier2.snv.count.txt > $pwd/$name.$flag.0.300.ins.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.300.ins.bed $pwd/$name.$flag.left.0.300.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.300.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.300.ins.bed $pwd/$name.$flag.right.0.300.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.300.ins.tier2.snv.count.txt\n";
print WORK1 "paste $pwd/00.$name.$flag.ins.region.bed $pwd/$name.$flag.left.0.400.ins.bed $pwd/$name.$flag.left.0.400.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.400.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.400.ins.bed $pwd/$name.$flag.right.0.400.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.400.ins.tier2.snv.count.txt > $pwd/$name.$flag.0.400.ins.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.400.ins.bed $pwd/$name.$flag.left.0.400.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.400.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.400.ins.bed $pwd/$name.$flag.right.0.400.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.400.ins.tier2.snv.count.txt\n";
print WORK1 "paste $pwd/00.$name.$flag.ins.region.bed $pwd/$name.$flag.left.0.500.ins.bed $pwd/$name.$flag.left.0.500.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.500.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.500.ins.bed $pwd/$name.$flag.right.0.500.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.500.ins.tier2.snv.count.txt > $pwd/$name.$flag.0.500.ins.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.500.ins.bed $pwd/$name.$flag.left.0.500.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.500.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.500.ins.bed $pwd/$name.$flag.right.0.500.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.500.ins.tier2.snv.count.txt\n";
print WORK1 "paste $pwd/00.$name.$flag.ins.region.bed $pwd/$name.$flag.left.0.600.ins.bed $pwd/$name.$flag.left.0.600.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.600.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.600.ins.bed $pwd/$name.$flag.right.0.600.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.600.ins.tier2.snv.count.txt > $pwd/$name.$flag.0.600.ins.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.600.ins.bed $pwd/$name.$flag.left.0.600.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.600.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.600.ins.bed $pwd/$name.$flag.right.0.600.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.600.ins.tier2.snv.count.txt\n";
print WORK1 "paste $pwd/00.$name.$flag.ins.region.bed $pwd/$name.$flag.left.0.700.ins.bed $pwd/$name.$flag.left.0.700.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.700.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.700.ins.bed $pwd/$name.$flag.right.0.700.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.700.ins.tier2.snv.count.txt > $pwd/$name.$flag.0.700.ins.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.700.ins.bed $pwd/$name.$flag.left.0.700.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.700.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.700.ins.bed $pwd/$name.$flag.right.0.700.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.700.ins.tier2.snv.count.txt\n";
print WORK1 "paste $pwd/00.$name.$flag.ins.region.bed $pwd/$name.$flag.left.0.800.ins.bed $pwd/$name.$flag.left.0.800.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.800.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.800.ins.bed $pwd/$name.$flag.right.0.800.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.800.ins.tier2.snv.count.txt > $pwd/$name.$flag.0.800.ins.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.800.ins.bed $pwd/$name.$flag.left.0.800.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.800.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.800.ins.bed $pwd/$name.$flag.right.0.800.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.800.ins.tier2.snv.count.txt\n";
print WORK1 "paste $pwd/00.$name.$flag.ins.region.bed $pwd/$name.$flag.left.0.900.ins.bed $pwd/$name.$flag.left.0.900.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.900.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.900.ins.bed $pwd/$name.$flag.right.0.900.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.900.ins.tier2.snv.count.txt > $pwd/$name.$flag.0.900.ins.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.900.ins.bed $pwd/$name.$flag.left.0.900.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.900.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.900.ins.bed $pwd/$name.$flag.right.0.900.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.900.ins.tier2.snv.count.txt\n";
print WORK1 "paste $pwd/00.$name.$flag.ins.region.bed $pwd/$name.$flag.left.0.1000.ins.bed $pwd/$name.$flag.left.0.1000.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.1000.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.1000.ins.bed $pwd/$name.$flag.right.0.1000.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.1000.ins.tier2.snv.count.txt > $pwd/$name.$flag.0.1000.ins.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.1000.ins.bed $pwd/$name.$flag.left.0.1000.ins.tier1.snv.count.txt $pwd/$name.$flag.left.0.1000.ins.tier2.snv.count.txt $pwd/$name.$flag.right.0.1000.ins.bed $pwd/$name.$flag.right.0.1000.ins.tier1.snv.count.txt $pwd/$name.$flag.right.0.1000.ins.tier2.snv.count.txt\n";
open(WORK2, "> $pwd/03.$name.insetion.$flag.make.table.sh");
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.100.ins.snv.count.txt $pwd $name.$flag.0.100.ins.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.100.ins.snv.count.txt\n";
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.200.ins.snv.count.txt $pwd $name.$flag.0.200.ins.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.200.ins.snv.count.txt\n";
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.300.ins.snv.count.txt $pwd $name.$flag.0.300.ins.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.300.ins.snv.count.txt\n";
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.400.ins.snv.count.txt $pwd $name.$flag.0.400.ins.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.400.ins.snv.count.txt\n";
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.500.ins.snv.count.txt $pwd $name.$flag.0.500.ins.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.500.ins.snv.count.txt\n";
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.600.ins.snv.count.txt $pwd $name.$flag.0.600.ins.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.600.ins.snv.count.txt\n";
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.700.ins.snv.count.txt $pwd $name.$flag.0.700.ins.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.700.ins.snv.count.txt\n";
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.800.ins.snv.count.txt $pwd $name.$flag.0.800.ins.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.800.ins.snv.count.txt\n";
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.900.ins.snv.count.txt $pwd $name.$flag.0.900.ins.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.900.ins.snv.count.txt\n";
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.1000.ins.snv.count.txt $pwd $name.$flag.0.1000.ins.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.1000.ins.snv.count.txt\n";
close WORK2;

