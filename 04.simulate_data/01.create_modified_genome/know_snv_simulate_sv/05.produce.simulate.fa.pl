#!/use/bin/perl -w
use strict;

my$bed=shift;
my$fasta=shift;

my %hash=();
open(IN, "< $bed");
while(<IN>){
	chomp;
	my @line=split(/\t/, $_);
	if($line[3]=~/SNP/){
		$hash{$line[1]}=$line[4];
	}elsif($line[3]=~/deletion/){
		foreach my $i ($line[1] .. $line[2]){
			$hash{$i}="P";
		}
	}elsif($line[3]=~/insertion/){
		$hash{$line[1]}=$line[4];
	}
}
close IN;
open(INT, "< $fasta");
my $chr=();
while(<INT>){
	chomp;
	if(/^>/){
		$chr=(split(/>/,$_))[1];
	}else{
		my@line=split(//, $_);
		foreach my $i (0 .. $#line) {
		    my $li=$i + 1 + ($. - 2)*60;
		    if(exists $hash{$li}){
			 print "$chr\t$li\t$line[$i]\t$hash{$li}\n";
		    }else{
			print "$chr\t$li\t$line[$i]\t$line[$i]\n";
			}	
		}
	}
}
close INT;
		
