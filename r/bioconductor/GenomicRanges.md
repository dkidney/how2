GenomicRanges
================
2025-04-07

- [links](#links)
- [general](#general)
- [`GRanges` class](#granges-class)
  - [`findOverlaps`](#findoverlaps)
- [`GRangesList` class](#grangeslist-class)
- [session info](#session-info)

``` r
suppressPackageStartupMessages({
    library(IRanges)
    library(GenomicRanges)
})
```

## links

- <https://www.bioconductor.org/packages/devel/bioc/vignettes/GenomicRanges/inst/doc/GenomicRangesIntroduction.html>  
- <https://kasperdanielhansen.github.io/genbioconductor/html/GenomicRanges_GRanges.html>  
- <https://kasperdanielhansen.github.io/genbioconductor/html/GenomicRanges_GRanges_Usage.html>  
- <https://kasperdanielhansen.github.io/genbioconductor/html/GenomicRanges_seqinfo.html>

## general

*TODO*

## `GRanges` class

### `findOverlaps`

``` r
showMethods("findOverlaps")
getMethod("findOverlaps", signature(query="GenomicRanges", subject="GenomicRanges"))
```

``` r
args("findOverlaps")
# function (query, subject, maxgap = -1L, minoverlap = 0L, type = c("any", 
#     "start", "end", "within", "equal"), select = c("all", "first", 
#     "last", "arbitrary"), ...) 
# NULL
```

## `GRangesList` class

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
# [1] GenomicRanges_1.58.0 GenomeInfoDb_1.42.3  IRanges_2.40.1      
# [4] S4Vectors_0.44.0     BiocGenerics_0.52.0 
# 
# loaded via a namespace (and not attached):
#  [1] digest_0.6.37           R6_2.6.1                zlibbioc_1.52.0        
#  [4] fastmap_1.2.0           xfun_0.52               GenomeInfoDbData_1.2.13
#  [7] XVector_0.46.0          knitr_1.50              UCSC.utils_1.2.0       
# [10] htmltools_0.5.8.1       rmarkdown_2.29          cli_3.6.4              
# [13] compiler_4.4.2          httr_1.4.7              rstudioapi_0.17.1      
# [16] tools_4.4.2             evaluate_1.0.3          yaml_2.3.10            
# [19] jsonlite_2.0.0          rlang_1.1.5
```
