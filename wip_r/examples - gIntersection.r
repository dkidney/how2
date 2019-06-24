
# make a list of small squares
w = 0.5
centres = expand.grid(x = seq(-1, 1, by = w), y = seq(-1, 1, by = w))
small = lapply(1:nrow(centres), function(i){
    data.frame(x = centres$x[i] + w/2 * c(1,1,-1,-1),
               y = centres$y[i] + w/2 * c(-1,1,1,-1))
})[c(1,3,5,11,13,15,21,23,25)]
names(small) = 1:length(small)

# and a list of large squares
large = list(
    X = data.frame(x = c(-1,-1,0,0), y = c(0,1,1,0)),
    Y = data.frame(x = c(0,0,1,1), y = c(-1,0,0,-1))
) ; large

# make them closed
small = lapply(small, function(x) x = rbind(x, x[1,]))
large = lapply(large, function(x) x = rbind(x, x[1,]))

# plot them
par(mfrow = c(1,1), oma = c(0,0,0,0), mar = c(0,0,0,0))
plot(0, 0, xlim = c(-1,1), ylim = c(-1.5,1.5), type = "n", asp = 1)
invisible(lapply(small, polygon))
invisible(lapply(large, polygon))




# grouped Polygons --------------------------------------------------------

require(rgeos)

Small = SpatialPolygons(list(Polygons(srl = lapply(small, function(x) Polygon(coords = x, hole = FALSE)), ID = "Small")))
Large = SpatialPolygons(list(Polygons(srl = lapply(large, function(x) Polygon(coords = x, hole = FALSE)), ID = "Large")))

plot(Small, add = TRUE, col = "lightgreen")
plot(Large, add = TRUE, col = "lightblue")

int = gIntersection(Small, Large)

plot(int, add = TRUE, col = 2)

# one polygon
length(int@polygons)

# all in a single Polygons object
length(int@polygons[[1]]@Polygons)

int@polygons[[1]]@Polygons



# separate Polygons -------------------------------------------------------

require(rgeos)

Small = SpatialPolygons(lapply(1:length(small), function(i) Polygons(srl = list(Polygon(coords = small[[i]], hole = FALSE)), ID = names(small)[i])))
Large = SpatialPolygons(lapply(1:length(large), function(i) Polygons(srl = list(Polygon(coords = large[[i]], hole = FALSE)), ID = names(large)[i])))

plot(Small, add = TRUE, col = "lightgreen")
plot(Large, add = TRUE, col = "lightblue")

int = gIntersection(Small, Large)

plot(int, add = TRUE, col = 2)

# one polygon
length(int@polygons)

# all in a single Polygons object
length(int@polygons[[1]]@Polygons)

int@polygons[[1]]@Polygons


























# convert to Polygon class
large = Polygon(large)
small = lapply(small, Polygon)

# convert to Polygons class
large = Polygons(list(large), ID = "large")
# small = Polygons(small, ID ="small")
small = lapply(1:length(small), function(i) Polygons(list(small[[i]]), ID = paste0("small",i)))

# convert to SpatialPolygons class
large = SpatialPolygons(list(large), proj4string = CRS("+init=epsg:27700"))
small = SpatialPolygons(small, proj4string = CRS("+init=epsg:27700"))

# union of small cells
small.union = gUnionCascaded(small)
plot(small.union, lwd = 2, add = TRUE)

# get areas of intersection
intersections = gIntersection(small, large)
plot(intersections, add = TRUE, col = 2)

length(intersections@polygons)
length(intersections@polygons[[1]]@Polygons)
sapply(intersections@polygons@Polygons, function(x) x@area)

intersections = gIntersection(large, small)
plot(intersections, add = TRUE, col = 3)

length(intersections@polygons)
length(intersections@polygons[[1]]@Polygons)
sapply(intersections@polygons@Polygons, function(x) x@area)

################################################################################


p1 = data.frame(x = c(0,0,1,1), y = c(0,1,1,0)) ; p1
p2 = data.frame(x = c(0.5,0.5,1.5,1.5), y = c(0.5,1.5,1.5,0.5)) ; p2

require(splancs)
areapl(as.matrix(p1))
areapl(as.matrix(p2))

plot(p1, type = "n", xlim = c(0,1.5), ylim = c(0,1.5))
polygon(p1)
polygon(p2)

require(sp)
p1 = rbind(p1, p1[1,])
p1 = Polygon(p1)
p1@area

p2 = rbind(p2, p2[1,])
p2 = Polygon(p2)
p2@area

p1 = Polygons(list(p1), "p1")
p2 = Polygons(list(p2), "p2")
p2@Polygons[[1]]@area
p1@Polygons[[1]]@area

p1 = SpatialPolygons(list(p1), proj4string = CRS("+init=epsg:27700"))
p2 = SpatialPolygons(list(p2), proj4string = CRS("+init=epsg:27700"))
p1@polygons[[1]]@area
p2@polygons[[1]]@area

require(rgeos)
int = gIntersection(p1, p2)
plot(int, add = TRUE, col = 2)
int@polygons[[1]]@area

dif = gDifference(p1, p2)
plot(dif, add = TRUE, col = 3)
dif@polygons[[1]]@area
str(dif)

dif@polygons[[1]]@Polygons[[1]]@coords
