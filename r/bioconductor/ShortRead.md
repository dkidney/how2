ShortRead
================
2025-04-07

- [`readFastq`](#readfastq)
- [`FastqFile`](#fastqfile)
- [session info](#session-info)

``` r
suppressPackageStartupMessages({
    library(ShortRead)
})
# Warning: package 'BiocParallel' was built under R version 4.4.3
```

## `readFastq`

``` r
(reads = readFastq(system.file("reads", "wt_1_f.fastq.gz", package = "yeastRNASeq")))
# class: ShortReadQ
# length: 1000000 reads; width: 36 cycles
length(reads)
# [1] 1000000
```

Accessor functions:

``` r
sread(reads)[1:2]
# DNAStringSet object of length 2:
#     width seq
# [1]    36 CAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
# [2]    36 ACGCTATCGGTCTCTCGCCAATATTTAGCTTTAGAT
quality(reads)[1:2]
# class: SFastqQuality
# quality:
# BStringSet object of length 2:
#     width seq
# [1]    36 Uh@[hhheYTdchhhShhaWhJhhhhhhVhhOh^\K
# [2]    36 hhhhhhhhhhhhhhhhhhhbEhWhhhMf\hhhSEOh
id(reads)[1:2]
# BStringSet object of length 2:
#     width seq
# [1]    28 GA-EAS46_1_209DH:5:1:889:471
# [2]    28 GA-EAS46_1_209DH:5:1:744:748
```

Coerce to matrix format:

``` r
dim(as(sread(reads), 'matrix'))
# [1] 1000000      36
as(sread(reads), 'matrix')[1:2, 1:10]
#      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
# [1,] "C"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  "A"  
# [2,] "A"  "C"  "G"  "C"  "T"  "A"  "T"  "C"  "G"  "G"
as(sread(reads), 'matrix')[1:10, 5] # get the 5th base for the first 10 reads
#  [1] "A" "T" "T" "G" "T" "T" "A" "G" "G" "A"
```

``` r
dim(as(quality(reads), 'matrix'))
# [1] 1000000      36
as(quality(reads), 'matrix')[1:2, 1:10] # converts quality scores into an integer
#      [,1] [,2] [,3] [,4] [,5] [,6] [,7] [,8] [,9] [,10]
# [1,]   21   40    0   27   40   40   40   37   25    20
# [2,]   40   40   40   40   40   40   40   40   40    40
```

## `FastqFile`

For bigger files - e.g. something you can iterate over to avoid reading
it all into memory.

``` r
(fqfile = FastqFile(system.file("reads", "wt_1_f.fastq.gz", package = "yeastRNASeq")))
# class: FastqFile 
# path: /Library/Frameworks/R.framework/Versions/4.4-x86_64/Res.../wt_1_f.fastq.gz
# isOpen: FALSE
(reads = readFastq(fqfile)) # reads all into memory?
# class: ShortReadQ
# length: 1000000 reads; width: 36 cycles
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
#  [1] ShortRead_1.64.0            GenomicAlignments_1.42.0   
#  [3] SummarizedExperiment_1.36.0 Biobase_2.66.0             
#  [5] MatrixGenerics_1.18.1       matrixStats_1.5.0          
#  [7] Rsamtools_2.22.0            GenomicRanges_1.58.0       
#  [9] Biostrings_2.74.1           GenomeInfoDb_1.42.3        
# [11] XVector_0.46.0              IRanges_2.40.1             
# [13] S4Vectors_0.44.0            BiocParallel_1.40.1        
# [15] BiocGenerics_0.52.0        
# 
# loaded via a namespace (and not attached):
#  [1] Matrix_1.7-3            jsonlite_2.0.0          compiler_4.4.2         
#  [4] crayon_1.5.3            Rcpp_1.0.14             bitops_1.0-9           
#  [7] parallel_4.4.2          png_0.1-8               yaml_2.3.10            
# [10] fastmap_1.2.0           lattice_0.22-7          deldir_2.0-4           
# [13] R6_2.6.1                S4Arrays_1.6.0          latticeExtra_0.6-30    
# [16] knitr_1.50              DelayedArray_0.32.0     interp_1.1-6           
# [19] GenomeInfoDbData_1.2.13 RColorBrewer_1.1-3      rlang_1.1.5            
# [22] hwriter_1.3.2.1         pwalign_1.2.0           xfun_0.52              
# [25] SparseArray_1.6.2       cli_3.6.4               zlibbioc_1.52.0        
# [28] digest_0.6.37           grid_4.4.2              rstudioapi_0.17.1      
# [31] evaluate_1.0.3          codetools_0.2-20        abind_1.4-8            
# [34] rmarkdown_2.29          httr_1.4.7              jpeg_0.1-11            
# [37] tools_4.4.2             htmltools_0.5.8.1       UCSC.utils_1.2.0
```
