Matrices
================

  - [Positive semi-definite](#positive-semi-definite)
  - [Inverse](#inverse)
  - [Inverse square root](#inverse-square-root)
  - [LDL](#ldl)
  - [Chol](#chol)
  - [QR](#qr)
  - [Variance-correlation](#variance-correlation)

-----

## Positive semi-definite

-----

## Inverse

``` r
n <- 5
A <- matrix(0.2, ncol = n, nrow = n)
diag(A) <- 1
A
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]  1.0  0.2  0.2  0.2  0.2
    ## [2,]  0.2  1.0  0.2  0.2  0.2
    ## [3,]  0.2  0.2  1.0  0.2  0.2
    ## [4,]  0.2  0.2  0.2  1.0  0.2
    ## [5,]  0.2  0.2  0.2  0.2  1.0

``` r
A_inv <- solve(A)
round(A %*% A_inv, 10)
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]    1    0    0    0    0
    ## [2,]    0    1    0    0    0
    ## [3,]    0    0    1    0    0
    ## [4,]    0    0    0    1    0
    ## [5,]    0    0    0    0    1

-----

## Inverse square root

``` r
n <- 5
A <- matrix(0.2, ncol = n, nrow = n)
diag(A) <- 1
A
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]  1.0  0.2  0.2  0.2  0.2
    ## [2,]  0.2  1.0  0.2  0.2  0.2
    ## [3,]  0.2  0.2  1.0  0.2  0.2
    ## [4,]  0.2  0.2  0.2  1.0  0.2
    ## [5,]  0.2  0.2  0.2  0.2  1.0

``` r
inv_sqrt_mat <- function(x) {
  E <- eigen(x)
  if (!all(E$values > 0)) {
    stop("Matric must be positive semi-definite")
  }
  x_sqrt <- E$vectors %*% diag(sqrt(E$values)) %*% t(E$vectors)
  solve(x_sqrt)
}
```

``` r
A_inv <- inv_sqrt_mat(A)
A_inv
```

    ##            [,1]       [,2]       [,3]       [,4]       [,5]
    ## [1,]  1.0434984 -0.0745356 -0.0745356 -0.0745356 -0.0745356
    ## [2,] -0.0745356  1.0434984 -0.0745356 -0.0745356 -0.0745356
    ## [3,] -0.0745356 -0.0745356  1.0434984 -0.0745356 -0.0745356
    ## [4,] -0.0745356 -0.0745356 -0.0745356  1.0434984 -0.0745356
    ## [5,] -0.0745356 -0.0745356 -0.0745356 -0.0745356  1.0434984

``` r
A %*% A_inv
A %*% t(A_inv)
t(A) %*% A_inv
t(A) %*% t(A_inv)
```

-----

## LDL

-----

## Chol

-----

## QR

-----

## Variance-correlation

``` r
n <- 5
sigma <- sqrt(2)
corr <- 0.5
var_mat <- diag(n) * sigma^2
var_mat
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]    2    0    0    0    0
    ## [2,]    0    2    0    0    0
    ## [3,]    0    0    2    0    0
    ## [4,]    0    0    0    2    0
    ## [5,]    0    0    0    0    2

``` r
cor_mat <- matrix(corr, ncol = n, nrow = n)
diag(cor_mat) <- 1
cor_mat
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]  1.0  0.5  0.5  0.5  0.5
    ## [2,]  0.5  1.0  0.5  0.5  0.5
    ## [3,]  0.5  0.5  1.0  0.5  0.5
    ## [4,]  0.5  0.5  0.5  1.0  0.5
    ## [5,]  0.5  0.5  0.5  0.5  1.0

``` r
cov_mat <- sqrt(var_mat) %*% cor_mat %*% sqrt(var_mat)
cov_mat
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]    2    1    1    1    1
    ## [2,]    1    2    1    1    1
    ## [3,]    1    1    2    1    1
    ## [4,]    1    1    1    2    1
    ## [5,]    1    1    1    1    2

``` r
identical(cor_mat, stats::cov2cor(cov_mat))
```

    ## [1] TRUE
