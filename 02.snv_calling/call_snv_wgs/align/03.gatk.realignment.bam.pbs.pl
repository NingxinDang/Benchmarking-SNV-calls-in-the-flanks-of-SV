#!/usr/bin/perl -w
use strict;

my $sample=shift;
my $path=shift;
my $core=shift;

#bwa
open(BWA,"> $path/$sample/03.$sample.bwa.gatk.realignment.bam.pbs");
print BWA "#!/bin/sh\n";
print BWA "#PBS -l nodes=1:ppn=$core\n";
print BWA "#PBS -l walltime=7200:00:00\n";
print BWA "eval \"\$(conda shell.bash hook)\"\n";
print BWA "conda activate gatk3.8\n";
print BWA "outdir=$path/$sample/bwa\n";
print BWA "mkdir -p \$outdir/tmp\n";
print BWA "tmp=\$outdir/tmp\n";
print BWA "bam=\$outdir/$sample.sorted.add_read_group.markdup.bam\n";
print BWA "ref=/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print BWA "id_mills=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/Mills_and_1000G_gold_standard.indels.b38.primary_assembly.vcf.gz\n";
print BWA "id_1000g=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf.gz\n";
print BWA "dpsnp=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/Homo_sapiens_assembly38.dbsnp138.vcf.gz\n";
print BWA "# GATK local realignment and recalibration\n";
print BWA "java  -Djava.io.tmpdir=\$tmp -Xmx10g -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/gatk3.8.0-master/GenomeAnalysisTK.jar -T RealignerTargetCreator -R \$ref -rf BadCigar -known \$id_mills -known \$id_1000g -nt $core -I \$bam -log \$outdir/Quartet_DNA_ILM_Nova_BRG_LCL5.realignertarget.log -o \$outdir/$sample.sorted.add_read_group.markdup.bam.forRealigner.intervals --allow_potentially_misencoded_quality_scores\n";
print BWA "echo CREATE INTERVALS FOR LOCAL REALIGNMENT finish at time && echo \"\`date\`\"\n";
print BWA "java  -Djava.io.tmpdir=\$tmp -Xmx10g -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/gatk3.8.0-master/GenomeAnalysisTK.jar -T IndelRealigner -R \$ref -rf BadCigar -known \$id_mills -known \$id_1000g --consensusDeterminationModel USE_READS -compress 0 -targetIntervals \$outdir/$sample.sorted.add_read_group.markdup.bam.forRealigner.intervals -I \$bam -o \$outdir/$sample.sorted.add_read_group.markdup.realigned.bam -log \$outdir/$sample.sorted.add_read_group.markdup.realigned.bam.log --allow_potentially_misencoded_quality_scores\n";
print BWA "echo PERFORM LOCAL REALIGNMENT finish at time && echo \"\`date\`\"\n";
print BWA "time samtools sort -@ $core -m 4G -O bam -o \$outdir/$sample.sorted.add_read_group.markdup.realigned.sorted.bam \$outdir/$sample.sorted.add_read_group.markdup.realigned.bam\n";
print BWA "samtools index \$outdir/$sample.sorted.add_read_group.markdup.realigned.sorted.bam\n";

