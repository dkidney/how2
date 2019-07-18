

x = 1:nrow(volcano)
y = 1:ncol(volcano)

image(x, y, volcano)

temp = contourLines(x, y, volcano)

for(i in 1:length(temp)) lines(temp[[i]]$x, temp[[i]]$y)



image(x, y, volcano)

temp = contourLines(x, y, volcano, levels = 150)

for(i in 1:length(temp)) lines(temp[[i]]$x, temp[[i]]$y)


options("max.contour.segments" = 10000)

image(x, y, volcano)

temp = contourLines(x, y, volcano, levels = 150)

for(i in 1:length(temp)) lines(temp[[i]]$x, temp[[i]]$y)
