########################################################################################################
# examples using the snow package
########################################################################################################

# useful webpage: http://www.sfu.ca/~sblay/R/snow.html

require(doSNOW)
require(parallel) # need this for the detectCores function
#require(rlecuyer) # need this for the clusterSetupRNG function

#clusterSetupRNG(cl) # sets different random numbers on each cluster node

nCores <- getOption("cl.cores", detectCores()) ; nCores
#detach(package:parallel)
cl <- makeCluster(nCores) ; cl

registerDoSNOW(cl) # I think this is needed for foreach 

########################################################################################################
# clusterCall(cl, fun, x)

# asks each worker process to call function "fun" with argument "x" and returns a list of the results

# call the function runif(3) on each cluster node
clusterCall(cl, runif, 3)

# clean up both cluster nodes
clusterCall(cl, gc)

# get the names of the cluster nodes
clusterCall(cl, function(cl) Sys.info()[c("nodename")])

########################################################################################################
# clusterEvalQ

# load the boot package on each cluster node
clusterEvalQ(cl, require(boot)) 

########################################################################################################
# parMM - matrix multiplication

n <- 10
X <- matrix(rnorm(n*n),n) ; dim(X)
X %*% X
parMM(cl, X, X)

n <- 1000
X <- matrix(rnorm(n*n),n) ; dim(X)
system.time(Y <- X %*% X)
system.time(Z <- parMM(cl, X, X))
all.equal(Y,Z)

########################################################################################################
# parApply

# good for some functions
# the summary function for example is a bit of a pain to use with foreach, since it returns a table and tables are difficult to work with 
# the sapply function however is quite clever and can deal with things like the summary function quite easily
n <- 10
X <- matrix(rnorm(n*n),n) ; dim(X)
#clusterExport(cl,"X")
apply(X, 1, summary)
parApply(cl, X, 1, summary)

n <- 1000
X <- matrix(rnorm(n*n),n) ; dim(X)
#clusterExport(cl,"X")
system.time(Y <-apply(X, 1, summary))
system.time(Z <-parApply(cl, X, 1, summary))
all.equal(Y,Z)

# not so good for others
n <- 10
X <- matrix(rnorm(n*n),n) ; dim(X)
#clusterExport(cl,"X")
apply(X, 1, sum)
parApply(cl, X, 1, sum)

n <- 1000
X <- matrix(rnorm(n*n),n) ; dim(X)
#clusterExport(cl,"X")
system.time(Y <-apply(X, 1, sum))
system.time(Z <-parApply(cl, X, 1, sum))
all.equal(Y,Z)

# see also parRapply and parCapply

########################################################################################################
# parSapply

# simple example
N <- 10
sqrt(1:N)
sapply(1:N, sqrt)
unlist(clusterApply(cl, 1:N, sqrt))
unlist(parLapply(cl, 1:N, sqrt))
parSapply(cl, 1:N, sqrt)

# performance
N <- 10000
system.time(sqrt(1:N))
system.time(sapply(1:N, sqrt))
system.time(unlist(clusterApply(cl, 1:N, sqrt)))
system.time(unlist(parLapply(cl, 1:N, sqrt)))
system.time(parSapply(cl, 1:N, sqrt))

########################################################################################################
# clusterApply

n <- 4
X <- matrix(rnorm(n*n),n) ; dim(X)
# split X into parts and run each part on a separate node
idX <- clusterSplit(cl, 1:nrow(X)) ; str(idX)
Xsplt <- lapply(idX, function(row) X[row,]) ; str(Xsplt)
X
Xsplt[[1]]
Xsplt[[2]]
do.call(cbind, clusterApply(cl, Xsplt, function(x) apply(x, 1, summary)))
do.call(cbind, clusterApplyLB(cl, Xsplt, function(x) apply(x, 1, summary)))
parApply(cl, X, 1, summary)
apply(X, 1, summary)

n <- 1000
X <- matrix(rnorm(n*n),n) ; dim(X)
system.time({
    idX <- clusterSplit(cl, 1:nrow(X)) 
    Xsplt <- lapply(idX, function(row) X[row,]) 
    Y1 <- do.call(cbind, clusterApply(cl, Xsplt, function(x) apply(x, 1, summary)))
    do.call(cbind, clusterApplyLB(cl, Xsplt, function(x) apply(x, 1, summary)))
})
system.time({
    idX <- clusterSplit(cl, 1:nrow(X)) 
    Xsplt <- lapply(idX, function(row) X[row,]) 
    Y2 <- do.call(cbind, clusterApplyLB(cl, Xsplt, function(x) apply(x, 1, summary)))
})
system.time(Y3 <- parApply(cl, X, 1, summary))
system.time(Y4 <-apply(X, 1, summary))
all.equal(Y1,Y2,Y3,Y4)

########################################################################################################

stopCluster(cl)

########################################################################################################
########################################################################################################
