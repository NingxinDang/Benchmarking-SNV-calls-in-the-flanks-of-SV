#!/usr/bin/perl -w
use strict;

my $input=shift;
my $sample=shift;
my $align=shift;
my $core=shift;
my $output=shift;

#GATK HaplotypeCaller
#gatk4.0BQSR
open(GATK,"> $output/$sample/$align/01.$sample.$align.gatk.without.realignment.pbs") or die "Couldn't open: $!";
print GATK "#!/bin/sh\n";
print GATK "#PBS -l nodes=1:ppn=$core\n";
print GATK "#PBS -l walltime=7200:00:00\n";
print GATK "eval \"\$(conda shell.bash hook)\"\n";
print GATK "conda activate benchmark\n";
print GATK "mkdir -p $output/$sample/$align/gatk\n";
print GATK "outdir=$output/$sample/$align/gatk\n";
print GATK "mkdir -p $output/$sample/$align/gatk/tmp\n";
print GATK "tmp=$output/$sample/$align/gatk/tmp\n";
print GATK "GATK=/data/home/nxdang/software/miniconda3/envs/benchmark/share/gatk4-4.5.0.0-0/gatk-package-4.5.0.0-local.jar\n";
print GATK "ref=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/04.alignment/00.ref/gatk/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print GATK "dpsnp=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/dbsnp_146.hg38.vcf.gz\n";
print GATK "id_mills=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/Mills_and_1000G_gold_standard.indels.b38.primary_assembly.vcf.gz\n";
print GATK "id_1000g=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf.gz\n";
print GATK "bam=$input/$sample/$align/$sample.sorted.add_read_group.markdup.bam\n";
print GATK "echo GATK start at time && echo \"\`date\`\"\n";
print GATK "java -Djava.io.tmpdir=\$tmp -Xmx20g -jar /data/home/nxdang/software/miniconda3/envs/benchmark/share/gatk4-4.5.0.0-0/gatk-package-4.5.0.0-local.jar BaseRecalibrator -I \$bam -R \$ref --known-sites \$id_mills --known-sites \$id_1000g --known-sites \$dpsnp -O \$outdir/$sample.gatk.raw.table\n";
print GATK "java -Djava.io.tmpdir=\$tmp -Xmx20g -jar /data/home/nxdang/software/miniconda3/envs/benchmark/share/gatk4-4.5.0.0-0/gatk-package-4.5.0.0-local.jar ApplyBQSR -R \$ref -I \$bam --bqsr-recal-file \$outdir/$sample.gatk.raw.table -O \$outdir/$sample.gatk.raw.bam\n";
print GATK "java -Djava.io.tmpdir=\$tmp -Xmx20g -jar /data/home/nxdang/software/miniconda3/envs/benchmark/share/gatk4-4.5.0.0-0/gatk-package-4.5.0.0-local.jar HaplotypeCaller -R \$ref -I \$outdir/$sample.gatk.raw.bam -O \$outdir/$sample.gatk.raw.vcf.gz\n";
print GATK "echo GATK finish at time && echo \"\`date\`\"\n";
print GATK "rm \$outdir/$sample.gatk.raw.bam\n";
close GATK;
#gatk_realignment
open(GA,"> $output/$sample/$align/02.$sample.$align.gatk.with.realignment.pbs");
print GA "#!/bin/sh\n";
print GA "#PBS -l nodes=1:ppn=$core\n";
print GA "#PBS -l walltime=7200:00:00\n";
print GA "eval \"\$(conda shell.bash hook)\"\n";
print GA "conda activate benchmark\n";
print GA "mkdir -p $output/$sample/$align/gatk\n";
print GA "outdir=$output/$sample/$align/gatk\n";
print GA "mkdir -p $output/$sample/$align/gatk/tmp1\n";
print GA "tmp=$output/$sample/$align/gatk/tmp1\n";
print GA "GATK=/data/home/nxdang/software/miniconda3/envs/benchmark/share/gatk4-4.5.0.0-0/gatk-package-4.5.0.0-local.jar\n";
print GA "ref=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/04.alignment/00.ref/gatk/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print GA "dpsnp=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/dbsnp_146.hg38.vcf.gz\n";
print GA "id_mills=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/Mills_and_1000G_gold_standard.indels.b38.primary_assembly.vcf.gz\n";
print GA "id_1000g=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/data/ALL.wgs.1000G_phase3.GRCh38.ncbi_remapper.20150424.shapeit2_indels.vcf.gz\n";
print GA "bam=$input/$sample/$align/$sample.sorted.add_read_group.markdup.realigned.sorted.bam\n";
print GA "echo GATK start at time && echo \"\`date\`\"\n";
print GA "java -Djava.io.tmpdir=\$tmp1 -Xmx20g -jar /data/home/nxdang/software/miniconda3/envs/benchmark/share/gatk4-4.5.0.0-0/gatk-package-4.5.0.0-local.jar BaseRecalibrator -I \$bam -R \$ref --known-sites \$id_mills --known-sites \$id_1000g --known-sites \$dpsnp -O \$outdir/$sample.gatk.realignment.raw.table\n";
print GA "java -Djava.io.tmpdir=\$tmp1 -Xmx20g -jar /data/home/nxdang/software/miniconda3/envs/benchmark/share/gatk4-4.5.0.0-0/gatk-package-4.5.0.0-local.jar ApplyBQSR -R \$ref -I \$bam --bqsr-recal-file \$outdir/$sample.gatk.realignment.raw.table -O \$outdir/$sample.gatk.realignment.raw.bam\n";
print GA "java -Djava.io.tmpdir=\$tmp1 -Xmx20g -jar /data/home/nxdang/software/miniconda3/envs/benchmark/share/gatk4-4.5.0.0-0/gatk-package-4.5.0.0-local.jar HaplotypeCaller -R \$ref -I \$outdir/$sample.gatk.realignment.raw.bam -O \$outdir/$sample.gatk.realignment.raw.vcf.gz\n";
print GA "echo GATK finish at time && echo \"\`date\`\"\n";
print GA "rm \$outdir/$sample.gatk.realignment.raw.bam\n";
close GA;
#strelka2
#without realignment
open(STRELKA,"> $output/$sample/$align/01.$sample.$align.strelka2.pbs");
print STRELKA "#!/bin/sh\n";
print STRELKA "#PBS -l nodes=1:ppn=$core\n";
print STRELKA "#PBS -l walltime=7200:00:00\n";
print STRELKA "eval \"\$(conda shell.bash hook)\"\n";
print STRELKA "conda activate benchmark\n";
print STRELKA "mkdir -p $output/$sample/$align/strelka2\n"; 
print STRELKA "outdir=$output/$sample/$align/strelka2\n";
print STRELKA "strelka=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/strelka-2.9.2.centos6_x86_64/bin/configureStrelkaGermlineWorkflow.py\n";
print STRELKA "bam=$input/$sample/$align/$sample.sorted.add_read_group.markdup.bam\n";
print STRELKA "ref=/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print STRELKA "echo strelka2 calling start at time && echo \"\`date\`\"\n";
print STRELKA "\$strelka --bam \$bam --referenceFasta \$ref --runDir \$outdir\n";
print STRELKA "\$outdir/runWorkflow.py -m local -j $core \n";
print STRELKA "echo strelka2 calling finish at time && echo \"\`date\`\"\n";
#with realignment
open(STRELKAT,"> $output/$sample/$align/02.$sample.$align.strelka2.with.realignment.pbs");
print STRELKAT "#!/bin/sh\n";
print STRELKAT "#PBS -l nodes=1:ppn=$core\n";
print STRELKAT "#PBS -l walltime=7200:00:00\n";
print STRELKAT "eval \"\$(conda shell.bash hook)\"\n";
print STRELKAT "conda activate benchmark\n";
print STRELKAT "mkdir -p $output/$sample/$align/strelka2/realignment\n";
print STRELKAT "outdir=$output/$sample/$align/strelka2/realignment\n";
print STRELKAT "strelka=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/strelka-2.9.2.centos6_x86_64/bin/configureStrelkaGermlineWorkflow.py\n";
print STRELKAT "bam=$input/$sample/$align/$sample.sorted.add_read_group.markdup.realigned.sorted.bam\n";
print STRELKAT "ref=/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print STRELKAT "echo strelka2 calling start at time && echo \"\`date\`\"\n";
print STRELKAT "\$strelka --bam \$bam --referenceFasta \$ref --runDir \$outdir\n";
print STRELKAT "\$outdir/runWorkflow.py -m local -j $core \n";
print STRELKAT "echo strelka2 calling finish at time && echo \"\`date\`\"\n";
close STRELKAT;
#freebayes
#without realignment
open(FREEBAYES,"> $output/$sample/$align/01.$sample.$align.freebayes.pbs");
print FREEBAYES "#!/bin/sh\n";
print FREEBAYES "#PBS -l nodes=1:ppn=$core\n";
print FREEBAYES "#PBS -l walltime=7200:00:00\n";
print FREEBAYES "eval \"\$(conda shell.bash hook)\"\n";
print FREEBAYES "conda activate python2.7\n";
print FREEBAYES "mkdir -p $output/$sample/$align/freebayes\n";
print FREEBAYES "outdir=$output/$sample/$align/freebayes\n";
print FREEBAYES "FreeBayes=~/software/miniconda3/envs/benchmark/bin/freebayes\n"; 
print FREEBAYES "bam=$input/$sample/$align/$sample.sorted.add_read_group.markdup.bam\n";
print FREEBAYES "ref=/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print FREEBAYES "echo FreeBayes caller start at time && echo \"\`date\`\"\n";
print FREEBAYES "\$FreeBayes -f \$ref  --vcf \$outdir/$sample.FreeBayes.raw.vcf -b \$bam\n";
print FREEBAYES "echo FreeBayes caller finish at time && echo \"\`date\`\"\n";
print FREEBAYES "bcftools reheader -f /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/05.snv_call/GRCh38_full_analysis_set_plus_decoy_hla.fa.fai -o \$outdir/$sample.FreeBayes.raw.rename.vcf \$outdir/$sample.FreeBayes.raw.vcf\n";
print FREEBAYES "mv \$outdir/$sample.FreeBayes.raw.rename.vcf \$outdir/$sample.FreeBayes.raw.vcf\n";
print FREEBAYES "bgzip  \$outdir/$sample.FreeBayes.raw.vcf\n";
close FREEBAYES;
#with realignment
open(FREEBAYES1,"> $output/$sample/$align/02.$sample.$align.freebayes.with.realignment.pbs");
print FREEBAYES1 "#!/bin/sh\n";
print FREEBAYES1 "#PBS -l nodes=1:ppn=$core\n";
print FREEBAYES1 "#PBS -l walltime=7200:00:00\n";
print FREEBAYES1 "eval \"\$(conda shell.bash hook)\"\n";
print FREEBAYES1 "conda activate python2.7\n";
print FREEBAYES1 "mkdir -p $output/$sample/$align/freebayes\n";
print FREEBAYES1 "outdir=$output/$sample/$align/freebayes\n";
print FREEBAYES1 "FreeBayes=~/software/miniconda3/envs/benchmark/bin/freebayes\n"; 
print FREEBAYES1 "bam=$input/$sample/$align/$sample.sorted.add_read_group.markdup.realigned.sorted.bam\n";
print FREEBAYES1 "ref=/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print FREEBAYES1 "echo FreeBayes caller start at time && echo \"\`date\`\"\n";
print FREEBAYES1 "\$FreeBayes -f \$ref  --vcf \$outdir/$sample.FreeBayes.realignment.raw.vcf -b \$bam\n";
print FREEBAYES1 "echo FreeBayes caller finish at time && echo \"\`date\`\"\n";
print FREEBAYES1 "bcftools reheader -f /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/05.snv_call/GRCh38_full_analysis_set_plus_decoy_hla.fa.fai -o \$outdir/$sample.FreeBayes.realignment.raw.rename.vcf \$outdir/$sample.FreeBayes.realignment.raw.vcf\n";
print FREEBAYES1 "mv \$outdir/$sample.FreeBayes.realignment.raw.rename.vcf \$outdir/$sample.FreeBayes.realignment.raw.vcf\n";
print FREEBAYES1 "bgzip  \$outdir/$sample.FreeBayes.realignment.raw.vcf\n";
close FREEBAYES1;

