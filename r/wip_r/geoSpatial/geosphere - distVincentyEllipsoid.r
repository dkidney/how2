
require(geosphere)


# distVincentyEllipsoid ---------------------------------------------------

# distance of one degree of longitude at the equator is about 111.32 km
p1 = c(0,0) 
p2 = c(1,0) 
distVincentyEllipsoid(p1, p2) / 1000 # km

# distance from Ely to Cambridge
p1 = c(0.24,52.4) # ELy
p2 = c(0.12,52.2) # Cambridge
distVincentyEllipsoid(p1, p2) / 1000 / 1.61 # miles

# distance s between multiple pairs of points
a = cbind(lon = 1:10, lat = 1:10)
b = cbind(lon = 2:11, lat = 2:11)
plot(a,b)
distVincentyEllipsoid(a, b) / 1000
