#!/usr/bin/perl -w
use strict;

my $read1=shift;
my $read2=shift;
my $sample=shift;
my $path=shift;
my $core=shift;
my $id=shift;
my $readgrouplibrary=shift;
my $platform=shift;
my $runbarcode=shift;
my $samplename=shift;

#bwa
open(BWA,"> $path/$sample/02.$sample.bwa.deal.bam.pbs");
print BWA "#!/bin/sh\n";
print BWA "#PBS -l nodes=1:ppn=$core\n";
print BWA "#PBS -l walltime=7200:00:00\n";
print BWA "eval \"\$(conda shell.bash hook)\"\n";
print BWA "conda activate benchmark\n";
print BWA "outdir=$path/$sample/bwa\n";
print BWA "mkdir -p \$outdir/tmp\n";
print BWA "tmp=\$outdir/tmp\n";
print BWA "java -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/picard-3.1.1/picard.jar AddOrReplaceReadGroups I=\$outdir/$sample.sorted.bam O=\$outdir/$sample.sorted.add_read_group.bam RGID=$id RGLB=$readgrouplibrary RGPL=$platform RGPU=$runbarcode RGSM=$samplename\n";
print BWA "java -Djava.io.tmpdir=\$tmp -Xmx20g -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/picard-3.1.1/picard.jar MarkDuplicates I=\$outdir/$sample.sorted.add_read_group.bam  O=\$outdir/$sample.sorted.add_read_group.markdup.bam M=\$outdir/$sample.markdup_metrics.txt \n";
print BWA "samtools index \$outdir/$sample.sorted.add_read_group.markdup.bam\n";

#bowtie2
open(BOWTIE2,"> $path/$sample/02.$sample.bowtie2.deal.bam.pbs");
print BOWTIE2 "#!/bin/sh\n";
print BOWTIE2 "#PBS -l nodes=1:ppn=$core\n";
print BOWTIE2 "#PBS -l walltime=7200:00:00\n";
print BOWTIE2 "eval \"\$(conda shell.bash hook)\"\n";
print BOWTIE2 "conda activate benchmark\n";
print BOWTIE2 "outdir=$path/$sample/bowtie2\n";
print BOWTIE2 "mkdir -p \$outdir/tmp\n";
print BOWTIE2 "tmp=\$outdir/tmp\n";
print BOWTIE2 "java -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/picard-3.1.1/picard.jar AddOrReplaceReadGroups I=\$outdir/$sample.sorted.bam O=\$outdir/$sample.sorted.add_read_group.bam RGID=$id RGLB=$readgrouplibrary RGPL=$platform RGPU=$runbarcode RGSM=$samplename\n";
print BOWTIE2 "java -Djava.io.tmpdir=\$tmp -Xmx20g -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/picard-3.1.1/picard.jar MarkDuplicates I=\$outdir/$sample.sorted.add_read_group.bam  O=\$outdir/$sample.sorted.add_read_group.markdup.bam M=\$outdir/$sample.markdup_metrics.txt \n";
print BOWTIE2 "samtools index \$outdir/$sample.sorted.add_read_group.markdup.bam\n";

#minimap2
open(MINIMAP2,"> $path/$sample/02.$sample.minimap2.deal.bam.pbs");
print MINIMAP2 "#!/bin/sh\n";
print MINIMAP2 "#PBS -l nodes=1:ppn=$core\n";
print MINIMAP2 "#PBS -l walltime=7200:00:00\n";
print MINIMAP2 "eval \"\$(conda shell.bash hook)\"\n";
print MINIMAP2 "conda activate benchmark\n";
print MINIMAP2 "outdir=$path/$sample/minimap2\n";
print MINIMAP2 "mkdir -p \$outdir/tmp\n";
print MINIMAP2 "tmp=\$outdir/tmp\n";
print MINIMAP2 "java -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/picard-3.1.1/picard.jar AddOrReplaceReadGroups I=\$outdir/$sample.sorted.bam O=\$outdir/$sample.sorted.add_read_group.bam RGID=$id RGLB=$readgrouplibrary RGPL=$platform RGPU=$runbarcode RGSM=$samplename\n";
print MINIMAP2 "java -Djava.io.tmpdir=\$tmp -Xmx20g -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/picard-3.1.1/picard.jar MarkDuplicates I=\$outdir/$sample.sorted.add_read_group.bam  O=\$outdir/$sample.sorted.add_read_group.markdup.bam M=\$outdir/$sample.markdup_metrics.txt \n";
print MINIMAP2 "samtools index \$outdir/$sample.sorted.add_read_group.markdup.bam\n";

#nextgenmap
open(NEXTGENMAP, "> $path/$sample/02.$sample.nextgenmap.deal.bam.pbs");
print NEXTGENMAP "#!/bin/sh\n";
print NEXTGENMAP "#PBS -l nodes=1:ppn=$core\n";
print NEXTGENMAP "#PBS -l walltime=7200:00:00\n";
print NEXTGENMAP "eval \"\$(conda shell.bash hook)\"\n";
print NEXTGENMAP "conda activate benchmark\n";
print NEXTGENMAP "outdir=$path/$sample/nextgenmap\n";
print NEXTGENMAP "mkdir -p \$outdir/tmp\n";
print NEXTGENMAP "tmp=\$outdir/tmp\n";
print NEXTGENMAP "java -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/picard-3.1.1/picard.jar AddOrReplaceReadGroups I=\$outdir/$sample.sorted.bam O=\$outdir/$sample.sorted.add_read_group.bam RGID=$id RGLB=$readgrouplibrary RGPL=$platform RGPU=$runbarcode RGSM=$samplename\n";
print NEXTGENMAP "java -Djava.io.tmpdir=\$tmp -Xmx20g -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/picard-3.1.1/picard.jar MarkDuplicates I=\$outdir/$sample.sorted.add_read_group.bam  O=\$outdir/$sample.sorted.add_read_group.markdup.bam M=\$outdir/$sample.markdup_metrics.txt \n";
print NEXTGENMAP "samtools index \$outdir/$sample.sorted.add_read_group.markdup.bam\n";

#subread
open(SUBREAD, "> $path/$sample/02.$sample.subread.deal.bam.pbs");
print SUBREAD "#!/bin/sh\n";
print SUBREAD "#PBS -l nodes=1:ppn=$core\n";
print SUBREAD "#PBS -l walltime=7200:00:00\n";
print SUBREAD "eval \"\$(conda shell.bash hook)\"\n";
print SUBREAD "conda activate benchmark\n";
print SUBREAD "outdir=$path/$sample/subread\n";
print SUBREAD "mkdir -p \$outdir/tmp\n";
print SUBREAD "tmp=\$outdir/tmp\n";
print SUBREAD "java -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/picard-3.1.1/picard.jar AddOrReplaceReadGroups I=\$outdir/$sample.sorted.bam O=\$outdir/$sample.sorted.add_read_group.bam RGID=$id RGLB=$readgrouplibrary RGPL=$platform RGPU=$runbarcode RGSM=$samplename\n";
print SUBREAD "java -Djava.io.tmpdir=\$tmp -Xmx20g -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/picard-3.1.1/picard.jar MarkDuplicates I=\$outdir/$sample.sorted.add_read_group.bam  O=\$outdir/$sample.sorted.add_read_group.markdup.bam M=\$outdir/$sample.markdup_metrics.txt \n";
print SUBREAD "samtools index \$outdir/$sample.sorted.add_read_group.markdup.bam\n";




