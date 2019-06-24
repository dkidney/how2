################################################################################
################################################################################

# maptools

require(maptools)

boundary = readShapePoly("~/Miscellaneous/Cecilia SECR/Data/Mask/Area.shp")

plot(boundary)


# rgdal

require(rgdal)

boundary = readOGR("~/Miscellaneous/Cecilia SECR/Data/Mask", "Area")

plot(boundary)


################################################################################
################################################################################