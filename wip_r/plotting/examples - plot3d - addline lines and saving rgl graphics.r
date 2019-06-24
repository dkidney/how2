
x <- c(1,4,3,6,2,5)
y <- c(2,2,4,3,5,9)
z <- c(1,3,5,9,2,2)

require(rgl)
plot3d(x,y,z, type="s", size=2, col=1:6)
rgl.bringtotop(stay = TRUE)

plot3d(x,y,z, type="l", col=1:6)

plot3d(x,y,z, type="n")
points3d(x, y, z)
lines3d(x, y, z, lwd=2)

plot3d(x,y,z, type="n")
for(i in 1:5) segments3d(x[i:(i+1)], y[i:(i+1)], z[i:(i+1)], col=i, lwd=2)

rgl.snapshot( "test2.png", fmt="png", top=TRUE )

