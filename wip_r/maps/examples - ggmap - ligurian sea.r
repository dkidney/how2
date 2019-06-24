# load packages
require(ggmap) # for ggmap function
require(gridExtra) # for grid.arrange function

# tell R which folder contains the 'dolphin' data
setwd("~/Teaching/Workshops/Statistical Modelling")

# load the dolphin data
dolphin <- read.csv("dolphin.csv") ; head(dolphin)

# define main map and save as object 'map1'
map1 <- get_map(location = "Italy", zoom = 6, color = "color", maptype = "satellite")

# define inset map and save as object 'map2'
map2 <- get_map(location = c(8, 43.25), zoom = 7, color = "bw", maptype = "terrain")

# extract extent attribute of insect map as save as object 'bb'
# bb <- as.data.frame(attr(map2, "bb"))
# xlim <- c(bb$ll.lon, bb$ur.lon) ; xlim
# ylim <- c(bb$ll.lat, bb$ur.lat) ; ylim
          
# or define your own limits
xlim <- c(6, 10)
ylim <- c(41.8275, 44.6625)

# make main plot and save as object 'plot1'
plot1 <- ggmap(map1) + xlab("Lon") + ylab("Lat") +
    annotate('rect', xmin=xlim[1], xmax=xlim[2], ymin=ylim[1], ymax=ylim[2], alpha = 0, colour = 1, size = 1)

# make inset plot and save as object 'plot2'
plot2 <- ggmap(map2) + xlab("Lon") + ylab("Lat") + 
    geom_point(mapping=aes(x=X_coord, y=Y_coord), color="blue", size=1, data=dolphin) +
    coord_map(xlim = xlim, ylim = ylim)

# display side by side
grid.arrange(plot1, plot2, ncol=2)

# save plot in working directory
if(0) { dev.copy(pdf, 'map_ligurian_sea.pdf', width=12, height=6) ; dev.off() }
# if(0) { dev.copy(jpeg, 'map_ligurian_sea.jpeg', width=1000, height=500) ; dev.off() }

