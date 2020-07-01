################################################################################
################################################################################

# Parallel processing with snow

################################################################################
################################################################################

# useful webpage: http://www.sfu.ca/~sblay/R/snow.html

################################################################################
################################################################################

require(parallel)
require(rbenchmark)

# How many cores do you have?
nCores <- getOption("cl.cores", detectCores()) ; nCores

# initialise and register the cores
myCluster <- makeCluster(nCores) ; myCluster

################################################################################

# a dumb example
sapply(1:8, function(x) Sys.sleep(0.1))

# same thing with parApply
parLapply(myCluster, 1:8, function(x) Sys.sleep(0.1))

# compare speed
benchmark(sapply(1:8, function(x) Sys.sleep(0.1)),
          parLapply(myCluster, 1:8, function(x) Sys.sleep(0.1)),
          columns=c("test", "replications","elapsed", "relative"), order="relative", replications=1)

################################################################################

# better example - checking the coverage of lm confidence intervals

# this particular example isn't necessarily faster in parallel
# but it illustrates how you could set something up

sigma <- 1
b0 <- 0
b1 <- 1
n <- 100

# export the objects to all the cores
clusterExport(myCluster, c("sigma","b0","b1","n"))

# or
#clusterExport(myCluster, ls())

# load necessary packages on all the cores
#clusterEvalQ(myCluster, require(mvtnorm))

B <- 1000
results <- parSapply(myCluster, 1:B, function(x){
    x <- seq(0,10,length=n)
    y <- rnorm(n, b0+b1*x, sigma)
    model <- lm(y~x)
    CIs <- confint(model)
    result <- c("b0" = b0 >= CIs["(Intercept)","2.5 %"] & b0 <= CIs["(Intercept)","97.5 %"],
                "b1" = b1 >= CIs["x","2.5 %"] & b1 <= CIs["x","97.5 %"])
    # the last thing gets returned
    result
})

head(t(results))
apply(results,1,mean)

# Before you end the session you have to close the cluster
# otherwise the slave cores will stay open when you exit R and potentially slow down your computer
stopCluster(myCluster)

#####################################################################################
#####################################################################################