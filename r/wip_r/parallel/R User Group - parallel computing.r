#################################################################################
#################################################################################

# Len's R User group talk - parallel procesing

#################################################################################
#################################################################################

# r-enterprise - free version of R (from REvolution) for academics which is optimised to employ more automatic multithreading and therefore runs faster

# Len's example using the parallel package (base installation package)

# probably no need to uninstall parallel after you have detected the number of cores...

# mulitcore (forking functions - e.g. mclapply) - probably a bit faster than snow, but can't used on windows

library(parallel)

?parSapplyLB # does load balancing - passes the next job to the next available core (rather than sumitting 1/ncores of the jobs to each core all at the start).

# doParallel links foreach and doSNOW

# redo you doSNOW code - doSNOW is out of date...

# do you even need 'register doSNOW' if you use the parallel package?

# also check out the plyr package (a wrapper for foreach)

#################################################################################
#################################################################################