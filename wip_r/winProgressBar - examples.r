## -------------------------------------------------------------------------- ##
## -------------------------------------------------------------------------- ##

## winProgressBar

## -------------------------------------------------------------------------- ##
## -------------------------------------------------------------------------- ##


# loops -------------------------------------------------------------------

n = 1000
myProgressBar = winProgressBar("Loop progress", "0% complete", 0, n, 0, 450)
start = Sys.time()

for(i in 1:n){ # i=1
    
    # PUT YOUR CODE HERE!
    rnorm(1000000)
    
    est.finish = Sys.time() + difftime(Sys.time(), start) / i * (n - i) 
    dp = 1
    label = paste(format(round(100 * i / n, dp), nsmall = dp), "% complete", sep = "")
    if(i!=n) label = paste(label, " (estimated finish: ", format(est.finish, "%A %d %B %Y"), " @ ", format(est.finish, "%H:%M"), ")", sep = "")
    setWinProgressBar(myProgressBar, i, label = label)
    
}

close(myProgressBar)


# simulations -------------------------------------------------------------

numSims = 100
simName = "Sim name"
myProgressBar <- winProgressBar(title   = paste("Sim ",0," of ", numSims, " (",simName,")", sep=""),
    label   = "0% complete",
    min     = 0,
    max     = numSims,
    initial = 0,
    width   = 450)
startTime <- Sys.time()

for(sim in 1:numSims){ # sim=1
    
    # PUT YOUR CODE HERE!
    rnorm(1000000)
    
    totalTime  <- difftime(Sys.time(),startTime)
    timeLeft   <- totalTime/sim * (numSims-sim)
    finishTime <- Sys.time() + timeLeft 
    label <- paste(round(100*sim/numSims,2),"% complete",sep="")
    if(sim!=numSims) label <- paste(label," (estimated finish time: ", as.character(finishTime),")",sep="")
    setWinProgressBar(myProgressBar, sim, paste("Sim ",sim," of ", numSims, " (",simName,")", sep=""), label)
    
}

close(myProgressBar)

## -------------------------------------------------------------------------- ##
## -------------------------------------------------------------------------- ##
