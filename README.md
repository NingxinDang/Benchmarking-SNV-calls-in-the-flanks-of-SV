# Benchmarking-SNV-calls-in-the-flanks-of-SV
Benchmarking-SNV-calls-in-the-flanks-of-structural-variants


This repository houses the 92 benchmarking regions (in BED format) utilized in the paper "Variant calling in the dark genome: benchmarking SNV calls in the flanks of structural variants",
plus, the associated scripts used to (a) create them, (b) run variant calling pipelines against them, and (c) parse output of the same. Scripts should be considered "lab quality" rather than "developer quality." 

The construction of SV-flank benchmarking dataset 

We adopted far more stringent criteria than the original Chinese Quartet ‘tier 1’. Specifically, we retained only those SVs which (a) were supported by all three of HiFi reads, Illumina reads, and a HRA (for deletions) or both of HiFi reads and a HRA (for insertions), (b) were not included in a simple repeat, short tandem repeat, variable number tandem repeat, or segmentally duplicated region, (c) were located on a chromosome assembled either telomere-to-telomere or telomere-to-centromere for both arms (specifically, chromosomes 2, 3, 4, 5, 6, 7, 8, 10, 11, 12, 19, 20, and X), and (d) had a low variant density in their immediate flanks, having no more than 5 putative SNVs within 100bp either side of the breakpoint. We also retained only those ‘tier 2’ SNVs which had been assigned to tier 2 solely because of proximity to a SV; that is, in all other respects, they met the tier 1 criteria. Finally, we manually reviewed each breakpoint using IGV, excluding erroneous calls and looking in particular for where algorithmically-assigned breakpoint locations differed from read pileups. At its most conservative, our dataset comprised 299 deletions and 701 insertions, of which 98 deletions and 700 insertions had algorithmically-derived breakpoints accurate to single-base resolution, all supported by manual review. We then established 23 sets of flanking sequences for each SV, representing between 5 and 500 bases either side (5bp, 10bp intervals from 10-150bp, and 50bp intervals from 200-500bp). 

Data Availability

The benchmark SNV call set, also known as the truth set VCFs, can be downloaded from the Genome Variation Map (GVM). The accession number is GVM000971, and the download link is https://bigd.big.ac.cn/gvm/getProjectDetail?Project=GVM000971.
The benchmark region can be obtained from from the folder named "benchmark region". Information regarding the benchmark SNV call set and the region can be obtained from the table named "The info of Benchmark data".
The reference genome is available for download from https://ftp.1000genomes.ebi.ac.uk/vol1/ftp/technical/reference/GRCh38_reference_genome/GRCh38_full_analysis_set_plus_decoy_hla.fa.