#bowtie2
open(BOWTIE2,"> $path/$sample/03.$sample.bowtie2.gatk.realignment.bam.pbs");
print BOWTIE2 "#!/bin/sh\n";
print BOWTIE2 "#PBS -l nodes=1:ppn=$core\n";
print BOWTIE2 "#PBS -l walltime=7200:00:00\n";
print BOWTIE2 "eval \"\$(conda shell.bash hook)\"\n";
print BOWTIE2 "conda activate gatk3.8\n";
print BOWTIE2 "outdir=$path/$sample/bowtie2\n";
print BOWTIE2 "mkdir -p \$outdir/tmp\n";
print BOWTIE2 "tmp=\$outdir/tmp\n";
print BOWTIE2 "bam=\$outdir/$sample.sorted.add_read_group.markdup.bam\n";
print BOWTIE2 "ref=/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print BOWTIE2 "id_mills=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/Mills_and_1000G_gold_standard.indels.b38.primary_assembly.vcf.gz\n";
print BOWTIE2 "id_1000g=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf.gz\n";
print BOWTIE2 "dpsnp=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/Homo_sapiens_assembly38.dbsnp138.vcf.gz\n";
print BOWTIE2 "# GATK local realignment and recalibration\n";
print BOWTIE2 "java  -Djava.io.tmpdir=\$tmp -Xmx10g -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/gatk3.8.0-master/GenomeAnalysisTK.jar -T RealignerTargetCreator -R \$ref -rf BadCigar -known \$id_mills -known \$id_1000g -nt $core -I \$bam -log \$outdir/Quartet_DNA_ILM_Nova_BRG_LCL5.realignertarget.log -o \$outdir/$sample.sorted.add_read_group.markdup.bam.forRealigner.intervals --allow_potentially_misencoded_quality_scores\n";
print BOWTIE2 "echo CREATE INTERVALS FOR LOCAL REALIGNMENT finish at time && echo \"\`date\`\"\n";
print BOWTIE2 "java  -Djava.io.tmpdir=\$tmp -Xmx10g -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/gatk3.8.0-master/GenomeAnalysisTK.jar -T IndelRealigner -R \$ref -rf BadCigar -known \$id_mills -known \$id_1000g --consensusDeterminationModel USE_READS -compress 0 -targetIntervals \$outdir/$sample.sorted.add_read_group.markdup.bam.forRealigner.intervals -I \$bam -o \$outdir/$sample.sorted.add_read_group.markdup.realigned.bam -log \$outdir/$sample.sorted.add_read_group.markdup.realigned.bam.log --allow_potentially_misencoded_quality_scores\n";
print BOWTIE2 "echo PERFORM LOCAL REALIGNMENT finish at time && echo \"\`date\`\"\n";
print BOWTIE2 "time samtools sort -@ $core -m 4G -O bam -o \$outdir/$sample.sorted.add_read_group.markdup.realigned.sorted.bam \$outdir/$sample.sorted.add_read_group.markdup.realigned.bam\n";
print BOWTIE2 "samtools index \$outdir/$sample.sorted.add_read_group.markdup.realigned.sorted.bam\n";


