#############################################################################################################
#############################################################################################################

# foreach examples

#############################################################################################################
#############################################################################################################

require(foreach)
require(iterators)

#############################################################################################################

# Serial loops

# a simple standard for loop
N <- 10
x <- numeric(N) ; x
for(i in 1:N) x[i] <- i ; x

# the equivalent using foreach
x <- foreach(i=1:N) %do% i ; x

# notice that by default foreach returns a list
# more specifically it returns a list of the values of the last unassigned object in each loop
x <- foreach(i=1:N) %do% { y <- i ; 2*y } ; x
x <- foreach(i=1:N) %do% { y <- i ; 2*y ; 10*y } ; x

# you can change the class of the output objecct by using the .combine argument
x <- foreach(i=1:N, .combine='c') %do% i ; x

# alterntively you could use the .final argument which is called to the final result
x <- foreach(i=1:N, .final=unlist) %do% i ; x

# other options for .combine are 'cbind', 'rbind', '+' and '*'
x <- foreach(i=1:N) %do% rep(i,5) ; x
x <- foreach(i=1:N, .combine='+') %do% rep(i,5) ; x
x <- foreach(i=1:N, .combine='*') %do% rep(i,5) ; x
x <- foreach(i=1:N, .combine='cbind') %do% rep(i,5) ; x
x <- foreach(i=1:N, .combine='rbind') %do% rep(i,5) ; x

# A slightly more complicated example showing using the iter() function from the 'iterators' package
# calculate matrix column products
X <- matrix(runif(N*N), N) ; dim(X)
x <- apply(X, 2, prod) ; x
x <- foreach(i=iter(X, by='col'), .final=unlist) %do% prod(i) ; x
x <- foreach(i=iter(X, by='col'), .combine='c') %do% prod(i) ; x

# you can also no nested loops
x <- NULL
for(i in letters[1:3]) for(j in 1:3) x <- c(x,paste(i,j,sep="")) ; x
# two options with foreach:
# 1. merge using '%:%'
x <- foreach (i = letters[1:3], .combine = c) %:% foreach(j = 1:3, .combine = c) %do% paste(i, j, sep = "") ; x
# 2. nest foreach objects using '%do% '
foreach(i = letters[1:3], .combine = c) %do% {
    foreach(j = 1:3, .combine = c) %do% {
        paste(i, j, sep = "")
    }
}
# but you need to use braces in the second case (the net line of code wont work)
foreach(i = letters[1:3], .combine = c) %do% foreach(j = 1:3, .combine = c) %do% paste(j, i, sep = "")

# can also play with the .combine options 
x <- foreach (i = letters[1:3], .combine = cbind) %:% foreach(j = 1:3, .combine = c) %do% paste(i, j, sep = "") ; x
x <- foreach (i = letters[1:3], .combine = rbind) %:% foreach(j = 1:3, .combine = c) %do% paste(i, j, sep = "") ; x
x <- foreach (i = letters[1:3], .combine = rbind) %:% foreach(j = 1:3, .combine = rbind) %do% paste(i, j, sep = "") ; x


#############################################################################################################

# Parallel loops

# The main advantage of writing your loops using 'foreach' instead of 'for' is the option for parallelisation
# To parallelise a foreach loop you need to:
#   - load a package such as doSNOW (Simple Network Of Workstations)
#       - doSNOW provides a parallel backend for the %dopar% function (using Luke Tierney's snow package)
#       - in other words it's a user interface to help you execute the foreach loops in parallel
#   - replace %do% with %dopar%

# first use the 'detectCores' functin in the 'parallel' package to determine the number of CPU cores on your system
# (snow doesn't have a function that can do this)
require(parallel) 
nCores <- getOption("cl.cores", detectCores()) ; nCores
detach(package:parallel) # detach the parallel package (since some of the function names conflict with those in the doSNOW package)

# load doSNOW and initialize the cores
require(doSNOW) 
myCluster <- makeCluster(nCores) ; myCluster

# Here's a silly example - in each loop we will tell the computer to go to sleep for one second
require(rbenchmark)
nLoops <- 8
nSecs  <- 1
benchmark(for(i in 1:nLoops) Sys.sleep(nSecs),
          foreach(i=1:nLoops) %do% Sys.sleep(nSecs),
          foreach(i=1:nLoops) %dopar% Sys.sleep(nSecs),
          columns=c("test", "replications","elapsed", "relative"), order="relative", replications=1)

