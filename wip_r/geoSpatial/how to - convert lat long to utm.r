####################################################################################################################
####################################################################################################################

# Port of Ardersier - 10 waypoints from port to feature D
# D.Kidney (DMP) 01.02.12

####################################################################################################################
####################################################################################################################

setwd("~/DMP/Port of Ardersier")

require(rgdal)
require(ggmap) # may need to have mapproj installed for this to work

# original coordinates for the port in UTM 30
port_utm30 <- matrix(c(441090, 6383849), nc=2) ; port_utm30

# convert to decimal degrees
port_dd <- spTransform(SpatialPoints(port_utm30, proj4string=CRS("+proj=utm +zone=30")),
                    CRS("+proj=longlat")) 

# get google map tile for the area
port_dd <- as.matrix(as.data.frame(port_dd)) ; port_dd
map <- get_map(location = port_dd, zoom = 13)
ggmap(map)

# approximate coordinates of the four features shown in fgure in Port of Ardersier - Meeting Note - 2013-01-09 - Geo aspects of pre scoping advice - 21 January 2013.doc 
A <- c( -3.998250, 57.600221)
B <- c( -3.981508, 57.585483)
C <- c( -3.955081, 57.589926)
D <- c( -4.028817, 57.604209)
features_dd <- data.frame(rbind(A, B, C, D))
rownames(features_dd) <- c(LETTERS[1:4]) ; features_dd

# 10 waypoints going from port to feature D
waypoints_dd <- data.frame(rbind(
    c( -3.987340, 57.595440),
    c( -3.991055, 57.596711),
    c( -3.995020, 57.597841),
    c( -3.998790, 57.598859),
    c( -4.003319, 57.600007),
    c( -4.007741, 57.601437),
    c( -4.013514, 57.601209),
    c( -4.017799, 57.602971),
    c( -4.023327, 57.603659),
    D
)) 
colnames(port_dd) <- colnames(waypoints_dd) <- colnames(features_dd) <- c("lon","lat")

# final map
port_dd <- as.data.frame(port_dd)
xlim <- c(-4.04, -3.94)
ylim <- c(57.58, 57.61)
print(
    ggmap(map) + xlab("Lon") + ylab("Lat") + 
        geom_point(aes(x=lon, y=lat), data = waypoints_dd, color="black", size=2) +
        geom_point(aes(x=lon, y=lat), data = port_dd, color="red", size=2) +
        geom_point(aes(x=lon, y=lat), data = features_dd, color="blue", size=2) +
        coord_map(xlim = xlim, ylim = ylim)
)

# convert waypoints to UTM 30
waypoints_dd_utm30 <- spTransform(SpatialPoints(waypoints, proj4string=CRS("+proj=longlat")),
                    CRS("+proj=utm +zone=30")) 
waypoints_utm30 <- as.matrix(as.data.frame(waypoints_utm30)) ; waypoints_utm30


####################################################################################################################
####################################################################################################################