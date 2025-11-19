#!/usr/bin/perl -w
use strict;

my $file=shift;
my $pwd=shift;
my $name=shift;
my $flag=shift;
my $snv1=shift;
my $snv2=shift;
open (IN, "gzip -dc $file|");
open (OUT, "> $pwd/00.$name.$flag.del.region.bed");
open(L1, "> $pwd/$name.$flag.left.0.100.del.bed");
open(R1, "> $pwd/$name.$flag.right.0.100.del.bed");
open(L2, "> $pwd/$name.$flag.left.0.200.del.bed");
open(R2, "> $pwd/$name.$flag.right.0.200.del.bed");
open(L3, "> $pwd/$name.$flag.left.0.300.del.bed");
open(R3, "> $pwd/$name.$flag.right.0.300.del.bed");
open(L4, "> $pwd/$name.$flag.left.0.400.del.bed");
open(R4, "> $pwd/$name.$flag.right.0.400.del.bed");
open(L5, "> $pwd/$name.$flag.left.0.500.del.bed");
open(R5, "> $pwd/$name.$flag.right.0.500.del.bed");
open(L6, "> $pwd/$name.$flag.left.0.600.del.bed");
open(R6, "> $pwd/$name.$flag.right.0.600.del.bed");
open(L7, "> $pwd/$name.$flag.left.0.700.del.bed");
open(R7, "> $pwd/$name.$flag.right.0.700.del.bed");
open(L8, "> $pwd/$name.$flag.left.0.800.del.bed");
open(R8, "> $pwd/$name.$flag.right.0.800.del.bed");
open(L9, "> $pwd/$name.$flag.left.0.900.del.bed");
open(R9, "> $pwd/$name.$flag.right.0.900.del.bed");
open(L10, "> $pwd/$name.$flag.left.0.1000.del.bed");
open(R10, "> $pwd/$name.$flag.right.0.1000.del.bed");
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
		my $len=();
		my $length=();
		my $rm=();
		my $sd=();
		my $sr=();
		my $str=();
		my $vntr=();
		my $exon=();
		my $cds=();
		$len=length($line[3]);
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
		my $right_breakpoint=$line[1]+$length+1;
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

