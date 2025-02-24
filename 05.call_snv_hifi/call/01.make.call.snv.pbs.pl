#!/usr/bin/perl -w
use strict;

my $input=shift;
my $sample=shift;
my $align=shift;
my $core=shift;
my $output=shift;


#longshot
open(LONGSHOT, "> $output/$sample/$align/01.$sample.$align.longshot.pbs");
print LONGSHOT "#!/bin/sh\n";
print LONGSHOT "#PBS -l nodes=1:ppn=$core\n";
print LONGSHOT "#PBS -l walltime=7200:00:00\n";
print LONGSHOT "eval \"\$(conda shell.bash hook)\"\n";
print LONGSHOT "conda activate benchmark\n";
print LONGSHOT "mkdir -p $output/$sample/$align/longshot\n";
print LONGSHOT "longshot -A --density_params --bam $input/$sample/ChineseQuartet.$sample.5cells.GRCh38.HiFi.$align.bam --ref /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/04.HiFi_alignment/00.ref/GRCh38_full_analysis_set_plus_decoy_hla.fa --out $output/$sample/$align/longshot/$sample.$align.longshot.raw.vcf\n";
close LONGSHOT;

#nanocaller
open(NANOCALLER, "> $output/$sample/$align/01.$sample.$align.nanocaller.pbs");
print NANOCALLER "#!/bin/sh\n";
print NANOCALLER "#PBS -l nodes=1:ppn=$core\n";
print NANOCALLER "#PBS -l walltime=7200:00:00\n";
print NANOCALLER "eval \"\$(conda shell.bash hook)\"\n";
print NANOCALLER "conda activate minimap2\n";
print NANOCALLER "mkdir -p $output/$sample/$align/nanocaller\n";
print NANOCALLER "NanoCaller --bam $input/$sample/ChineseQuartet.$sample.5cells.GRCh38.HiFi.$align.bam --ref /data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/04.HiFi_alignment/00.ref/GRCh38_full_analysis_set_plus_decoy_hla.fa --sequencing pacbio --wgs_contigs chr1-22XY --cpu $core --mode snps --snp_model CCS-HG002 --neighbor_threshold '0.3,0.7' --phase --output $output/$sample/$align/nanocaller --prefix $sample.$align.nanocaller.raw\n";
close NANOCALLER;

#clair3
open(CLAIR, "> $output/$sample/$align/01.$sample.$align.clair3.pbs");
print CLAIR "#!/bin/sh\n";
print CLAIR "#PBS -l nodes=1:ppn=$core\n";
print CLAIR "#PBS -l walltime=7200:00:00\n";
print CLAIR "eval \"\$(conda shell.bash hook)\"\n";
print CLAIR "conda activate clair3\n";
print CLAIR "mkdir -p $output/$sample/$align/clair3\n";
print CLAIR "run_clair3.sh --bam_fn=$input/$sample/ChineseQuartet.$sample.5cells.GRCh38.HiFi.$align.bam --ref_fn=/data/home/nxdang/project/t2t_version_cpc/chineseQuartet/filter_benchmarks/04.HiFi_alignment/00.ref/GRCh38_full_analysis_set_plus_decoy_hla.fa --threads=$core --platform=\"hifi\" --model_path=\"/data/home/nxdang/software/miniconda3/envs/clair3/bin/models/hifi_sequel2\" --remove_intermediate_dir --call_snp_only --sample_name=$sample --output=$output/$sample/$align/clair3 \n";
close CLAIR ;


#deepvariant
open(DEEPVARIANT, "> $output/$sample/$align/01.$sample.$align.deepvariant.pbs");
print DEEPVARIANT "#!/bin/sh\n";
print DEEPVARIANT "#PBS -l nodes=1:ppn=$core\n";
print DEEPVARIANT "#PBS -l walltime=7200:00:00\n";
print DEEPVARIANT "eval \"\$(conda shell.bash hook)\"\n";
print DEEPVARIANT "conda activate benchmark\n";
print DEEPVARIANT "mkdir -p $output/$sample/$align/DeepVariant\n";
print DEEPVARIANT "mkdir -p $output/$sample/$align/DeepVariant/intermediate_results_dir\n";
print DEEPVARIANT "docker run  -v $input/$sample:/input  -v /data/DATA/Reference/human/GRCh38_full_analysis_set_plus_decoy_hla/genome:/ref  -v $output/$sample/$align/DeepVariant:/output google/deepvariant:1.6.0 /opt/deepvariant/bin/run_deepvariant --model_type=PACBIO --ref=/ref/GRCh38_full_analysis_set_plus_decoy_hla.fa --reads=/input/ChineseQuartet.$sample.5cells.GRCh38.HiFi.$align.bam  --output_vcf /output/$sample.$align.deepvariant.raw.vcf --num_shards $core --make_examples_extra_args min_mapping_quality=1,keep_supplementary_alignments=true --intermediate_results_dir  /output/intermediate_results_dir \n";
print DEEPVARIANT  "echo deepvariant finish at time && echo \"\`date\`\"\n";
print DEEPVARIANT "bgzip /output/$sample.deepvariant.raw.vcf\n";
close DEEPVARIANT;

