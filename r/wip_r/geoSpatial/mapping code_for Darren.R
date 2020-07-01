# Code for map of Africa and study region

zones <- matrix(c(1,2,1,2),ncol=2,byrow=TRUE)
zones
#      [,1] [,2] 
#[1,]    1    2   
#[2,]    1    2   

mylayout <- layout(zones)
dev.new(); layout(zones, widths=c(1/2,1/2),heights=c(1,1)); layout.show(2)
#dev.new(); layout(zones,widths=c(1/3,2/3),heights=c(1,2))
par(mar=c(0,0,0,0))

# Africa map
require(mapdata)
data(worldHiresMapEnv)
latRange.bigmap <- c(-35, -22)
lonRange.bigmap <- c(15, 34)
#par(mar=c(1,1,1,1))
#dev.new(); 
map('worldHires', xlab="lon",ylab="lat", regions='south africa', xlim=lonRange.bigmap, ylim=latRange.bigmap, fill=TRUE, col="grey95", mar=c(0,0,0,1))
#map.scale(x=29, y=-34, cex=0.9, relwidth=0.15, ratio=FALSE)
#dev.new(); map('worldHires', xlab="lon",ylab="lat", xlim=lonRange.map, ylim=latRange.map, fill=TRUE, col="skyblue")
#map.axes()
#require(Hmisc)
#mgp.axis(1, axistitle= "LON")
#mgp.axis(2, axistitle= "LAT")

x0=31.5 ; x1=32.8 ; y0=-29.0 ; y1=-27.5
polygon(x=c(x0,x0,x1,x1),	y=c(y0,y1,y1,y0), lwd=2)

#polygon(x=c(31.5,31.5,32.8,32.8),	y=c(-29.0,-27.5,-27.5,-29.0), border=4)

#segments(x0=c(31.5,31.5,31.5,32.8),
#				 y0=c(-29.0,-29.0,-27.5,-27.5),
#				 x1=c(32.8,31.5,32.8,32.8),
#				 y1=c(-29.0,-27.5,-27.5,-29.0),
#				 lwd=2, col=2)

#segments(x0=31.5, y0=-29.0, x1=32.8, y1=-29.0, lwd=2)
#segments(x0=31.5, y0=-29.0, x1=31.5, y1=-27.5, lwd=2)
#segments(x0=31.5, y0=-27.5, x1=32.8, y1=-27.5, lwd=2)
#segments(x0=32.8, y0=-27.5, x1=32.8, y1=-29.0, lwd=2)

# Vidal map
latRange.littlemap <- c(y0, y1)
lonRange.littlemap <- c(x0, x1)
#latRange.littlemap <- c(-29.0, -27.4)
#lonRange.littlemap <- c(31.9, 32.9)
#dev.new(); 
map('worldHires', xlab="lon", ylab="lat", xlim=lonRange.littlemap, ylim=latRange.littlemap, fill=TRUE, col="grey95", mar=c(5,2,0,1), bty="o")
# POINT ON THE MAP
#points(onefixtracks$lon, onefixtracks$lat, pch=1, col=1, cex=1.2)
#points(Ntower$LON, Ntower$LAT, col=1, pch=16, cex=2)
# AXIS LABELS
#map.axes()
axis(side=1, cex.axis=1.2)
axis(side=2, cex.axis=1.2)
# SCALE ON MAP
map.scale(x=32.55, y=-28.72, cex=1.1, relwidth=0.2, ratio=FALSE)
# NORTH ARROW ON MAP
#arrows(x0=32.7, y0=-28.89, x1=32.7, y1=-28.8, code=2, angle=25, lwd=3)
#text("N", x=32.7, y=-28.74, cex=2.5, font=1)
north.arrow = function(x, y, h) {
		polygon(c(x, x, x + h/2), c(y - h, y, y - (1 + sqrt(3)/2) * h), col = "black", border = NA)
	    polygon(c(x, x + h/2, x, x - h/2), c(y - h, y - (1 + sqrt(3)/2) *  h, y, y - (1 + sqrt(3)/2) * h))
        text(x, y, "N", adj = c(0.5, -0.2), cex = 2)
}
north.arrow(32.65, -28.5, 0.1)
#require(Hmisc)
#mgp.axis(1, axistitle= "LON")
#mgp.axis(2, axistitle= "LAT")

points(Ntower$LON, Ntower$LAT, col=1, pch=16, cex=1.2)
text(x=32.38, y=-28.14, "Cape Vidal", cex=1.2)

points(x=32.395, y=-28.53, pch=16, cex=1.2)
text(x=32.16, y=-28.53, "Cape St Lucia", cex=1.2)

points(x=32.02, y=-28.78, pch=16, cex=1.2)
text(x=32.03, y=-28.68, "Richards", cex=1.2)
text(x=32.03, y=-28.74, "Bay", cex=1.2)

points(x=32.67, y=-27.55, pch=16, cex=1.)
text(x=32.45, y=-27.55, "Sodwana Bay", cex=1.2)