open(WORK, "> $pwd/01.$name.deletion.$flag.snv.sh");
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.100.del.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.100.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.200.del.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.200.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.300.del.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.300.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.400.del.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.400.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.500.del.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.500.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.600.del.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.600.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.700.del.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.700.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.800.del.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.800.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.900.del.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.900.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.1000.del.bed -b $snv1 -counts > $pwd/$name.$flag.left.0.1000.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.100.del.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.100.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.200.del.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.200.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.300.del.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.300.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.400.del.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.400.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.500.del.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.500.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.600.del.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.600.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.700.del.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.700.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.800.del.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.800.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.900.del.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.900.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.1000.del.bed -b $snv1 -counts > $pwd/$name.$flag.right.0.1000.del.tier1.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.100.del.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.100.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.200.del.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.200.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.300.del.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.300.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.400.del.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.400.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.500.del.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.500.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.600.del.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.600.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.700.del.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.700.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.800.del.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.800.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.900.del.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.900.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.left.0.1000.del.bed -b $snv2 -counts > $pwd/$name.$flag.left.0.1000.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.100.del.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.100.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.200.del.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.200.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.300.del.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.300.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.400.del.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.400.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.500.del.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.500.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.600.del.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.600.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.700.del.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.700.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.800.del.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.800.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.900.del.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.900.del.tier2.snv.count.txt\n";
print WORK "bedtools coverage -a $pwd/$name.$flag.right.0.1000.del.bed -b $snv2 -counts > $pwd/$name.$flag.right.0.1000.del.tier2.snv.count.txt\n";
close WORK;
open(WORK1, "> $pwd/02.$name.deletion.$flag.merge.snv.sh");
print WORK1 "paste $pwd/00.$name.$flag.del.region.bed $pwd/$name.$flag.left.0.100.del.bed  $pwd/$name.$flag.left.0.100.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.100.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.100.del.bed $pwd/$name.$flag.right.0.100.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.100.del.tier2.snv.count.txt > $pwd/$name.$flag.0.100.del.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.100.del.bed $pwd/$name.$flag.left.0.100.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.100.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.100.del.bed $pwd/$name.$flag.right.0.100.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.100.del.tier2.snv.count.txt\n";
print WORK1 "paste $pwd/00.$name.$flag.del.region.bed $pwd/$name.$flag.left.0.200.del.bed $pwd/$name.$flag.left.0.200.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.200.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.200.del.bed $pwd/$name.$flag.right.0.200.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.200.del.tier2.snv.count.txt > $pwd/$name.$flag.0.200.del.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.200.del.bed $pwd/$name.$flag.left.0.200.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.200.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.200.del.bed $pwd/$name.$flag.right.0.200.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.200.del.tier2.snv.count.txt\n";
print WORK1 "paste $pwd/00.$name.$flag.del.region.bed $pwd/$name.$flag.left.0.300.del.bed $pwd/$name.$flag.left.0.300.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.300.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.300.del.bed $pwd/$name.$flag.right.0.300.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.300.del.tier2.snv.count.txt > $pwd/$name.$flag.0.300.del.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.300.del.bed $pwd/$name.$flag.left.0.300.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.300.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.300.del.bed $pwd/$name.$flag.right.0.300.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.300.del.tier2.snv.count.txt\n";
print WORK1 "paste $pwd/00.$name.$flag.del.region.bed $pwd/$name.$flag.left.0.400.del.bed $pwd/$name.$flag.left.0.400.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.400.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.400.del.bed $pwd/$name.$flag.right.0.400.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.400.del.tier2.snv.count.txt > $pwd/$name.$flag.0.400.del.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.400.del.bed $pwd/$name.$flag.left.0.400.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.400.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.400.del.bed $pwd/$name.$flag.right.0.400.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.400.del.tier2.snv.count.txt\n";
print WORK1 "paste $pwd/00.$name.$flag.del.region.bed $pwd/$name.$flag.left.0.500.del.bed $pwd/$name.$flag.left.0.500.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.500.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.500.del.bed $pwd/$name.$flag.right.0.500.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.500.del.tier2.snv.count.txt > $pwd/$name.$flag.0.500.del.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.500.del.bed $pwd/$name.$flag.left.0.500.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.500.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.500.del.bed $pwd/$name.$flag.right.0.500.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.500.del.tier2.snv.count.txt\n";
print WORK1 "paste $pwd/00.$name.$flag.del.region.bed $pwd/$name.$flag.left.0.600.del.bed $pwd/$name.$flag.left.0.600.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.600.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.600.del.bed $pwd/$name.$flag.right.0.600.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.600.del.tier2.snv.count.txt > $pwd/$name.$flag.0.600.del.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.600.del.bed $pwd/$name.$flag.left.0.600.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.600.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.600.del.bed $pwd/$name.$flag.right.0.600.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.600.del.tier2.snv.count.txt\n";
print WORK1 "paste $pwd/00.$name.$flag.del.region.bed $pwd/$name.$flag.left.0.700.del.bed $pwd/$name.$flag.left.0.700.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.700.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.700.del.bed $pwd/$name.$flag.right.0.700.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.700.del.tier2.snv.count.txt > $pwd/$name.$flag.0.700.del.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.700.del.bed $pwd/$name.$flag.left.0.700.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.700.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.700.del.bed $pwd/$name.$flag.right.0.700.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.700.del.tier2.snv.count.txt\n";
print WORK1 "paste $pwd/00.$name.$flag.del.region.bed $pwd/$name.$flag.left.0.800.del.bed $pwd/$name.$flag.left.0.800.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.800.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.800.del.bed $pwd/$name.$flag.right.0.800.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.800.del.tier2.snv.count.txt > $pwd/$name.$flag.0.800.del.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.800.del.bed $pwd/$name.$flag.left.0.800.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.800.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.800.del.bed $pwd/$name.$flag.right.0.800.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.800.del.tier2.snv.count.txt\n";
print WORK1 "paste $pwd/00.$name.$flag.del.region.bed $pwd/$name.$flag.left.0.900.del.bed $pwd/$name.$flag.left.0.900.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.900.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.900.del.bed $pwd/$name.$flag.right.0.900.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.900.del.tier2.snv.count.txt > $pwd/$name.$flag.0.900.del.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.900.del.bed $pwd/$name.$flag.left.0.900.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.900.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.900.del.bed $pwd/$name.$flag.right.0.900.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.900.del.tier2.snv.count.txt\n";
print WORK1 "paste $pwd/00.$name.$flag.del.region.bed $pwd/$name.$flag.left.0.1000.del.bed $pwd/$name.$flag.left.0.1000.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.1000.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.1000.del.bed $pwd/$name.$flag.right.0.1000.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.1000.del.tier2.snv.count.txt > $pwd/$name.$flag.0.1000.del.snv.count.txt\n";
print WORK1 "rm $pwd/$name.$flag.left.0.1000.del.bed $pwd/$name.$flag.left.0.1000.del.tier1.snv.count.txt $pwd/$name.$flag.left.0.1000.del.tier2.snv.count.txt $pwd/$name.$flag.right.0.1000.del.bed $pwd/$name.$flag.right.0.1000.del.tier1.snv.count.txt $pwd/$name.$flag.right.0.1000.del.tier2.snv.count.txt\n";
close WORK1;
open(WORK2, "> $pwd/03.$name.deletion.$flag.make.table.sh");
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.100.del.snv.count.txt $pwd $name.$flag.0.100.del.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.100.del.snv.count.txt\n";
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.200.del.snv.count.txt $pwd $name.$flag.0.200.del.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.200.del.snv.count.txt\n";
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.300.del.snv.count.txt $pwd $name.$flag.0.300.del.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.300.del.snv.count.txt\n";
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.400.del.snv.count.txt $pwd $name.$flag.0.400.del.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.400.del.snv.count.txt\n";
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.500.del.snv.count.txt $pwd $name.$flag.0.500.del.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.500.del.snv.count.txt\n";
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.600.del.snv.count.txt $pwd $name.$flag.0.600.del.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.600.del.snv.count.txt\n";
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.700.del.snv.count.txt $pwd $name.$flag.0.700.del.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.700.del.snv.count.txt\n";
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.800.del.snv.count.txt $pwd $name.$flag.0.800.del.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.800.del.snv.count.txt\n";
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.900.del.snv.count.txt $pwd $name.$flag.0.900.del.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.900.del.snv.count.txt\n";
print WORK2 "perl /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/01.SV_SNV_COUNTS/01.make.table.pl $pwd/00.$name.header $pwd/00.$name.all.header $pwd/$name.$flag.0.1000.del.snv.count.txt $pwd $name.$flag.0.1000.del.snv\n";
print WORK2 "rm $pwd/$name.$flag.0.1000.del.snv.count.txt\n";
close WORK2;
