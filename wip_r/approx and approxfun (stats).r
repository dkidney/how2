
# some data
x = seq(-5, 5, by=0.1)
y = dnorm(x)
plot(x, y)


# approx ------------------------------------------------------------------

# interpolated values
interp.values = approx(x, y, n = 1000)
str(interp.values)
lines(interp.values, col = 2, lwd = 2)


# approxfun ---------------------------------------------------------------

# approximate function
dnorm.approx = approxfun(x,y)
class(dnorm.approx)

curve(dnorm.approx, col = 4, lwd = 2, lty = 2, add = TRUE)

integrate(dnorm.approx, min(x), max(x))


