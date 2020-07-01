################################################################################
################################################################################

# example simulation

destination = "K:/Archive/temp"

unlink(file.path(destination, dir(destination)), TRUE, TRUE)

nloops = 1000

for(i in 1:nloops){
 
    Sys.sleep(0.1)
    
    x = rnorm(1)
    
    save(x, file = file.path(destination, paste("temp_", i, ".RData", sep="")))
    
}

# run the code below in a new R session

require(oddments)
monitor.sim(n = nloops, path = destination, refresh = 0.1)

################################################################################
################################################################################