#minimap2
open(MINIMAP2,"> $path/$sample/03.$sample.minimap2.gatk.realignment.bam.pbs");
print MINIMAP2 "#!/bin/sh\n";
print MINIMAP2 "#PBS -l nodes=1:ppn=$core\n";
print MINIMAP2 "#PBS -l walltime=7200:00:00\n";
print MINIMAP2 "eval \"\$(conda shell.bash hook)\"\n";
print MINIMAP2 "conda activate gatk3.8\n";
print MINIMAP2 "outdir=$path/$sample/minimap2\n";
print MINIMAP2 "mkdir -p \$outdir/tmp\n";
print MINIMAP2 "tmp=\$outdir/tmp\n";
print MINIMAP2 "bam=\$outdir/$sample.sorted.add_read_group.markdup.bam\n";
print MINIMAP2 "ref=/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print MINIMAP2 "id_mills=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/Mills_and_1000G_gold_standard.indels.b38.primary_assembly.vcf.gz\n";
print MINIMAP2 "id_1000g=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf.gz\n";
print MINIMAP2 "dpsnp=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/Homo_sapiens_assembly38.dbsnp138.vcf.gz\n";
print MINIMAP2 "# GATK local realignment and recalibration\n";
print MINIMAP2 "java  -Djava.io.tmpdir=\$tmp -Xmx10g -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/gatk3.8.0-master/GenomeAnalysisTK.jar -T RealignerTargetCreator -R \$ref -rf BadCigar -known \$id_mills -known \$id_1000g -nt $core -I \$bam -log \$outdir/Quartet_DNA_ILM_Nova_BRG_LCL5.realignertarget.log -o \$outdir/$sample.sorted.add_read_group.markdup.bam.forRealigner.intervals --allow_potentially_misencoded_quality_scores\n";
print MINIMAP2 "echo CREATE INTERVALS FOR LOCAL REALIGNMENT finish at time && echo \"\`date\`\"\n";
print MINIMAP2 "java  -Djava.io.tmpdir=\$tmp -Xmx10g -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/gatk3.8.0-master/GenomeAnalysisTK.jar -T IndelRealigner -R \$ref -rf BadCigar -known \$id_mills -known \$id_1000g --consensusDeterminationModel USE_READS -compress 0 -targetIntervals \$outdir/$sample.sorted.add_read_group.markdup.bam.forRealigner.intervals -I \$bam -o \$outdir/$sample.sorted.add_read_group.markdup.realigned.bam -log \$outdir/$sample.sorted.add_read_group.markdup.realigned.bam.log --allow_potentially_misencoded_quality_scores\n";
print MINIMAP2 "echo PERFORM LOCAL REALIGNMENT finish at time && echo \"\`date\`\"\n";
print MINIMAP2 "time samtools sort -@ $core -m 4G -O bam -o \$outdir/$sample.sorted.add_read_group.markdup.realigned.sorted.bam \$outdir/$sample.sorted.add_read_group.markdup.realigned.bam\n";
print MINIMAP2 "samtools index \$outdir/$sample.sorted.add_read_group.markdup.realigned.sorted.bam\n";



#nextgenmap
open(NEXTGENMAP, "> $path/$sample/03.$sample.nextgenmap.gatk.realignment.bam.pbs");
print NEXTGENMAP "#!/bin/sh\n";
print NEXTGENMAP "#PBS -l nodes=1:ppn=$core\n";
print NEXTGENMAP "#PBS -l walltime=7200:00:00\n";
print NEXTGENMAP "eval \"\$(conda shell.bash hook)\"\n";
print NEXTGENMAP "conda activate gatk3.8\n";
print NEXTGENMAP "outdir=$path/$sample/nextgenmap\n";
print NEXTGENMAP "mkdir -p \$outdir/tmp\n";
print NEXTGENMAP "tmp=\$outdir/tmp\n";
print NEXTGENMAP "bam=\$outdir/$sample.sorted.add_read_group.markdup.bam\n";
print NEXTGENMAP "ref=/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print NEXTGENMAP "id_mills=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/Mills_and_1000G_gold_standard.indels.b38.primary_assembly.vcf.gz\n";
print NEXTGENMAP "id_1000g=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf.gz\n";
print NEXTGENMAP "dpsnp=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/Homo_sapiens_assembly38.dbsnp138.vcf.gz\n";
print NEXTGENMAP "# GATK local realignment and recalibration\n";
print NEXTGENMAP "java  -Djava.io.tmpdir=\$tmp -Xmx10g -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/gatk3.8.0-master/GenomeAnalysisTK.jar -T RealignerTargetCreator -R \$ref -rf BadCigar -known \$id_mills -known \$id_1000g -nt $core -I \$bam -log \$outdir/Quartet_DNA_ILM_Nova_BRG_LCL5.realignertarget.log -o \$outdir/$sample.sorted.add_read_group.markdup.bam.forRealigner.intervals --allow_potentially_misencoded_quality_scores\n";
print NEXTGENMAP "echo CREATE INTERVALS FOR LOCAL REALIGNMENT finish at time && echo \"\`date\`\"\n";
print NEXTGENMAP "java  -Djava.io.tmpdir=\$tmp -Xmx10g -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/gatk3.8.0-master/GenomeAnalysisTK.jar -T IndelRealigner -R \$ref -rf BadCigar -known \$id_mills -known \$id_1000g --consensusDeterminationModel USE_READS -compress 0 -targetIntervals \$outdir/$sample.sorted.add_read_group.markdup.bam.forRealigner.intervals -I \$bam -o \$outdir/$sample.sorted.add_read_group.markdup.realigned.bam -log \$outdir/$sample.sorted.add_read_group.markdup.realigned.bam.log --allow_potentially_misencoded_quality_scores\n";
print NEXTGENMAP "echo PERFORM LOCAL REALIGNMENT finish at time && echo \"\`date\`\"\n";
print NEXTGENMAP "time samtools sort -@ $core -m 4G -O bam -o \$outdir/$sample.sorted.add_read_group.markdup.realigned.sorted.bam \$outdir/$sample.sorted.add_read_group.markdup.realigned.bam\n";
print NEXTGENMAP "samtools index \$outdir/$sample.sorted.add_read_group.markdup.realigned.sorted.bam\n";


