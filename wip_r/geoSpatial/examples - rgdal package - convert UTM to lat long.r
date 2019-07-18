####################################################################################################################
####################################################################################################################

# an example UTM coordinate in Cambodia (UTM 48)
utm <- matrix(c(683869, 1551956), nc=2) ; utm

# 'SpatialPoints'
# - takes a matrix or data frame as input
# - returns an object of class 'SpatialPoints-class'

# 'spTransform'
# - takes an object of 'SpatialPoints-class' as input
# - transforms coordinates onto the desired projection
# - returns an object of class 'sp'

require(rgdal)
ll <- spTransform(SpatialPoints(utm, proj4string = CRS("+proj=utm +zone=48")),
                  CRS("+proj=longlat")) ; ll ; class(ll)

# can convert the 'sp' object into a matrix (via coersion to a data frame)
ll <- as.matrix(ll) # doesn't work
ll <- as.matrix(as.data.frame(ll)) # does work

####################################################################################################################

# can now make plot using ggmap
require(ggmap)

# location argument of get_map requires a vector or martrix (doesn't work with a data frame)
map <- get_map(location = ll, zoom = 7)
ggmap(map)

####################################################################################################################
####################################################################################################################