# What's going on here? The foreach with %dopar% is no faster than the foreach with %do%...
# Notice the warning message: executing %dopar% sequentially: no parallel backend registered 
# The problem is that you are still only using a single core
getDoParWorkers()
getDoParName()
getDoParVersion()

# Before you can make use of all the cores, you need to 'register' the SNOW parallel backend with the foreach package
registerDoSNOW(myCluster)
getDoParWorkers()
getDoParName()
getDoParVersion()

# Now try it again...
benchmark(for(i in 1:nLoops) Sys.sleep(nSecs),
          foreach(i=1:nLoops) %do% Sys.sleep(nSecs),
          foreach(i=1:nLoops) %dopar% Sys.sleep(nSecs),
          columns=c("test", "replications","elapsed", "relative"), order="relative", replications=1)
# That should have fixed it!

# Before you end the session you have to close the cluster
# otherwise the slave cores will stay open when you exit R and potentially slow down your computer
stopCluster(myCluster)

# you can also check at the start of a session that you don't have any open clusters
# but I've forgotten the function...


#############################################################################################################
#############################################################################################################

# Appendix - some problems with user-specified funtions

# a simple function
myFunction <- function(x) 2*x

# works with %do%
foreach(i=1:8) %do% myFunction(i)

# see if it works with %dopar%
require(parallel) ; nCores <- getOption("cl.cores", detectCores()) ; detach(package:parallel)
myCluster <- makeCluster(nCores)
registerDoSNOW(myCluster)

# myFunction doesn't appear to exist on the slave cores
clusterEvalQ(myCluster, exists("myFunction"))

# and it looks like it can't be evaluated on the other cores
clusterEvalQ(myCluster, myFunction(1))

# but the parallel form still seems to work...
foreach(i=1:8) %dopar% myFunction(i)


# What about a user-specified Rcpp function
require(inline)
require(Rcpp)
source("~/Resources/Applications/R/My functions/ColProds_Rcpp.r")

X <- matrix(1:9, 3) ; X
colProds_Rcpp(X)

# the %do% form works fine
foreach(i=1:8) %do% colProds_Rcpp(X)

# as before, neither colProds_Rcpp nor X appear to exist on the slave cores
clusterEvalQ(myCluster, exists("colProds_Rcpp"))
clusterEvalQ(myCluster, exists("X"))

# and, as before, colProds_Rcpp(X) can't be evaluated on the other cores
clusterEvalQ(myCluster, colProds_Rcpp(X))

# but now the parallel form doesn't work
foreach(i=1:8) %dopar% colProds_Rcpp(X)

# what if we export the function to all clusters
clusterExport(myCluster, "colProds_Rcpp")

# now it exists
clusterEvalQ(myCluster, exists("colProds_Rcpp"))

# but now it can't be evaluated because X can't be found
clusterEvalQ(myCluster, colProds_Rcpp(X))

# so let's export X as well
clusterExport(myCluster, "X")

# now X exists on all cores
clusterEvalQ(myCluster, exists("X"))

# but colProds_Rcpp(X) still can't be evaluated on the other cores
clusterEvalQ(myCluster, colProds_Rcpp(X))
foreach(i=1:8) %dopar% colProds_Rcpp(X)

# what if we load the Rcpp function directly onto all cores
clusterEvalQ(myCluster, source("~/Resources/Applications/R/My functions/ColProds_Rcpp.r"))

# now it CAN be evaluated on all cores
clusterEvalQ(myCluster, colProds_Rcpp(X))

# parLapply can use it
parLapply(myCluster, 1:8, function(x) colProds_Rcpp(X))

# BUT THE PARALLEL FOR STILL DOESN'T WORK!! 
foreach(i=1:8) %dopar% colProds_Rcpp(X)
# WHY NOT??
# maybe you need to save it in a package, e.g. using Rcpp.package.skeleton?

stopCluster(myCluster)


# CONCLUSION:
# - ONLY USE FOREACH IF NONE OF YOUR FUNCTIONS ARE RCPP FUNCTIONS
# - THE PARAPPLY FUNCTIONS DON'T SEEM TO SUFFER THE SAME PROBLEM, PROVIDED THE RCPP IS BUILT DIRECTLY ON EACH CORE
# - MAYBE THE GENERAL RULE HERE IS TO USE THE PARAPPLY FUNCTIONS INSTEAD OF FOREACH

#############################################################################################################
#############################################################################################################