#subread
open(SUBREAD, "> $path/$sample/03.$sample.subread.gatk.realignment.bam.pbs");
print SUBREAD "#!/bin/sh\n";
print SUBREAD "#PBS -l nodes=1:ppn=$core\n";
print SUBREAD "#PBS -l walltime=7200:00:00\n";
print SUBREAD "eval \"\$(conda shell.bash hook)\"\n";
print SUBREAD "conda activate gatk3.8\n";
print SUBREAD "outdir=$path/$sample/subread\n";
print SUBREAD "mkdir -p \$outdir/tmp\n";
print SUBREAD "tmp=\$outdir/tmp\n";
print SUBREAD "bam=\$outdir/$sample.sorted.add_read_group.markdup.bam\n";
print SUBREAD "ref=/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print SUBREAD "id_mills=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/Mills_and_1000G_gold_standard.indels.b38.primary_assembly.vcf.gz\n";
print SUBREAD "id_1000g=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf.gz\n";
print SUBREAD "dpsnp=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/Homo_sapiens_assembly38.dbsnp138.vcf.gz\n";
print SUBREAD "# GATK local realignment and recalibration\n";
print SUBREAD "java  -Djava.io.tmpdir=\$tmp -Xmx10g -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/gatk3.8.0-master/GenomeAnalysisTK.jar -T RealignerTargetCreator -R \$ref -rf BadCigar -known \$id_mills -known \$id_1000g -nt $core -I \$bam -log \$outdir/Quartet_DNA_ILM_Nova_BRG_LCL5.realignertarget.log -o \$outdir/$sample.sorted.add_read_group.markdup.bam.forRealigner.intervals --allow_potentially_misencoded_quality_scores\n";
print SUBREAD "echo CREATE INTERVALS FOR LOCAL REALIGNMENT finish at time && echo \"\`date\`\"\n";
print SUBREAD "java  -Djava.io.tmpdir=\$tmp -Xmx10g -jar /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/gatk3.8.0-master/GenomeAnalysisTK.jar -T IndelRealigner -R \$ref -rf BadCigar -known \$id_mills -known \$id_1000g --consensusDeterminationModel USE_READS -compress 0 -targetIntervals \$outdir/$sample.sorted.add_read_group.markdup.bam.forRealigner.intervals -I \$bam -o \$outdir/$sample.sorted.add_read_group.markdup.realigned.bam -log \$outdir/$sample.sorted.add_read_group.markdup.realigned.bam.log --allow_potentially_misencoded_quality_scores\n";
print SUBREAD "echo PERFORM LOCAL REALIGNMENT finish at time && echo \"\`date\`\"\n";
print SUBREAD "time samtools sort -@ $core -m 4G -O bam -o \$outdir/$sample.sorted.add_read_group.markdup.realigned.sorted.bam \$outdir/$sample.sorted.add_read_group.markdup.realigned.bam\n";
print SUBREAD "samtools index \$outdir/$sample.sorted.add_read_group.markdup.realigned.sorted.bam\n";




