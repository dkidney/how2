###############################################################################################################
###############################################################################################################

# Examples - lattice

###############################################################################################################
###############################################################################################################

# make plots appear in order from top to bottom, left to right

n <- 10
means <- c(0,1)
sds <- c(1,2)
test <- data.frame(x = c(rnorm(n, means[1], sds[1]),
                         rnorm(n, means[1], sds[2]), 
                         rnorm(n, means[2], sds[1]), 
                         rnorm(n, means[2], sds[2])), 
                   mean = paste("Mean =", rep(means, each = 2*n)),
                   sd = paste("Sd =", rep(rep(sds, each=n), 2)))
head(test)

require(lattice)

# default order goes from bottom to top, left to right
densityplot(~ x | mean * sd, data = test)

# change to top to bottom, left to right
lattice.options(default.args = list(as.table = TRUE)) 
densityplot(~ x | mean * sd, data = test)

###############################################################################################################
###############################################################################################################

