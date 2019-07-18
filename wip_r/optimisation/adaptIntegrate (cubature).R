
require(cubature)


# 1-dimension -------------------------------------------------------------

# e.g. the normal pdf - integral = 1

curve(dnorm, xlim = c(-4, 4))

result = adaptIntegrate(f = dnorm, lowerLimit = -4, upperLimit = 4)

result$integral


# 2-dimensional -----------------------------------------------------------

# e.g. bivariate normal pdf - integral = 1

h = function(x, y) x^2 + y
g = function(x) h(x[1], x[2])

x = y = seq(-4, 4, length = 100)
z = outer(x, y, h)
image(x, y, z)

result = adaptIntegrate(g, lowerLimit = c(-4, -4), upperLimit = c(4, 4))

result$integral

# or conditional on y
result = adaptIntegrate(h, y = 3, lowerLimit = c(-4, -4), upperLimit = c(4, 4))

result$integral


# multi-dimensional -------------------------------------------------------

require(mvtnorm)

m = 2

result = adaptIntegrate(
  f = dmvnorm, 
  lower = rep(-4, m), 
  upper = rep(4, m), 
  mean = rep(0, m), 
  sigma = diag(m), 
  maxEval = 10000
)

result$integral


