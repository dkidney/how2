Biobase
================
2025-04-06

- [`AnnotatedDataFrame` class](#annotateddataframe-class)
- [`ExpressionSet` class](#expressionset-class)
  - [`exprs`](#exprs)
  - [`pData`](#pdata)
  - [`fData`](#fdata)

``` r
suppressPackageStartupMessages({
    library(Biobase)
})
```

## `AnnotatedDataFrame` class

## `ExpressionSet` class

``` r
data(sample.ExpressionSet)
updateObject(sample.ExpressionSet)
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
experimentData(sample.ExpressionSet)
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
abstract(sample.ExpressionSet)
# [1] "An example object of expression set (ExpressionSet) class"
```

``` r
class(sample.ExpressionSet)
# [1] "ExpressionSet"
# attr(,"package")
# [1] "Biobase"
isS4(sample.ExpressionSet)
# [1] TRUE
slotNames(sample.ExpressionSet)
# [1] "experimentData"    "assayData"         "phenoData"        
# [4] "featureData"       "annotation"        "protocolData"     
# [7] ".__classVersion__"
```

### `exprs`

- rows = features - e.g. genes
- columns = samples

``` r
class(exprs(sample.ExpressionSet))
# [1] "matrix" "array"
dim(exprs(sample.ExpressionSet))
# [1] 500  26
exprs(sample.ExpressionSet)[1:5, 1:5]
#                        A         B        C        D        E
# AFFX-MurIL2_at  192.7420  85.75330 176.7570 135.5750 64.49390
# AFFX-MurIL10_at  97.1370 126.19600  77.9216  93.3713 24.39860
# AFFX-MurIL4_at   45.8192   8.83135  33.0632  28.7072  5.94492
# AFFX-MurFAS_at   22.5445   3.60093  14.6883  12.3397 36.86630
# AFFX-BioB-5_at   96.7875  30.43800  46.1271  70.9319 56.17440
```

``` r
class(assayData(sample.ExpressionSet)$exprs)
# [1] "matrix" "array"
dim(assayData(sample.ExpressionSet)$exprs)
# [1] 500  26
assayData(sample.ExpressionSet)$exprs[1:5, 1:5]
#                        A         B        C        D        E
# AFFX-MurIL2_at  192.7420  85.75330 176.7570 135.5750 64.49390
# AFFX-MurIL10_at  97.1370 126.19600  77.9216  93.3713 24.39860
# AFFX-MurIL4_at   45.8192   8.83135  33.0632  28.7072  5.94492
# AFFX-MurFAS_at   22.5445   3.60093  14.6883  12.3397 36.86630
# AFFX-BioB-5_at   96.7875  30.43800  46.1271  70.9319 56.17440
```

### `pData`

- rows = samples
- columns = sample-level variables

``` r
class(pData(sample.ExpressionSet))
# [1] "data.frame"
dim(pData(sample.ExpressionSet))
# [1] 26  3
pData(sample.ExpressionSet)[1:5, ]
#      sex    type score
# A Female Control  0.75
# B   Male    Case  0.40
# C   Male Control  0.73
# D   Male    Case  0.42
# E Female    Case  0.93
```

``` r
class(phenoData(sample.ExpressionSet))
# [1] "AnnotatedDataFrame"
# attr(,"package")
# [1] "Biobase"
dim(phenoData(sample.ExpressionSet))
#   sampleNames sampleColumns 
#            26             3
phenoData(sample.ExpressionSet)[1:5, ]
# An object of class 'AnnotatedDataFrame'
#   sampleNames: A B ... E (5 total)
#   varLabels: sex type score
#   varMetadata: labelDescription
```

### `fData`

- rows = features

- columns = feature-level variables

- `fData()` returns a `data.frame`  

- `featureData()` returns a `DataFrame`

``` r
class(fData(sample.ExpressionSet))
# [1] "data.frame"
dim(fData(sample.ExpressionSet))
# [1] 500   0
```

``` r
class(featureData(sample.ExpressionSet))
# [1] "AnnotatedDataFrame"
# attr(,"package")
# [1] "Biobase"
dim(featureData(sample.ExpressionSet))
#   featureNames featureColumns 
#            500              0
```

    dim(exprs(eset)) # 500  26
    classVersion

    assayData
    experimentData
    featureData

    featureNames(eset)[1:10]
    sampleNames(eset)[1:5]
    experimentData(eset)
    phenoData

    # subset: first 10 genes, samples 2, 4, and 10
    expressionSet <- eset[1:10,c(2,4,10)]

    # named features and their expression levels
    subset <- expressionSet[c("AFFX-BioC-3_at","AFFX-BioDn-5_at"),]
    exprs(subset)

    # samples with above-average 'score' in phenoData
    highScores <- expressionSet$score > mean(expressionSet$score)
    expressionSet[,highScores]

    # (automatically) coerce to data.frame
    lm(score~AFFX.BioDn.5_at + AFFX.BioC.3_at, data=subset)