#samtools
#without realignment
open(SAMTOOLS,"> $output/$sample/$align/01.$sample.$align.samtools.pbs");
print SAMTOOLS "#!/bin/sh\n";
print SAMTOOLS "#PBS -l nodes=1:ppn=$core\n";
print SAMTOOLS "#PBS -l walltime=7200:00:00\n";
print SAMTOOLS "eval \"\$(conda shell.bash hook)\"\n";
print SAMTOOLS "conda activate benchmark\n";
print SAMTOOLS "mkdir -p $output/$sample/$align/samtools\n";
print SAMTOOLS "outdir=$output/$sample/$align/samtools\n";
print SAMTOOLS "bam=$input/$sample/$align/$sample.sorted.add_read_group.markdup.bam\n";
print SAMTOOLS "ref=/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print SAMTOOLS "echo samtools mpileup start at time && echo \"\`date\`\"\n";
print SAMTOOLS "samtools mpileup -ugf \$ref \$bam| bcftools call -mv -Ov -o \$outdir/$sample.Samtools.raw.vcf\n";
print SAMTOOLS "echo samtools mpileup finish at time && echo \"\`date\`\"\n"; 
print SAMTOOLS "bgzip  \$outdir/$sample.Samtools.raw.vcf\n";
close SAMTOOLS;
#with realignment
open(SAMTOOLS1,"> $output/$sample/$align/02.$sample.$align.samtools.with.realignment.pbs");
print SAMTOOLS1 "#!/bin/sh\n";
print SAMTOOLS1 "#PBS -l nodes=1:ppn=$core\n";
print SAMTOOLS1 "#PBS -l walltime=7200:00:00\n";
print SAMTOOLS1 "eval \"\$(conda shell.bash hook)\"\n";
print SAMTOOLS1 "conda activate benchmark\n";
print SAMTOOLS1 "mkdir -p $output/$sample/$align/samtools\n";
print SAMTOOLS1 "outdir=$output/$sample/$align/samtools\n";
print SAMTOOLS1 "bam=$input/$sample/$align/$sample.sorted.add_read_group.markdup.realigned.sorted.bam\n";
print SAMTOOLS1 "ref=/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print SAMTOOLS1 "echo samtools mpileup start at time && echo \"\`date\`\"\n";
print SAMTOOLS1 "samtools mpileup -ugf \$ref \$bam| bcftools call -mv -Ov -o \$outdir/$sample.Samtools.realignment.raw.vcf\n";
print SAMTOOLS1 "echo samtools mpileup finish at time && echo \"\`date\`\"\n";
print SAMTOOLS1 "bgzip  \$outdir/$sample.Samtools.realignment.raw.vcf\n";
close SAMTOOLS1;
#SNVer
#without realignment
open(SNVER,"> $output/$sample/$align/01.$sample.$align.SNVer.pbs");
print SNVER "#!/bin/sh\n";
print SNVER "#PBS -l nodes=1:ppn=$core\n";
print SNVER "#PBS -l walltime=7200:00:00\n";
print SNVER "eval \"\$(conda shell.bash hook)\"\n";
print SNVER "conda activate benchmark\n";
print SNVER "mkdir -p $output/$sample/$align/SNVer\n";
print SNVER "outdir=$output/$sample/$align/SNVer\n";
print SNVER "mkdir -p $output/$sample/$align/SNVer/tmp\n";
print SNVER "tmp=$output/$sample/$align/SNVer/tmp\n";
print SNVER "bam=$input/$sample/$align/$sample.sorted.add_read_group.markdup.bam\n";
print SNVER "ref=/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print SNVER "SNVer=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/SNVer-0.5.3/SNVerIndividual.jar\n";
print SNVER "ref=/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print SNVER "echo SNVer start at time && echo \"\`date\`\"\n";
print SNVER "java -Djava.io.tmpdir=\$tmp -Xmx20g -jar \$SNVer  -i \$bam -r \$ref  -o \$outdir/$sample.SNVer.raw \n";
print SNVER "echo SNVer finish at time && echo \"\`date\`\"\n";
close SNVER;
#with realignment
open(SNVER1,"> $output/$sample/$align/02.$sample.$align.SNVer.with.realignment.pbs");
print SNVER1 "#!/bin/sh\n";
print SNVER1 "#PBS -l nodes=1:ppn=$core\n";
print SNVER1 "#PBS -l walltime=7200:00:00\n";
print SNVER1 "eval \"\$(conda shell.bash hook)\"\n";
print SNVER1 "conda activate benchmark\n";
print SNVER1 "mkdir -p $output/$sample/$align/SNVer\n";
print SNVER1 "outdir=$output/$sample/$align/SNVer\n";
print SNVER1 "mkdir -p $output/$sample/$align/SNVer/tmp1\n";
print SNVER1 "tmp=$output/$sample/$align/SNVer/tmp1\n";
print SNVER1 "bam=$input/$sample/$align/$sample.sorted.add_read_group.markdup.realigned.sorted.bam\n";
print SNVER1 "ref=/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print SNVER1 "SNVer=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/SNVer-0.5.3/SNVerIndividual.jar\n";
print SNVER1 "ref=/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print SNVER1 "echo SNVer start at time && echo \"\`date\`\"\n";
print SNVER1 "java -Djava.io.tmpdir=\$tmp1 -Xmx20g -jar \$SNVer  -i \$bam -r \$ref  -o \$outdir/$sample.SNVer.realignment.raw \n";
print SNVER1 "echo SNVer finish at time && echo \"\`date\`\"\n";
close SNVER1;
#VarScan
#without realignment
open(VARSCAN, "> $output/$sample/$align/01.$sample.$align.VarScan.pbs");
print VARSCAN "#!/bin/sh\n";
print VARSCAN "#PBS -l nodes=1:ppn=$core\n";
print VARSCAN "#PBS -l walltime=7200:00:00\n";
print VARSCAN "eval \"\$(conda shell.bash hook)\"\n";
print VARSCAN "conda activate benchmark\n";
print VARSCAN "mkdir -p $output/$sample/$align/VarScan\n"; 
print VARSCAN "outdir=$output/$sample/$align/VarScan\n";
print VARSCAN "mkdir -p $output/$sample/$align/VarScan/tmp1\n";
print VARSCAN "tmp=$output/$sample/$align/VarScan/tmp1\n";
print VARSCAN "bam=$input/$sample/$align/$sample.sorted.add_read_group.markdup.bam\n";
print VARSCAN "ref=/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print VARSCAN "VarScan=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/VarScan-2.4.6/VarScan.v2.4.6.jar\n";
print VARSCAN "echo VarScan start at time && echo \"\`date\`\"\n";
print VARSCAN "samtools mpileup -B -f \$ref \$bam | java -Djava.io.tmpdir=\$tmp1 -Xmx20g -jar \$VarScan mpileup2cns --p-value 0.05 --variants 1 --output-vcf 1 > \$outdir/$sample.VarScan.raw.vcf\n";
print VARSCAN  "echo VarScan finish at time && echo \"\`date\`\"\n";
print VARSCAN "bcftools reheader -f /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/05.snv_call/GRCh38_full_analysis_set_plus_decoy_hla.fa.fai -o \$outdir/$sample.VarScan.raw.rename.vcf \$outdir/$sample.VarScan.raw.vcf\n";
print VARSCAN "mv \$outdir/$sample.VarScan.raw.rename.vcf \$outdir/$sample.VarScan.raw.vcf\n";
print VARSCAN "bgzip \$outdir/$sample.VarScan.raw.vcf\n";
close VARSCAN;
#without realignment
open(VARSCAN1, "> $output/$sample/$align/02.$sample.$align.VarScan.with.realignment.pbs");
print VARSCAN1 "#!/bin/sh\n";
print VARSCAN1 "#PBS -l nodes=1:ppn=$core\n";
print VARSCAN1 "#PBS -l walltime=7200:00:00\n";
print VARSCAN1 "eval \"\$(conda shell.bash hook)\"\n";
print VARSCAN1 "conda activate benchmark\n";
print VARSCAN1 "mkdir -p $output/$sample/$align/VarScan\n";
print VARSCAN1 "outdir=$output/$sample/$align/VarScan\n";
print VARSCAN1 "mkdir -p $output/$sample/$align/VarScan/tmp\n";
print VARSCAN1 "tmp=$output/$sample/$align/VarScan/tmp\n";
print VARSCAN1 "bam=$input/$sample/$align/$sample.sorted.add_read_group.markdup.realigned.sorted.bam\n";
print VARSCAN1 "ref=/data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome/GRCh38_full_analysis_set_plus_decoy_hla.fa\n";
print VARSCAN1 "VarScan=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/bin/VarScan-2.4.6/VarScan.v2.4.6.jar\n";
print VARSCAN1 "echo VarScan start at time && echo \"\`date\`\"\n";
print VARSCAN1 "samtools mpileup -B -f \$ref \$bam | java -Djava.io.tmpdir=\$tmp -Xmx20g -jar \$VarScan mpileup2cns --p-value 0.05 --variants 1 --output-vcf 1 > \$outdir/$sample.VarScan.realignment.raw.vcf\n";
print VARSCAN1  "echo VarScan finish at time && echo \"\`date\`\"\n";
print VARSCAN1 "bcftools reheader -f /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/05.snv_call/GRCh38_full_analysis_set_plus_decoy_hla.fa.fai -o \$outdir/$sample.VarScan.realignment.raw.rename.vcf \$outdir/$sample.VarScan.realignment.raw.vcf\n";
print VARSCAN1 "mv \$outdir/$sample.VarScan.realignment.raw.rename.vcf \$outdir/$sample.VarScan.realignment.raw.vcf\n";
print VARSCAN1 "bgzip \$outdir/$sample.VarScan.realignment.raw.vcf\n";
close VARSCAN1;
#deepvariant
open(DEEPVARIANT, "> $output/$sample/$align/01.$sample.$align.deepvariant.pbs");
print DEEPVARIANT "#!/bin/sh\n";
print DEEPVARIANT "#PBS -l nodes=1:ppn=$core\n";
print DEEPVARIANT "#PBS -l walltime=7200:00:00\n";
print DEEPVARIANT "eval \"\$(conda shell.bash hook)\"\n";
print DEEPVARIANT "conda activate benchmark\n";
print DEEPVARIANT "mkdir -p $output/$sample/$align/DeepVariant\n";
print DEEPVARIANT "mkdir -p $output/$sample/$align/DeepVariant/intermediate_results_dir\n";
print DEEPVARIANT "docker run  -v $input/$sample/$align:/input  -v /data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome:/ref  -v $output/$sample/$align/DeepVariant:/output google/deepvariant:1.6.0 /opt/deepvariant/bin/run_deepvariant --model_type=WGS --ref=/ref/GRCh38_full_analysis_set_plus_decoy_hla.fa --reads=/input/$sample.sorted.add_read_group.markdup.bam  --output_vcf /output/$sample.deepvariant.raw.vcf --num_shards $core --make_examples_extra_args min_mapping_quality=1,keep_supplementary_alignments=true --intermediate_results_dir  /output/intermediate_results_dir \n";
print DEEPVARIANT  "echo deepvariant finish at time && echo \"\`date\`\"\n";
print DEEPVARIANT "bgzip /output/$sample.deepvariant.raw.vcf\n";
close DEEPVARIANT;
#without realignment
open(DEEPVARIANTT, "> $output/$sample/$align/02.$sample.$align.deepvariant.with.realignment.pbs");
print DEEPVARIANTT "#!/bin/sh\n";
print DEEPVARIANTT "#PBS -l nodes=1:ppn=$core\n";
print DEEPVARIANTT "#PBS -l walltime=7200:00:00\n";
print DEEPVARIANTT "eval \"\$(conda shell.bash hook)\"\n";
print DEEPVARIANTT "conda activate benchmark\n";
print DEEPVARIANTT "mkdir -p $output/$sample/$align/DeepVariant/realignment\n";
print DEEPVARIANTT "mkdir -p $output/$sample/$align/DeepVariant/realignment/intermediate_results_dir\n";
print DEEPVARIANTT "docker run  -v $input/$sample/$align:/input  -v /data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome:/ref  -v $output/$sample/$align/DeepVariant/realignment:/output google/deepvariant:1.6.0 /opt/deepvariant/bin/run_deepvariant --model_type=WGS --ref=/ref/GRCh38_full_analysis_set_plus_decoy_hla.fa --reads=/input/$sample.sorted.add_read_group.markdup.realigned.sorted.bam  --output_vcf /output/$sample.deepvariant.realignment.raw.vcf --num_shards $core --make_examples_extra_args min_mapping_quality=1,keep_supplementary_alignments=true --intermediate_results_dir  /output/intermediate_results_dir \n";
print DEEPVARIANTT  "echo deepvariant finish at time && echo \"\`date\`\"\n";
print DEEPVARIANTT "bgzip /output/$sample.deepvariant.realignment.raw.vcf\n";
close DEEPVARIANTT;




