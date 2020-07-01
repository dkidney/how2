
################################################################################
# make some data
################################################################################

n = 1000

x <- rnorm(n)

y = rnorm(n)

plot(x,y, pch=19, cex=0.5)

z = dnorm(x) * dnorm(y) ; z

################################################################################
# convert to grey scale
################################################################################

range(z)

i = (z - min(z)) / diff(range(z))

range(i)

points(x, y, pch = 19, cex= 0.5, col = grey(i))

points(x, y, pch = 19, cex= 0.5, col = grey(1-i))

################################################################################
# use a contiguous colour palette 
################################################################################

ncols = 100

i = cut(z, breaks = seq(min(z), max(z), length = ncols+1))

length(i) ; length(levels(i))

points(x, y, pch = 19, cex= 0.5, col = heat.colors(ncols)[i])

points(x, y, pch = 19, cex= 0.5, col = topo.colors(ncols)[i])

################################################################################
# make your own colour palette 
################################################################################

require(grDevices)

points(x, y, pch = 19, cex= 0.5, col = colorRampPalette(c("blue", "red"))(ncols)[i])

points(x, y, pch = 19, cex= 0.5, col = colorRampPalette(c("red", "green"))(ncols)[i])

points(x, y, pch = 19, cex= 0.5, col = colorRampPalette(c(1,2,3))(ncols)[i])

################################################################################
################################################################################
