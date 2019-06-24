

library(data.table)
library(abind)
library(plyr)
library(rbenchmark)
library(Rcpp)


# dataframes --------------------------------------------------------------

x = lapply(1:10, function(i) as.data.frame(matrix(i,10,10)))

y = do.call(rbind, x)
class(y) ; head(y) ; dim(y)
    
z = as.data.frame(abind(x, along = 1)) 
class(z) ; head(z) ; dim(z)
identical(y,z)

z = do.call(rbind.fill, x)
class(z) ; head(z) ; dim(z)
identical(y,z)

z = as.data.frame(rbindlist(x))
class(z) ; head(z) ; dim(z)
identical(y,z)


# benchmark

x = lapply(1:100, function(i) as.data.frame(matrix(i,10,10)))

benchmark(
    do.call(rbind, x),
    as.data.frame(abind(x, along = 1)),
    do.call(rbind.fill, x),
    as.data.frame(rbindlist(x)),
    columns = c("test", "replications", "elapsed", "relative"), 
    order = "relative", 
    replications = 100, 
    relative = "elapsed")


# matrices ----------------------------------------------------------------

x = lapply(1:10, function(i) matrix(1,10,10))

y = do.call(rbind, x)
class(y) ; head(y) ; dim(y)

z = abind(x, along = 1)
class(z) ; head(z) ; dim(z)

identical(y,z)

z = as.matrix(as.data.frame(data.table::rbindlist(lapply(x, as.data.frame))))
class(z) ; head(z) ; dim(z)

identical(y,z)


# benchmark

x = lapply(1:100, function(i) matrix(i,10,10))

benchmark(
    do.call(rbind, x),
    abind(x, along = 1),
    as.matrix(as.data.frame(data.table::rbindlist(lapply(x, as.data.frame)))),
    columns = c("test", "replications", "elapsed", "relative"), 
    order = "relative", 
    replications = 100, 
    relative = "elapsed")

