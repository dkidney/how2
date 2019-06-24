################################################################################
################################################################################

# Examples - parallel package

################################################################################
################################################################################

print(getwd())

require(parallel)

nCores <- getOption("cl.cores", detectCores()) ; nCores # counts the number of cores you have

myCluster <- makeCluster(nCores) ; myCluster # intitialise the cluster

nloops <- 32

clusterExport(myCluster, ls()) # make sure all nodes have the function in the workspace

print(system.time(results <- parLapply(myCluster, 1:nloops, function(i) Sys.sleep(1) )))

stopCluster(myCluster) # unintitialise the cluster

save(results, file="results.RData")

################################################################################
################################################################################