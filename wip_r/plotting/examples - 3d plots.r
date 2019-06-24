################################################################################
################################################################################

# Examples - 3D plots

################################################################################
################################################################################

# Surfaces stored in a matrix

require(grDevices) # for colours

# E.g. bivariate normal
x <- y <- seq(-3,3,len = 100)
z <- outer(x, y, function(x,y) dnorm(x)*dnorm(y))

#-------------------------------------------------------------------------------
# image
image(x, y, z)
image(x, y, z, ann = FALSE, axes = FALSE)
image(x, y, z, col = heat.colors(100))
image(x, y, z, col = rainbow(100))
image(x, y, z, col = terrain.colors(100))
image(x, y, z, col = topo.colors(100))
image(x, y, z, col = cm.colors(10))
box()

#-------------------------------------------------------------------------------
# contour
contour(x, y, z)
contour(x, y, z, levels = seq(0, 0.2, by = 0.01), col = "peru")

#-------------------------------------------------------------------------------
# image and contour combined
image(x, y, z)
contour(x, y, z, add = TRUE)

#-------------------------------------------------------------------------------
# filled.contour
filled.contour(x, y, z)
filled.contour(x, y, z, asp = 1)
filled.contour(x, y, z, color = rainbow)
filled.contour(x, y, z, color = terrain.colors)
filled.contour(x, y, z, color = heat.colors)
filled.contour(x, y, z, plot.title = title(main = "Main title", xlab = "x lab", ylab = "y lab"),
               key.title = title(main = "Key title"))
mtext("some more text", side = 1, line = 4, adj = 1, cex = .66)

#-------------------------------------------------------------------------------
# persp
persp(x, y, z)
persp(x, y, z, phi = 30)
persp(x, y, z, phi = 30, theta = -30)
persp(x, y, z, phi = 30, theta = -30, d = 0.5)
persp(x, y, z, phi = 30, theta = -30, d = 100)
persp(x, y, z, phi = 30, theta = -30, d = 1, expand = 0.6)
op <- par(mar = c(0,0,0,0), oma = c(0,0,0,0))
persp(x, y, z, phi = 30, theta = -30, d = 1, expand = 0.6)
par(op)

#-------------------------------------------------------------------------------
# persp3D - try spinning this around
library(rgl)
persp3d(x, y, z, col = "lightblue")


################################################################################

# another surface example - volcano data (already in R)

class(volcano)
dim(volcano)

# need x and y values corresponding to rows and colums of whatever matrix contains surface values
long <- 1:nrow(volcano)
lat <- 1:ncol(volcano)

#-------------------------------------------------------------------------------
# persp
op <- par(mar = c(0,0,0,0), oma = c(0,0,0,0))
persp(long, lat, volcano, theta = 40, phi = 30, scale = T, ltheta = -120, shade = 0.4, expand = 0.5)
persp(long, lat, volcano, theta = 40, phi = 30, scale = T, ltheta = -120, shade = 0.4, expand = 0.5, box = F)
persp(long, lat, volcano, theta = 40, phi = 30, scale = T, ltheta = -120, shade = 0.4, expand = 0.5, border = NA, box = F)
par(op)

#-------------------------------------------------------------------------------
# persp with colours (quite tricky)
ncolours <- 100
z <- volcano
zi <- z[-1, -1] + z[-1, -ncol(z)] + z[-nrow(z), -1] + z[-nrow(z), -ncol(z)]

op <- par(mar = c(0,0,0,0), oma = c(0,0,0,0))

colours <- terrain.colors(ncolours)[cut(zi, ncolours)]
persp(long, lat, volcano, col = colours, theta = 40, phi = 30, scale = T, ltheta = -120, shade = 0.4, expand = 0.5, border = NA, box = F)

colours <- topo.colors(ncolours)[cut(zi, ncolours)]
persp(long, lat, volcano, col = colours, theta = 40, phi = 30, scale = T, ltheta = -120, shade = 0.4, expand = 0.5, border = NA, box = F)

