
# convert SpatialLines contours into raster object


# make some contours ------------------------------------------------------

require(rgeos)

point = SpatialPoints(data.frame(x = 0, y = 0))

z = seq(0.99, -1, by = -0.1)
w = acos(z)
z = z + 1

lines = SpatialLines(lapply(1:length(z), function(i){ # i=1
    coords = gBuffer(point, width = w[i])@polygons[[1]]@Polygons[[1]]@coords
    Lines(list(Line(coords)), ID = i)
}))

lines = SpatialLinesDataFrame(lines, data.frame(z = z))

plot(lines)



# linesToRaster -----------------------------------------------------------

temp_raster = raster(ncol = 50, nrow = 50, ext = extent(lines))

lines_raster = raster:::.linesToRaster(lines, temp_raster, "z")

plot(lines_raster, add = TRUE)
plot(lines, add = TRUE)

# lines_raster@data@values



# rasterize ---------------------------------------------------------------

temp = do.call(rbind, lapply(lines@lines, function(x){ # x = lines@lines[[1]] ; x
    
    data = lines@data[x@ID,,drop = FALSE]
    
    rownames(data) = NULL
    
    do.call(rbind, lapply(x@Lines, function(x){ # x = x@Lines[[1]] ; x
        
        cbind(x@coords, data)
        
    }))
    
}))
temp = unique(temp)
head(temp) ; class(temp)

plot(lines)
with(temp, points(x,y))

lines_raster = rasterize(temp[,c("x","y")], temp_raster, ext = extent(lines), field = temp[,"z"], fun = mean)

plot(lines_raster, add = TRUE)
plot(lines, add = TRUE)



# interp (akima) ----------------------------------------------------------

require(akima)

lines_interp = interp(temp$x, temp$y, temp$z,
                      
                      xo = seq(min(temp$x), max(temp$x), length = 100),
                      yo = seq(min(temp$y), max(temp$y), length = 100)
                      
)

image(lines_interp, asp = 1)
plot(lines, add = TRUE)









