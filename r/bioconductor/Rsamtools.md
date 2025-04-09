Rsamtools
================
2025-04-07

- [links](#links)
- [example](#example)
- [subset using `GRanges`](#subset-using-granges)
- [iterate over sequences](#iterate-over-sequences)
- [`BamViews`](#bamviews)
- [session info](#session-info)

## links

- <https://kasperdanielhansen.github.io/genbioconductor/html/Rsamtools.html>

## example

``` r
library(Rsamtools)

bamPath = system.file("extdata", "ex1.bam", package="Rsamtools")
(bamFile = BamFile(bamPath))
# class: BamFile 
# path: /Library/Frameworks/R.framework/Versions/4.4-x86_64/Resources/l.../ex1.bam
# index: /Library/Frameworks/R.framework/Versions/4.4-x86_64/Resour.../ex1.bam.bai
# isOpen: FALSE 
# yieldSize: NA 
# obeyQname: FALSE 
# asMates: FALSE 
# qnamePrefixEnd: NA 
# qnameSuffixStart: NA
```

``` r
quickBamFlagSummary(bamFile)
#                                 group |    nb of |    nb of | mean / max
#                                    of |  records |   unique | records per
#                               records | in group |   QNAMEs | unique QNAME
# All records........................ A |     3307 |     1699 | 1.95 / 2
#   o template has single segment.... S |        0 |        0 |   NA / NA
#   o template has multiple segments. M |     3307 |     1699 | 1.95 / 2
#       - first segment.............. F |     1654 |     1654 |    1 / 1
#       - last segment............... L |     1653 |     1653 |    1 / 1
#       - other segment.............. O |        0 |        0 |   NA / NA
# 
# Note that (S, M) is a partitioning of A, and (F, L, O) is a partitioning of M.
# Indentation reflects this.
# 
# Details for group M:
#   o record is mapped.............. M1 |     3271 |     1699 | 1.93 / 2
#       - primary alignment......... M2 |     3271 |     1699 | 1.93 / 2
#       - secondary alignment....... M3 |        0 |        0 |   NA / NA
#   o record is unmapped............ M4 |       36 |       36 |    1 / 1
# 
# Details for group F:
#   o record is mapped.............. F1 |     1641 |     1641 |    1 / 1
#       - primary alignment......... F2 |     1641 |     1641 |    1 / 1
#       - secondary alignment....... F3 |        0 |        0 |   NA / NA
#   o record is unmapped............ F4 |       13 |       13 |    1 / 1
# 
# Details for group L:
#   o record is mapped.............. L1 |     1630 |     1630 |    1 / 1
#       - primary alignment......... L2 |     1630 |     1630 |    1 / 1
#       - secondary alignment....... L3 |        0 |        0 |   NA / NA
#   o record is unmapped............ L4 |       23 |       23 |    1 / 1
```

``` r
seqinfo(bamFile)
# Seqinfo object with 2 sequences from an unspecified genome:
#   seqnames seqlengths isCircular genome
#   seq1           1575         NA   <NA>
#   seq2           1584         NA   <NA>
```

``` r
seqlevels(bamFile)
# [1] "seq1" "seq2"
```

``` r
bam = scanBam(bamFile)
class(bam)
# [1] "list"
length(bam)
# [1] 1
names(bam[[1]])
#  [1] "qname"  "flag"   "rname"  "strand" "pos"    "qwidth" "mapq"   "cigar" 
#  [9] "mrnm"   "mpos"   "isize"  "seq"    "qual"
length(bam[[1]]$seq)
# [1] 3307
```

- **qname**: The name of the read.
- **rname**: The name of the chromosome / sequence / contig it was
  aligned to.
- **strand**: The strand of the alignment.
- **pos**: The coordinate of the left-most part of the alignment.
- **qwidth**: The length of the read.
- **mapq**: The mapping quality of the alignment.
- **seq**: The actual sequence of the alignment.
- **qual**: The quality string of the alignment.
- **cigar**: The CIGAR string (below).
- **flag**: The flag (below)

``` r
purrr::map(bam[[1]], ~.x[1:3])
# $qname
# [1] "B7_591:4:96:693:509"    "EAS54_65:7:152:368:113" "EAS51_64:8:5:734:57"   
# 
# $flag
# [1]  73  73 137
# 
# $rname
# [1] seq1 seq1 seq1
# Levels: seq1 seq2
# 
# $strand
# [1] + + +
# Levels: + - *
# 
# $pos
# [1] 1 3 5
# 
# $qwidth
# [1] 36 35 35
# 
# $mapq
# [1] 99 99 99
# 
# $cigar
# [1] "36M" "35M" "35M"
# 
# $mrnm
# [1] <NA> <NA> <NA>
# Levels: seq1 seq2
# 
# $mpos
# [1] NA NA NA
# 
# $isize
# [1] NA NA NA
# 
# $seq
# DNAStringSet object of length 3:
#     width seq
# [1]    36 CACTAGTGGCTCATTGTAAATGTGTGGTTTAACTCG
# [2]    35 CTAGTGGCTCATTGTAAATGTGTGGTTTAACTCGT
# [3]    35 AGTGGCTCATTGTAAATGTGTGGTTTAACTCGTCC
# 
# $qual
# PhredQuality object of length 3:
#     width seq
# [1]    36 <<<<<<<<<<<<<<<;<<<<<<<<<5<<<<<;:<;7
# [2]    35 <<<<<<<<<<0<<<<655<<7<<<:9<<3/:<6):
# [3]    35 <<<<<<<<<<<7;71<<;<;;<7;<<3;);3*8/5
```

## subset using `GRanges`

``` r
gr = GRanges(seqnames = "seq2",
              ranges = IRanges(start = c(100, 1000), end = c(1500,2000)))
scanBamWhat()
#  [1] "qname"       "flag"        "rname"       "strand"      "pos"        
#  [6] "qwidth"      "mapq"        "cigar"       "mrnm"        "mpos"       
# [11] "isize"       "seq"         "qual"        "groupid"     "mate_status"
params = ScanBamParam(which = gr, what = scanBamWhat())
bam = scanBam(bamFile, param = params)
```

``` r
class(bam)
# [1] "list"
length(bam)
# [1] 2
names(bam)
# [1] "seq2:100-1500"  "seq2:1000-2000"
```

``` r
class(bam[[1]])
# [1] "list"
length(bam[[1]])
# [1] 13
names(bam[[1]])
#  [1] "qname"  "flag"   "rname"  "strand" "pos"    "qwidth" "mapq"   "cigar" 
#  [9] "mrnm"   "mpos"   "isize"  "seq"    "qual"
```

## iterate over sequences

``` r
yieldSize(bamFile) <- 1
open(bamFile)
```

``` r
scanBam(bamFile)[[1]]$seq
# DNAStringSet object of length 1:
#     width seq
# [1]    36 CACTAGTGGCTCATTGTAAATGTGTGGTTTAACTCG
scanBam(bamFile)[[1]]$seq
# DNAStringSet object of length 1:
#     width seq
# [1]    35 CTAGTGGCTCATTGTAAATGTGTGGTTTAACTCGT
scanBam(bamFile)[[1]]$seq
# DNAStringSet object of length 1:
#     width seq
# [1]    35 AGTGGCTCATTGTAAATGTGTGGTTTAACTCGTCC
```

``` r
close(bamFile)
yieldSize(bamFile) <- NA
```

## `BamViews`

``` r
bamView = BamViews(bamPath)
bam = scanBam(bamView)
class(bam)
# [1] "SimpleList"
# attr(,"package")
# [1] "S4Vectors"
names(bam)
# [1] "ex1.bam"
class(bam$ex1.bam)
# [1] "list"
length(bam$ex1.bam)
# [1] 1
class(bam$ex1.bam[[1]])
# [1] "list"
length(bam$ex1.bam[[1]])
# [1] 13
names(bam$ex1.bam[[1]])
#  [1] "qname"  "flag"   "rname"  "strand" "pos"    "qwidth" "mapq"   "cigar" 
#  [9] "mrnm"   "mpos"   "isize"  "seq"    "qual"
table(bam$ex1.bam[[1]]$rname)
# 
# seq1 seq2 
# 1501 1806
```

Apply GRanges to a bam view:

``` r
gr = GRanges(seqnames = "seq2",
              ranges = IRanges(start = c(100, 1000), end = c(1500, 2000)))
bamRanges(bamView) = gr
bam = scanBam(bamView)
length(bam$ex1.bam)
# [1] 2
names(bam$ex1.bam)
# [1] "seq2:100-1500"  "seq2:1000-2000"
table(bam$ex1.bam[[1]]$rname)
# 
# seq1 seq2 
#    0 1705
table(bam$ex1.bam[[2]]$rname)
# 
# seq1 seq2 
#    0  642
```

## session info

``` r
packageVersion("BiocVersion")
# [1] '3.20.0'
sessionInfo()
# R version 4.4.2 (2024-10-31)
# Platform: x86_64-apple-darwin20
# Running under: macOS Monterey 12.7.6
# 
# Matrix products: default
# BLAS:   /Library/Frameworks/R.framework/Versions/4.4-x86_64/Resources/lib/libRblas.0.dylib 
# LAPACK: /Library/Frameworks/R.framework/Versions/4.4-x86_64/Resources/lib/libRlapack.dylib;  LAPACK version 3.12.0
# 
# locale:
# [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
# 
# time zone: Europe/London
# tzcode source: internal
# 
# attached base packages:
# [1] stats4    stats     graphics  grDevices utils     datasets  methods  
# [8] base     
# 
# other attached packages:
# [1] Rsamtools_2.22.0     Biostrings_2.74.1    XVector_0.46.0      
# [4] GenomicRanges_1.58.0 GenomeInfoDb_1.42.3  IRanges_2.40.1      
# [7] S4Vectors_0.44.0     BiocGenerics_0.52.0 
# 
# loaded via a namespace (and not attached):
#  [1] vctrs_0.6.5             crayon_1.5.3            httr_1.4.7             
#  [4] cli_3.6.4               knitr_1.50              rlang_1.1.5            
#  [7] xfun_0.52               purrr_1.0.4             UCSC.utils_1.2.0       
# [10] jsonlite_2.0.0          htmltools_0.5.8.1       rmarkdown_2.29         
# [13] evaluate_1.0.3          bitops_1.0-9            fastmap_1.2.0          
# [16] lifecycle_1.0.4         yaml_2.3.10             compiler_4.4.2         
# [19] codetools_0.2-20        BiocParallel_1.40.1     rstudioapi_0.17.1      
# [22] digest_0.6.37           R6_2.6.1                parallel_4.4.2         
# [25] GenomeInfoDbData_1.2.13 magrittr_2.0.3          tools_4.4.2            
# [28] zlibbioc_1.52.0
```
