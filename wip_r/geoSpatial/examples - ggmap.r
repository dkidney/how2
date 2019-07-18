################################################################################
################################################################################

require(ggmap)

register_google(
    key = Sys.getenv("GOOGLE_CLOUD_API_KEY"),
    account_type = "starndard",
    day_limit = 2500
)

# lon-lat vectors automatically use google:
(map <- get_map(c(-97.14667, 31.5493)))
str(map)
ggmap(map)

# bounding boxes default to stamen
(map <- get_map(c(left = -97.1268, bottom = 31.536245, right = -97.099334, top = 31.559652)))
ggmap(map)

# characters default to google
(map <- get_map("orlando, florida"))
ggmap(map)


## basic usage
########################################

(map <- get_map(maptype = "roadmap"))
(map <- get_map(source = "osm"))
(map <- get_map(source = "stamen", maptype = "watercolor"))

map <- get_map(location = "texas", zoom = 6, source = "stamen")
ggmap(map, fullpage = TRUE)






# download main map (experiment with 'color' and 'maptype' arguments)
map1 <- get_map(location = 'Cambodia', zoom = 7, color = "color", maptype = "satellite")

# download second map (centred on surface)
map2 <- get_map(location = c(mean(surface$x), mean(surface$y)), zoom = 8, color = "bw")

# corners of bounding box of second map
bb <- as.data.frame(attr(map2, "bb")) ; bb

# you can use these coordinates to draw a rectangle on the main map
xlim <- c(bb$ll.lon, bb$ur.lon) ; xlim
ylim <- c(bb$ll.lat, bb$ur.lat) ; ylim

# or you can define your own coordinates, e.g.
# xlim <- c(103, 106) ; xlim
# ylim <- c(10, 13) ; ylim

# make main plot - draw rectangle showing bounding box of second map
plot1 <- ggmap(map1, scale=100000) +
    annotate('rect', xmin=xlim[1], xmax=xlim[2], ymin=ylim[1], ymax=ylim[2], alpha = 0, colour = 1, size = 1) +
    xlab("Lon") + ylab("Lat")

plot1

# some functions I pinched off the internet for drawing scales
# you would need to work out how big a unit of longitude is at a given latitude
# hscale_segment = function(breaks, ...)
# {
#     y = unique(breaks$y)
#     stopifnot(length(y) == 1)
#     dx = max(breaks$x) - min(breaks$x)
#     dy = 1/30 * dx
#     hscale = data.frame(ix=min(breaks$x), iy=y, jx=max(breaks$x),
#                         jy=y)
#     vticks = data.frame(ix=breaks$x, iy=(y - dy), jx=breaks$x, jy=(y +
#                                                                        dy))
#     df = rbind(hscale, vticks)
#     return(geom_segment(data=df,
#                         aes(x=ix, xend=jx, y=iy, yend=jy),
#                         ...))
#
# }
#
# hscale_text = function(breaks, ...)
# {
#     dx = max(breaks$x) - min(breaks$x)
#     dy = 2/30 * dx
#     breaks$y = breaks$y + dy
#     return(geom_text(data=breaks,
#                      aes(x=x, y=y, label=label),
#                      hjust=0.5,
#                      vjust=0,
#                      ...))
#
# }

# inset plot
plot2 <- ggmap(map2) +
    geom_tile(data = surface, aes(x=x, y=y, fill=z), alpha=0.3) +
    scale_fill_gradient(low="green", high="red") +
    geom_contour(data = surface, aes(x=x, y=y, z=z), colour=1) +
    xlab("Lon") + ylab("Lat") +
    theme(legend.justification=c(1,0), legend.position=c(1,0))

# breaks <- data.frame(x = c(103.5, 104.5), y = rep(10.5, 2))
# plot2 <- plot2 +
#     hscale_segment(breaks) +
#     hscale_text(breaks, label=c("0", "Xkm"))

plot2

# if you have defined your own boundary for the second map then you need to use coord_map, e.g.
plot2 <- plot2 + coord_map(xlim = xlim, ylim = ylim)
plot2

# make a side-by-side plot
require(gridExtra)
grid.arrange(plot1, plot2, ncol=2)

################################################################################

# annotate using ggplot tools

# arbitrary surface
n <- 10 # number of unique longitude and latitude values
x <- seq(104, 106, length=n) # longitude values
y <- seq(11, 13, length=n) # latitude values
xy <- as.data.frame(expand.grid(x,y)) # data frame of coordinates
s <- 0.5 # sigma - determines shape of surface
z <- apply(xy, 1, function(x) dnorm(x[1], 105, s) * dnorm(x[2], 12, s)) # surface values
surface <- data.frame(x=xy[,1], y=xy[,2], z=z) ; head(surface) # data frame of coordinates and surface values

################################################################################
################################################################################