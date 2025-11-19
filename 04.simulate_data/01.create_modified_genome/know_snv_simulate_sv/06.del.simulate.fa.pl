#!/usr/bin/perl -w
use strict;

my $file=shift;
open(IN, "gzip -dc $file|");
my $sequence='';
my $chr=();
while(<IN>){
	chomp;
	my @fields = (split /\t/, $_);
	$chr= $fields[0];
	my $alt=$fields[3];
	next if $alt eq 'P';
	$sequence .= $alt;
}

print">$chr\n";
my $length = length($sequence);
for (my $i = 0; $i < $length; $i += 60) {
    my $line = substr($sequence, $i, 60);
    print  "$line\n";
}
	
