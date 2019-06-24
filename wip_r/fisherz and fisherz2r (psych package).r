
require(psych)

n <- 10000

x <- seq(-1,1,length=n)

hist(x)

hist(fisherz(x))

hist(fisherz2r(fisherz(x)))

plot(0:10, 0.5^(0:10), type="l")

plot(0:10, fisherz2r(0.5^(0:10)), type="l")
