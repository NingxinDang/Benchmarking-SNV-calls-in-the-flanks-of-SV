#!/usr/bin/perl -w
use strict;

my $file=shift;
print  "#!/bin/sh\n";
print  "#PBS -l nodes=1:ppn=1\n";
print   "#PBS -l walltime=7200:00:00\n";
print   "eval \"\$(conda shell.bash hook)\"\n";
print   "conda activate benchmark\n";
print "$file\n";

