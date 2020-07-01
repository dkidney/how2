################################################################################
################################################################################

require(miscF)

################################################################################

#Example 1: smooth curve
#example 3.1. (b) in Denison et al.(1998)

x <- sort(runif(200))
xx <- -2 + 4*x
y.truth <- sin(2*xx) + 2*exp(-16*xx^2)
y <- y.truth + rnorm(200, mean=0, sd=0.3)

plot(x, y)
lines(x, y.truth, col=4, lwd=2)

results <- curve.polynomial.rjmcmc(y, x, lambda=1, l=2, l0=1)

plot(sort(x), y.truth[order(x)], type="l")
lines(sort(x), rowMeans(results$fitted.save), col="red")

################################################################################

#Example 2: unsmooth curve
#blocks in Denison et al.(1998)

tj <- c(0.1, 0.13, 0.15, 0.23, 0.25, 0.4, 0.44, 0.65, 0.76, 0.78, 0.81)
hj <- c(4, -5, 3, -4, 5, -4.2, 2.1, 4.3, -3.1, 2.1, -4.2)

t <- seq(0, 1, len=2048)
Ktmtj <- outer(t, tj, function(a,b) ifelse(a-b > 0, 1, -1))
ft <- rowSums(Ktmtj %*% diag(hj))
x <- t
y <- ft + rnorm(2048, 0, 1)

plot(x, ft)
lines(x, y, col=4, lwd=2)

results <- curve.polynomial.rjmcmc(y, x, lambda=5, l=2, l0=1)

plot(x, ft, type="s")
lines(x, rowMeans(results$fitted.save), col="red")

################################################################################

#Example 3: unsmooth curve
#bumps in Denison et al.(1998)

tj <- c(0.1, 0.13, 0.15, 0.23, 0.25, 0.4, 0.44, 0.65, 0.76, 0.78, 0.81)
hj <- c(4, 5, 3, 4, 5, 4.2, 2.1, 4.3, 3.1, 5.1, 4.2)*10
wj <- c(0.005, 0.005, 0.006, 0.01, 0.01, 0.03, 0.01, 0.01, 0.005, 0.008, 0.005)

t <- seq(0, 1, len=2048)
ft <- rowSums((1 + abs(outer(t, tj ,"-") %*% diag(1/wj)))^(-4) %*% diag(hj))
y <- ft + rnorm(2048, 0, 1)

results <- curve.polynomial.rjmcmc(y, t, lambda=5, l=2, l0=1)

plot(t, ft, type="s")
lines(t, rowMeans(results$fitted.save), col="red")

################################################################################
################################################################################
