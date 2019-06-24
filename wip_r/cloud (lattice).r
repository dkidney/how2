##############################################################################
##############################################################################

# Gams

##############################################################################
##############################################################################

par(mfrow=c(1,1))

lat <- lon <- seq(-2.5, 2.5, length=10)

data <- expand.grid(lat=lat, lon=lon)

n <- nrow(data) ; n

data$y <- dnorm(data$lat) * dnorm(data$lon) + rnorm(n, 0, 0.05)

par.set <- list(axis.line = list(col = "transparent"), clip = list(panel = "off"))

lattice::cloud(data$y ~ data$lon + data$lat, pch=19, xlim=c(-3,3), ylim=c(-3,3), col="blue", distance = .4, zoom = .8, par.settings = par.set, xlab="lon", ylab="lat", zlab="response")

# require(rgl)
# plot3d(data$lon, data$lat, data$y, xlim=c(-3,3), ylim=c(-3,3), zlim=range(data$y), col="blue", size=5)

require(mgcv)

?s

model1 <- gam(y ~ s(lat) + lon, data=data)
summary(model1)
vis.gam(model1, view=c("lat","lon"), color="heat", plot.type="contour")

model2 <- gam(y ~ s(lat) + s(lon), data=data)
summary(model2)
vis.gam(model2, view=c("lat","lon"), color="heat", plot.type="contour")

model3 <- gam(y ~ s(lat, lon), data=data)
summary(model3)
vis.gam(model3, view=c("lat","lon"), color="heat", plot.type="contour")

##############################################################################
##############################################################################
