################################################################################
################################################################################

require(rgdal)


# convert lat-long to easting northing 
ll = matrix(c(89, -5), nc=2) ; colnames(ll) = c("x","y") ; ll 
osgb = as.data.frame(spTransform(SpatialPoints(ll, CRS("+proj=longlat")), CRS("+init=epsg:27700")))
osgb

# convert easting northing to lat-long
as.data.frame(spTransform(SpatialPoints(osgb, CRS("+init=epsg:27700")), CRS("+proj=longlat")))


################################################################################
################################################################################
################################################################################
################################################################################


x = seq(0, 360, length = 50)
y = seq(-90, 90, length = 10)
z = matrix(NA, nr = length(x), nc = length(y))

for(i in 1:length(x)){ # i=1
    
    for(j in 1:length(y)){ # i=j
        
        ll = matrix(c(x[i], y[j]), nc=2)
        # osgb = try(as.data.frame(spTransform(SpatialPoints(ll, CRS("+proj=longlat")), CRS("+proj=utm +zone=1"))), TRUE)
        # osgb = try(as.data.frame(spTransform(SpatialPoints(ll, CRS("+proj=longlat")), CRS("+proj=utm +zone=2"))), TRUE)
        osgb = try(as.data.frame(spTransform(SpatialPoints(ll, CRS("+proj=longlat")), CRS("+proj=utm +zone=4"))), TRUE)
        # osgb = try(as.data.frame(spTransform(SpatialPoints(ll, CRS("+proj=longlat")), CRS("+proj=utm +zone=60"))), TRUE)
        # osgb = try(as.data.frame(spTransform(SpatialPoints(ll, CRS("+proj=longlat")), CRS("+init=epsg:27700"))), TRUE)
        z[i,j] = if(inherits(osgb, "try-error")) NA else 1
        
    }
    
}

apply(z, 1, function(x) !all(is.na(x)))
x[40]


par(mar = c(2,2,0,0))
image(x,y,z)
map('world2', add = TRUE)
with(vms[sample(1:nrow(vms), 50000, replace = FALSE),], points(lon, lat, pch = 19, cex = 0.5, col = c(2,4)[as.factor(dtype)]))
# with(vms, points(lat, lon, pch = 19, cex = 0.5, col = 4))

