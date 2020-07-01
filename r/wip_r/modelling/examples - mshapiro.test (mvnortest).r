################################################################################

require(mvtnorm)
require(mvnormtest)

# put dimensions in rows, samples in columns

n = 20 # number of samples

d = 10 # number of dimensions

x = t(rmvnorm(n, mean = rep(0, d))) ; x

mshapiro.test(x)

mshapiro.test(x)$p.value

################################################################################