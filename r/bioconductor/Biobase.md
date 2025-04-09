Biobase
================
2025-04-07

- [`ExpressionSet` class](#expressionset-class)
  - [`exprs` and `se.exprs`](#exprs-and-seexprs)
  - [`pData`](#pdata)
  - [`fData`](#fdata)
  - [subsetting](#subsetting)
  - [coercion](#coercion)
- [`AnnotatedDataFrame` class](#annotateddataframe-class)
- [session info](#session-info)

``` r
suppressPackageStartupMessages({
    library(Biobase)
})
```

``` r
openVignette(1) # An introduction to Biobase and ExpressionSets
openVignette(2) # esApply Introduction
openVignette(3) # Notes for eSet developers
openVignette(4) # Using the reshape function
openVignette(5) # Sweave User Manual
```

## `ExpressionSet` class

Contains three matrices

1.  expression data for multiple ‘features’ (typically genes) across
    multiple ‘samples’ (typically individuals)
2.  feature-level covariates (e.g. ?)
3.  sample-level covariates (e.g. age, gender)

``` r
data(sample.ExpressionSet)
example = updateObject(sample.ExpressionSet)
validObject(example)
# [1] TRUE
example
# ExpressionSet (storageMode: lockedEnvironment)
# assayData: 500 features, 26 samples 
#   element names: exprs, se.exprs 
# protocolData: none
# phenoData
#   sampleNames: A B ... Z (26 total)
#   varLabels: sex type score
#   varMetadata: labelDescription
# featureData: none
# experimentData: use 'experimentData(object)'
# Annotation: hgu95av2
```

``` r
class(example)
# [1] "ExpressionSet"
# attr(,"package")
# [1] "Biobase"
isS4(example)
# [1] TRUE
getClass("ExpressionSet") # can also use showClass
# Class "ExpressionSet" [package "Biobase"]
# 
# Slots:
#                                                                
# Name:      experimentData          assayData          phenoData
# Class:              MIAME          AssayData AnnotatedDataFrame
#                                                                
# Name:         featureData         annotation       protocolData
# Class: AnnotatedDataFrame          character AnnotatedDataFrame
#                          
# Name:   .__classVersion__
# Class:           Versions
# 
# Extends: 
# Class "eSet", directly
# Class "VersionedBiobase", by class "eSet", distance 2
# Class "Versioned", by class "eSet", distance 3
#findMethods("ExpressionSet") # getMethods is deprecated
```

``` r
experimentData(example)
# Experiment data
#   Experimenter name: Pierre Fermat 
#   Laboratory: Francis Galton Lab 
#   Contact information: pfermat@lab.not.exist 
#   Title: Smoking-Cancer Experiment 
#   URL: www.lab.not.exist 
#   PMIDs:  
# 
#   Abstract: A 8 word abstract is available. Use 'abstract' method.
#   notes:
#    notes:     
#       An example object of expression set (exprSet) class
abstract(example)
# [1] "An example object of expression set (ExpressionSet) class"
slotNames(example)
# [1] "experimentData"    "assayData"         "phenoData"        
# [4] "featureData"       "annotation"        "protocolData"     
# [7] ".__classVersion__"
```

### `exprs` and `se.exprs`

Access the expression and error measurements of assay data.

- rows = ‘features’ - e.g. genes
- columns = samples

``` r
class(exprs(example))
# [1] "matrix" "array"
dim(exprs(example))
# [1] 500  26
exprs(example)[1:5, 1:5]
#                        A         B        C        D        E
# AFFX-MurIL2_at  192.7420  85.75330 176.7570 135.5750 64.49390
# AFFX-MurIL10_at  97.1370 126.19600  77.9216  93.3713 24.39860
# AFFX-MurIL4_at   45.8192   8.83135  33.0632  28.7072  5.94492
# AFFX-MurFAS_at   22.5445   3.60093  14.6883  12.3397 36.86630
# AFFX-BioB-5_at   96.7875  30.43800  46.1271  70.9319 56.17440
```

But no `exprs.se` method for this class:

``` r
try(class(se.exprs(example)))
# Error : unable to find an inherited method for function 'se.exprs' for signature 'object = "ExpressionSet"'
```

Find help on `exprs`:

``` r
showMethods("exprs") # list all available methods
getMethod("exprs", "ExpressionSet") # to see the function definition
method?"exprs,ExpressionSet" # help on specific method
```

The `assayData` method is similar to `exprs` but returns a named list or
environment containing one or more matrices of equal dimension.

``` r
class(assayData(example))
# [1] "environment"
ls(envir = assayData(example))
# [1] "exprs"    "se.exprs"
```

``` r
class(assayData(example)$exprs)
# [1] "matrix" "array"
dim(assayData(example)$exprs)
# [1] 500  26
assayData(example)$exprs[1:5, 1:5]
#                        A         B        C        D        E
# AFFX-MurIL2_at  192.7420  85.75330 176.7570 135.5750 64.49390
# AFFX-MurIL10_at  97.1370 126.19600  77.9216  93.3713 24.39860
# AFFX-MurIL4_at   45.8192   8.83135  33.0632  28.7072  5.94492
# AFFX-MurFAS_at   22.5445   3.60093  14.6883  12.3397 36.86630
# AFFX-BioB-5_at   96.7875  30.43800  46.1271  70.9319 56.17440
```

``` r
class(assayData(example)$se.exprs)
# [1] "matrix" "array"
dim(assayData(example)$se.exprs)
# [1] 500  26
assayData(example)$se.exprs[1:5, 1:5]
#                    A    B    C    D    E
# AFFX-MurIL2_at  2.85 1.47 0.25 0.43 3.65
# AFFX-MurIL10_at 3.24 3.32 3.13 0.33 0.28
# AFFX-MurIL4_at  3.05 4.30 2.54 2.17 3.43
# AFFX-MurFAS_at  0.84 4.01 4.73 4.03 0.05
# AFFX-BioB-5_at  1.99 0.31 2.04 0.90 2.36
```

### `pData`

Access the phenotypic data (e.g., covariates) and meta-data (e.g.,
descriptions of covariates).

- rows = samples
- columns = sample-level variables

``` r
class(pData(example))
# [1] "data.frame"
dim(pData(example))
# [1] 26  3
pData(example)[1:5, ]
#      sex    type score
# A Female Control  0.75
# B   Male    Case  0.40
# C   Male Control  0.73
# D   Male    Case  0.42
# E Female    Case  0.93
```

``` r
nrow(pData(example)) == ncol(exprs(example))
# [1] TRUE
```

``` r
showMethods("pData")
# Function: pData (package Biobase)
# object="AnnotatedDataFrame"
# object="eSet"
# object="ExpressionSet"
#     (inherited from: object="eSet")
```

The `phenoData` method is similar to `pData` but returns an
`AnnotatedDataFrame`.

``` r
class(phenoData(example))
# [1] "AnnotatedDataFrame"
# attr(,"package")
# [1] "Biobase"
dim(phenoData(example))
#   sampleNames sampleColumns 
#            26             3
phenoData(example)[1:5, ]
# An object of class 'AnnotatedDataFrame'
#   sampleNames: A B ... E (5 total)
#   varLabels: sex type score
#   varMetadata: labelDescription
```

### `fData`

Access feature data (experiment specific information about features) and
feature meta-data (e.g., descriptions of feature covariates).

- rows = features

- columns = feature-level variables

- `fData()` returns a `data.frame`  

- `featureData()` returns a `DataFrame`

``` r
class(fData(example))
# [1] "data.frame"
dim(fData(example))
# [1] 500   0
```

``` r
nrow(fData(example)) == nrow(exprs(example))
# [1] TRUE
```

``` r
showMethods("fData")
# Function: fData (package Biobase)
# object="eSet"
# object="ExpressionSet"
#     (inherited from: object="eSet")
```

The `featureData` method is similar to `fData` but returns an
`AnnotatedDataFrame`.

``` r
class(featureData(example))
# [1] "AnnotatedDataFrame"
# attr(,"package")
# [1] "Biobase"
dim(featureData(example))
#   featureNames featureColumns 
#            500              0
```

### subsetting

``` r
head(featureNames(example))
# [1] "AFFX-MurIL2_at"  "AFFX-MurIL10_at" "AFFX-MurIL4_at"  "AFFX-MurFAS_at" 
# [5] "AFFX-BioB-5_at"  "AFFX-BioB-M_at"
head(sampleNames(example))
# [1] "A" "B" "C" "D" "E" "F"
```

``` r
example_subset1 = example[1:5, 1:3]
dim(exprs(example_subset1))
# [1] 5 3
dim(pData(example_subset1))
# [1] 3 3
dim(fData(example_subset1))
# [1] 5 0
```

``` r
example_subset2 = example[featureNames(example)[1:5], sampleNames(example)[1:3]]
dim(exprs(example_subset2))
# [1] 5 3
dim(pData(example_subset2))
# [1] 3 3
dim(fData(example_subset2))
# [1] 5 0
```

Subset by `pData` covariates

``` r
example$sex
#  [1] Female Male   Male   Male   Female Male   Male   Male   Female Male  
# [11] Male   Female Male   Male   Female Female Female Male   Male   Female
# [21] Male   Female Male   Male   Female Female
# Levels: Female Male
example$type
#  [1] Control Case    Control Case    Case    Control Case    Case    Case   
# [10] Control Case    Control Case    Case    Case    Control Case    Control
# [19] Case    Case    Control Control Control Control Case    Case   
# Levels: Case Control
example$score
#  [1] 0.75 0.40 0.73 0.42 0.93 0.22 0.96 0.79 0.37 0.63 0.26 0.36 0.41 0.80 0.10
# [16] 0.41 0.16 0.72 0.17 0.74 0.35 0.77 0.27 0.98 0.94 0.32
```

``` r
# samples with above-average 'score' in phenoData
example_subset3 = example[, example$score > mean(example$score)]
dim(exprs(example_subset3))
# [1] 500  12
dim(pData(example_subset3))
# [1] 12  3
dim(fData(example_subset3))
# [1] 500   0
```

### coercion

``` r
as.data.frame(example_subset1)
#   AFFX.MurIL2_at AFFX.MurIL10_at AFFX.MurIL4_at AFFX.MurFAS_at AFFX.BioB.5_at
# A       192.7420         97.1370       45.81920       22.54450        96.7875
# B        85.7533        126.1960        8.83135        3.60093        30.4380
# C       176.7570         77.9216       33.06320       14.68830        46.1271
#      sex    type score
# A Female Control  0.75
# B   Male    Case  0.40
# C   Male Control  0.73
```

## `AnnotatedDataFrame` class

*TODO*

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
# [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
# [1] Biobase_2.66.0      BiocGenerics_0.52.0 conflicted_1.2.0   
# 
# loaded via a namespace (and not attached):
#  [1] digest_0.6.37     fastmap_1.2.0     xfun_0.52         cachem_1.1.0     
#  [5] knitr_1.50        memoise_2.0.1     htmltools_0.5.8.1 rmarkdown_2.29   
#  [9] cli_3.6.4         compiler_4.4.2    rstudioapi_0.17.1 tools_4.4.2      
# [13] evaluate_1.0.3    yaml_2.3.10       rlang_1.1.5
```
