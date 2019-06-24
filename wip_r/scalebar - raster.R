
require(raster)

f <- system.file("external/test.grd", package="raster")
r <- raster(f)
methods(class = class(r))
pop = par(no.readonly = TRUE)
par(mfrow = c(1,1), mar = c(2,2,0,2))
plot(r)
scalebar(1000, cex = 0.5)
scalebar(1000, xy=c(178000, 333500), type='bar', divs=4)
par(pop)
