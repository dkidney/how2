IRanges
================
2025-04-07

- [`IRanges` class](#iranges-class)

``` r
suppressPackageStartupMessages({
    library(IRanges)
})
```

<https://kasperdanielhansen.github.io/genbioconductor/html/IRanges_Basic.html>

    # construct from scratch
    (ir1 = IRanges::IRanges(start = c(1,3,5), end = c(3,5,7)))
    # IRanges object with 3 ranges and 0 metadata columns:
    #           start       end     width
    #       <integer> <integer> <integer>
    #   [1]         1         3         3
    #   [2]         3         5         3
    #   [3]         5         7         3
    class(ir1) # IRanges
    head(ir1)
    tail(ir1)

    length(ir1) # 3
    ir1[1]
    # IRanges object with 1 range and 0 metadata columns:
    #         start       end     width
    #     <integer> <integer> <integer>
    #   a         1         3         3
    ir1[1:2]
    # IRanges object with 2 ranges and 0 metadata columns:
    #         start       end     width
    #     <integer> <integer> <integer>
    #   a         1         3         3
    #   b         3         5         3

    # same as ir1
    (ir2 = IRanges::IRanges(start = c(1,3,5), width = 3))
    # IRanges object with 3 ranges and 0 metadata columns:
    #           start       end     width
    #       <integer> <integer> <integer>
    #   [1]         1         3         3
    #   [2]         3         5         3
    #   [3]         5         7         3
    ir1 == ir2 # TRUE TRUE TRUE
    all(ir1 == ir2) # TRUE
    all.equal(ir1, ir2) # TRUE

    names(ir1) # NULL
    names(ir1) = c('a', 'b', 'c')
    names(ir1) # "a" "b" "c"
    ir1
    # IRanges object with 3 ranges and 0 metadata columns:
    #         start       end     width
    #     <integer> <integer> <integer>
    #   a         1         3         3
    #   b         3         5         3
    #   c         5         7         3
    ir1[c('a', 'b')]
    # IRanges object with 2 ranges and 0 metadata columns:
    #         start       end     width
    #     <integer> <integer> <integer>
    #   a         1         3         3
    #   b         3         5         3

    length(ir1) # 3
    IRanges::start(ir1) # 3 5 7
    IRanges::end(ir1) # 3 5 7
    IRanges::width(ir1) # 3 3 3

    IRanges::width(ir1) = 4
    ir1
    # IRanges object with 3 ranges and 0 metadata columns:
    #           start       end     width
    #       <integer> <integer> <integer>
    #   [1]         1         4         4
    #   [2]         3         6         4
    #   [3]         5         8         4

    IRanges::countOverlaps(ir1, ir2)
    # a b c
    # 2 3 2
    IRanges::findOverlaps(ir1, ir2)
    # Hits object with 7 hits and 0 metadata columns:
    #       queryHits subjectHits
    #       <integer>   <integer>
    #   [1]         1           1
    #   [2]         1           2
    #   [3]         2           1
    #   [4]         2           2
    #   [5]         2           3
    #   [6]         3           2
    #   [7]         3           3
    #   -------
    #   queryLength: 3 / subjectLength: 3

    names(ir2) = c('x', 'y', 'z')
    c(ir1, ir2)
    # IRanges object with 6 ranges and 0 metadata columns:
    #         start       end     width
    #     <integer> <integer> <integer>
    #   a         1         3         3
    #   b         3         5         3
    #   c         5         7         3
    #   x         1         3         3
    #   y         3         5         3
    #   z         5         7         3

    IRanges::reduce(ir1) # unions overlapping ranges (including if the end of one = the start of another)
    # returns a 'normalised' object = a minimal representation where each integer only occurs in a single range
    # IRanges object with 1 range and 0 metadata columns:
    #           start       end     width
    #       <integer> <integer> <integer>
    #   [1]         1         7         7

    IRanges::disjoin(ir1) # sort of the opposite of reduce
    # IRanges object with 5 ranges and 0 metadata columns:
    #           start       end     width
    #       <integer> <integer> <integer>
    #   [1]         1         2         2
    #   [2]         3         3         1
    #   [3]         4         4         1
    #   [4]         5         5         1
    #   [5]         6         7         2

## `IRanges` class

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
# [1] IRanges_2.40.1      S4Vectors_0.44.0    BiocGenerics_0.52.0
# 
# loaded via a namespace (and not attached):
#  [1] compiler_4.4.2    fastmap_1.2.0     cli_3.6.4         tools_4.4.2      
#  [5] htmltools_0.5.8.1 rstudioapi_0.17.1 yaml_2.3.10       rmarkdown_2.29   
#  [9] knitr_1.50        xfun_0.52         digest_0.6.37     rlang_1.1.5      
# [13] evaluate_1.0.3
```
