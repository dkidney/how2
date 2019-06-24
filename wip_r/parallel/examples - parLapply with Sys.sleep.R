################################################################################
################################################################################

# Examples - parLapply

################################################################################
################################################################################

nloops <- 64

nseconds <- 0.1
    
#-------------------------------------------------------------------------------
# In series - should take nseconds x nloops seconds

print(system.time({
    
    results <- lapply(1:nloops, function(i){
        
        Sys.sleep(nseconds)
        
    })

}))["elapsed"]

#-------------------------------------------------------------------------------
# In parallel - should take nseconds x nloops / ncores seconds

require(parallel)

ncores <- detectCores() ; ncores

myCluster <- makeCluster(ncores)

clusterExport(myCluster, "nseconds")

print(system.time({
    
    results <- parLapply(myCluster, 1:nloops, function(i){
        
        Sys.sleep(nseconds)

    })

}))["elapsed"]

stopCluster(myCluster)

################################################################################
################################################################################