colours <- rainbow(ncolours)[cut(zi, ncolours)]
persp(long, lat, volcano, col = colours, theta = 40, phi = 30, scale = T, ltheta = -120, shade = 0.4, expand = 0.5, border = NA, box = F)

colours <- heat.colors(ncolours)[cut(zi, ncolours)]
persp(long, lat, volcano, col = colours, theta = 40, phi = 30, scale = T, ltheta = -120, shade = 0.4, expand = 0.5, border = NA, box = F)

colours <- colorRampPalette(c("blue","green"))(ncolours)[cut(zi, ncolours)]
persp(long, lat, volcano, col = colours, theta = 40, phi = 30, scale = T, ltheta = -120, shade = 0.4, expand = 0.5, border = NA, box = F)

par(op)

#-------------------------------------------------------------------------------
# persp3d
colours <- terrain.colors(ncolours)[cut(z, ncolours)]
persp3d(long, lat, volcano, col = colours)
persp3d(long, lat, volcano, col = colours, box = F, axes = F, xlab = "", ylab = "", zlab = "")
persp3d(long, lat, volcano, col = colours, aspect = c(1,0.7,0.4), box = F, axes = F, xlab = "", ylab = "", zlab = "")
play3d(spin3d(axis = c(0,0,1), rpm = 2), duration = 60)

# you'll love this one
lat <- matrix(seq(90,-90, len = 50)*pi/180, 50, 50, byrow = TRUE)
long <- matrix(seq(-180, 180, len = 50)*pi/180, 50, 50)
r <- 6378.1 # radius of Earth in km
x <- r*cos(lat)*cos(long)
y <- r*cos(lat)*sin(long)
z <- r*sin(lat)
persp3d(x, y, z, col = "white",
        texture = system.file("textures/world.png",package = "rgl"),
        specular = "black", axes = FALSE, box = FALSE, xlab = "", ylab = "", zlab = "",
        normal_x = x, normal_y = y, normal_z = z)
play3d(spin3d(axis = c(0,0,1), rpm = 2), duration = 60)

################################################################################
################################################################################

# Three vectors of equal length
n <- 50
x <- y <- seq(-3, 3, length = n)
d <- expand.grid(x = x,y = y)
d$z <- dnorm(d$x)*dnorm(d$y)
head(d)

#-------------------------------------------------------------------------------
# plot3d
with(d, plot3d(x,y,z))

#-------------------------------------------------------------------------------
# p3d
require(onion)
p3d(as.matrix(d), pch = 19)
p3d(as.matrix(d), pch = 19, theta = 40, phi = 30, box = FALSE) # ignore the warnings...

data(bunny)
str(bunny)
p3d(bunny)
p3d(bunny, theta = 3, phi = 104, box = FALSE) # ignore the warnings...

#-------------------------------------------------------------------------------
# wireframe

require(lattice)
wireframe(z ~ x * y, data = d)

levelplot(z ~ x * y, data = d)

wireframe(z ~ x * y, data = d, xlab = "", ylab = "", zlab = "",
          drape = TRUE,
          scales = list(arrows = FALSE,
                        distance = 0.1,
                        x = list(draw = FALSE),
                        y = list(draw = FALSE),
                        z = list(draw = FALSE)),
          screen = list(z = 20,
                        x = -70,
                        y = 0),
          zoom = 1.1,
          distance = 0.4,
          at = do.breaks(c(0, max(d$z)), 100),
          par.box = c(col = "transparent"),
          par.settings = list(axis.line = list(col = "transparent"),
                              regions = list(alpha = 0.85)),
          panel.aspect = 0.9,
          aspect = c(1,0.8,1),
          col.regions = heat.colors(100),
          colorkey = FALSE)

# p = lattice.wireframe(volcano, shade = True,
#                       zlab = "",
#                       aspect = FloatVector(61.0/87, 0.4),
#                       light_source = IntVector((10,0,10)))
# rprint(p)

################################################################################
################################################################################

