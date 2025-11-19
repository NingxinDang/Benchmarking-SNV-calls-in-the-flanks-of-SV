#!/usr/bin/perl -w
use strict;

my $read1=shift;
my $read2=shift;
my $sample=shift;
my $path=shift;
my $core=shift;

#bwa
open(BWA,"> $path/$sample/01.$sample.bwa.pbs");
print BWA "#!/bin/sh\n";
print BWA "#PBS -l nodes=1:ppn=$core\n";
print BWA "#PBS -l walltime=7200:00:00\n";
print BWA "eval \"\$(conda shell.bash hook)\"\n";
print BWA "conda activate benchmark\n";
print BWA "mkdir -p $path/$sample/bwa\n";
print BWA "outdir=$path/$sample/bwa\n";
print BWA "bwa mem -t $core /data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa $read1 $read2 |samtools view -S -b - > \$outdir/$sample.bam\n";
print BWA "time samtools sort -@ $core -m 4G -O bam -o \$outdir/$sample.sorted.bam \$outdir/$sample.bam\n";

#bowtie2
open(BOWTIE2,"> $path/$sample/01.$sample.bowtie2.pbs");
print BOWTIE2 "#!/bin/sh\n";
print BOWTIE2 "#PBS -l nodes=1:ppn=$core\n";
print BOWTIE2 "#PBS -l walltime=7200:00:00\n";
print BOWTIE2 "eval \"\$(conda shell.bash hook)\"\n";
print BOWTIE2 "conda activate bowtie2\n";
print BOWTIE2 "mkdir -p $path/$sample/bowtie2\n";
print BOWTIE2 "outdir=$path/$sample/bowtie2\n";
print BOWTIE2 "bowtie2 -p $core -x /data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla -1 $read1 -2 $read2 |samtools view -S -b - > \$outdir/$sample.bam\n";
print BOWTIE2 "time samtools sort -@ $core -m 4G -O bam -o \$outdir/$sample.sorted.bam \$outdir/$sample.bam\n";


#minimap2
open(MINIMAP2,"> $path/$sample/01.$sample.minimap2.pbs");
print MINIMAP2 "#!/bin/sh\n";
print MINIMAP2 "#PBS -l nodes=1:ppn=$core\n";
print MINIMAP2 "#PBS -l walltime=7200:00:00\n";
print MINIMAP2 "eval \"\$(conda shell.bash hook)\"\n";
print MINIMAP2 "conda activate minimap2\n";
print MINIMAP2 "mkdir -p $path/$sample/minimap2\n";
print MINIMAP2 "outdir=$path/$sample/minimap2\n";
print MINIMAP2 "minimap2 -ax sr /data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa $read1 $read2 -t $core |samtools view -S -b - > \$outdir/$sample.bam\n";
print MINIMAP2 "time samtools sort -@ $core -m 4G -O bam -o \$outdir/$sample.sorted.bam \$outdir/$sample.bam\n";

#nextgenmap
open(NEXTGENMAP, "> $path/$sample/01.$sample.nextgenmap.pbs");
print NEXTGENMAP "#!/bin/sh\n";
print NEXTGENMAP "#PBS -l nodes=1:ppn=$core\n";
print NEXTGENMAP "#PBS -l walltime=7200:00:00\n";
print NEXTGENMAP "eval \"\$(conda shell.bash hook)\"\n";
print NEXTGENMAP "conda activate benchmark\n";
print NEXTGENMAP "mkdir -p $path/$sample/nextgenmap\n";
print NEXTGENMAP "outdir=$path/$sample/nextgenmap\n";
print NEXTGENMAP "ngm -r /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/04.alignment/00.ref/nextgenmap/GRCh38_full_analysis_set_plus_decoy_hla.fa -1 $read1 -2 $read2  -t $core|samtools view -S -b - > \$outdir/$sample.bam\n";
print NEXTGENMAP "time samtools sort -@ $core -m 4G -O bam -o \$outdir/$sample.sorted.bam \$outdir/$sample.bam\n";

#subread
open(SUBREAD, "> $path/$sample/01.$sample.subread.pbs");
print SUBREAD "#!/bin/sh\n";
print SUBREAD "#PBS -l nodes=fat1:ppn=$core\n";
print SUBREAD "#PBS -l walltime=7200:00:00\n";
print SUBREAD "eval \"\$(conda shell.bash hook)\"\n";
print SUBREAD "conda activate benchmark\n";
print SUBREAD "mkdir -p $path/$sample/subread\n";
print SUBREAD "outdir=$path/$sample/subread\n";
print SUBREAD "subread-align -t 1 -T $core -i /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/04.alignment/00.ref/subread/GRCh38_full_analysis_set_plus_decoy_hla -r $read1 -R $read2 -o \$outdir/$sample.bam\n";
print SUBREAD "time samtools sort -@ $core -m 4G -O bam -o \$outdir/$sample.sorted.bam \$outdir/$sample.bam\n";


