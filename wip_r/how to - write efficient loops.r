require(rbenchmark)

################################################################################
################################################################################

# Matrices

n <- 2500

A <- matrix(rnorm(n*n), n) ; dim(A)

# rows first - slower in R (faster in C)
f1 <- function() { sum <- 0 ; for(row in 1:n) for(col in 1:n) sum <- sum + A[row, col] }

# columns first - faster in R (slower in C)
f2 <- function() { sum <- 0 ; for(col in 1:n) for(row in 1:n) sum <- sum + A[row, col] }

print(benchmark(f1(), f2(),
                columns = c("test", "replications", "elapsed", "relative"), 
                order = "relative", replications = 10)) ; flush.console()

################################################################################
################################################################################

# Arrays

n <- 200

A <- array(rnorm(n*n*n), dim=c(n,n,n))

dim(A)

# row, col, slice - slowest ?
f1 <- function() { sum <- 0 ; for(row in 1:n) for(col in 1:n) for(slice in 1:n) sum <- sum + A[row, col, slice] }

# row, slice, col
f2 <- function() { sum <- 0 ; for(row in 1:n) for(slice in 1:n) for(col in 1:n) sum <- sum + A[row, col, slice] }

# col, row, slice
f3 <- function() { sum <- 0 ; for(col in 1:n) for(row in 1:n) for(slice in 1:n) sum <- sum + A[row, col, slice] }

# col, slice, row
f4 <- function() { sum <- 0 ; for(col in 1:n) for(slice in 1:n) for(row in 1:n) sum <- sum + A[row, col, slice] }

# slice, row, col
f5 <- function() { sum <- 0 ; for(slice in 1:n) for(row in 1:n) for(col in 1:n) sum <- sum + A[row, col, slice] }

# slice, col, row - fastest ?
f6 <- function() { sum <- 0 ; for(slice in 1:n) for(col in 1:n) for(row in 1:n) sum <- sum + A[row, col, slice] }

print(benchmark(f1(), f2(), f3(), f4(), f5(), f6(),
                columns = c("test", "replications", "elapsed", "relative"), 
                order = "relative", replications = 10))

################################################################################
################################################################################