#make index
minimap2 -x map-hifi -d <索引的命名前缀> human_reference.fasta
#align
minimap2 -ax map-hifi ref.fa pacbio-ccs.fq.gz > aln.sam
-a -H --eqx --MD -Y
meryl count k=15 output merylDB ref.fa
meryl print greater-than distinct=0.9998 merylDB > repetitive_k15.txt

winnowmap -W repetitive_k15.txt -ax map-pb ref.fa hifi.fq.gz > output.sam
ngmlr -t 4 --rg-id --rg-s  -r reference.fasta -q reads.fastq -x pacbio -o test.sam

#pbmm2_CCS or HiFi_modes
pbmm2 align --preset CCS --sort -j 24 -J 8 --log-level INFO --log-file pbmm2.HG003.log -k 19 -w 19 -u -o 6 -O 26 -e 2 -E 1 -A 1 -B 4 -z 400 -Z 50  -r 2000  -g 5000 --rg '@RG\tID:myid\tSM:mysample' --sample HG003 Human_ref/GRCh38.mmi input.bam/fa/fq HG003.align.bam

#align reads to ref
zcat read.fa.gz|lra align -CCS ref.fa read.fa -t 16 -p s > output.sam
