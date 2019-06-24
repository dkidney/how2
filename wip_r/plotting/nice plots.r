

# iris data
attach(iris)
head(iris)
par(mar=c(0,0,0,0), oma=c(0,0,0,0))
library(rgl)
plot3d(Sepal.Length, Petal.Length, Petal.Width, 
       col=c("red", "green3", "blue")[as.numeric(Species)], type="s", size=1)
par(mar=c(4,4,4,4), oma=c(0,0,0,0))
pairs(iris[1:4], main="Edgar Anderson's Iris Data", pch=21,
      bg=c("red", "green3", "blue")[unclass(iris$Species)])
# bg gives the background fill colour for the open plot symbols
# unclass(iris$species) gets numbers 1 to 3 for subsetting the colour vector

# bivariate normal
ncolours <- 10
x <- y <- seq(-3,3,len=100)
z <- outer(x, y, function(x,y) dnorm(x)*dnorm(y))
par(mar=c(0,0,0,0), oma=c(0,0,0,0))
persp(x, y, z)
persp(x, y, z, phi=30)
persp(x, y, z, phi=30, theta=-30)
persp(x, y, z, phi=30, theta=-30, d=0.5)
persp(x, y, z, phi=30, theta=-30, d=100)
persp(x, y, z, phi=30, theta=-30, d=1, expand=0.6)
persp3d(x, y, z, col="lightblue")

# volcano
ncolours <- 100
x <- 1:nrow(volcano)
y <- 1:ncol(volcano)
z <- volcano
par(mar=c(0,0,0,0), oma=c(0,0,0,0))
persp(x, y, z, theta=40, phi=30, scale=T, ltheta=-120, shade=0.4, expand=0.5)
persp(x, y, z, theta=40, phi=30, scale=T, ltheta=-120, shade=0.4, expand=0.5, box=F)
persp(x, y, z, theta=40, phi=30, scale=T, ltheta=-120, shade=0.4, expand=0.5, border=NA, box=F)
zi <- z[-1, -1] + z[-1, -ncol(z)] + z[-nrow(z), -1] + z[-nrow(z), -ncol(z)]
colours <- terrain.colors(ncolours)[cut(zi, ncolours)]
persp(x, y, z, col=colours, theta=40, phi=30, scale=T, ltheta=-120, shade=0.4, expand=0.5, border=NA, box=F)
colours <- topo.colors(ncolours)[cut(zi, ncolours)]
persp(x, y, z, col=colours, theta=40, phi=30, scale=T, ltheta=-120, shade=0.4, expand=0.5, border=NA, box=F)
colours <- rainbow(ncolours)[cut(zi, ncolours)]
persp(x, y, z, col=colours, theta=40, phi=30, scale=T, ltheta=-120, shade=0.4, expand=0.5, border=NA, box=F)
colours <- heat.colors(ncolours)[cut(zi, ncolours)]
persp(x, y, z, col=colours, theta=40, phi=30, scale=T, ltheta=-120, shade=0.4, expand=0.5, border=NA, box=F)
colours <- colorRampPalette(c("blue","green"))(ncolours)[cut(zi, ncolours)]
persp(x, y, z, col=colours, theta=40, phi=30, scale=T, ltheta=-120, shade=0.4, expand=0.5, border=NA, box=F)
colours <- terrain.colors(ncolours)[cut(z, ncolours)]
persp3d(x, y, z, col=colours)
persp3d(x, y, z, col=colours, box=F, axes=F, xlab="", ylab="", zlab="")
persp3d(x, y, z, col=colours, aspect=c(1,0.7,0.4), box=F, axes=F, xlab="", ylab="", zlab="")

# colours
colorNames = colors()
plot.new()
for (j in 1:60) {
  for (i in 1:11) {
    kolor = colorNames[(i-1)*60+j]
  	rect(i/11,j/60,(i-1)/11,(j-1)/60,col=kolor)
		text((i-0.5)/11,(j-0.5)/60,kolor,col=ifelse(mean(col2rgb(kolor))<120,"white","black"))
	}
}

# a bunny
library(onion)
data(bunny)
head(bunny)
p3d(bunny,theta=3,phi=104,box=FALSE)
plot3d(bunny, col="pink", box=F, axes=F, xlab="", ylab="", zlab="", type="s", size=1)

# A globe
lat <- matrix(seq(90,-90, len=50)*pi/180, 50, 50, byrow=TRUE)
long <- matrix(seq(-180, 180, len=50)*pi/180, 50, 50)
r <- 6378.1 # radius of Earth in km
x <- r*cos(lat)*cos(long)
y <- r*cos(lat)*sin(long)
z <- r*sin(lat)
open3d()
persp3d(x, y, z, col="white", 
       texture=system.file("textures/world.png",package="rgl"), 
       specular="black", axes=FALSE, box=FALSE, xlab="", ylab="", zlab="",
       normal_x=x, normal_y=y, normal_z=z)
play3d(spin3d(axis=c(0,0,1), rpm=2), duration=60)


