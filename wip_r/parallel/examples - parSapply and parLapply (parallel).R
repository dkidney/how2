################################################################################
################################################################################

# Examples - parallel package

################################################################################
################################################################################

# an arbitrary function 

myFunc <- function(n = 1000000){

    x <- rnorm(n)

    return(c(min=min(x), mean=mean(x), max= max(x)))
    
}

system.time(
    
    results <- myFunc()
    
)["elapsed"]

results

#-------------------------------------------------------------------------------

# a simple for loop

nloops <- 8

results <- vector("list", nloops)

system.time(
    
    for(i in 1:nloops) results[[i]] <- myFunc()

)["elapsed"]

results

#-------------------------------------------------------------------------------

# the same thing with lapply

system.time(
    
    results <- lapply(1:nloops, function(i){
        
        myFunc()
        
    })
    
)["elapsed"]

results

#-------------------------------------------------------------------------------

# the same thing with parLapply

require(parallel)

nCores <- getOption("cl.cores", detectCores()) ; nCores # counts the number of cores you have

myCluster <- makeCluster(nCores) ; myCluster # intitialise the cluster

clusterExport(myCluster, "myFunc") # make sure all nodes have the function in the workspace

system.time(

    results <- parLapply(myCluster, 1:nloops, function(i){
        
        myFunc()
        
    })

)["elapsed"]

results

stopCluster(myCluster) # unintitialise the cluster

# manage results
do.call("c", lapply(results, function(x) x["max"]))

################################################################################

# there is also a parSapply, parApply, etc.

# sometimes a loop might require the use of an object you have created in your workspace
# in which case you need to export it to all the clusters

# to export specific objects

clusterExport(myCluster, c("sigma","b0","b1","n"))

# or to export all objects

clusterExport(myCluster, ls())

# you also need to load any non-base packages onto the other cores

clusterEvalQ(myCluster, require(mvtnorm))

# NB you need to have a cluster initialised for clusterExport and clusterEvalQ

################################################################################

# a convenient way to check speed of functions

require(rbenchmark)

myCluster <- makeCluster(nCores)

samp.size <- 100000

nloops <- 100

clusterExport(myCluster, ls())

benchmark(lapply(1:nloops, function(i) myFunc(samp.size)),
          parLapply(myCluster, 1:nloops, function(i) myFunc(samp.size)),
          columns = c("test", "replications", "elapsed", "relative"), 
          order = "elapsed", 
          replications = 1)

stopCluster(myCluster)

################################################################################
################################################################################