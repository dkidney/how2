
require(raster)
require(fields)
require(akima)

par(mar = c(0,0,0,0))

#  ------------------------------------------------------------------------


n = 1000

x = runif(n,-3,3)
y = runif(n,-3,3)
z = dnorm(x) * dnorm(y)

raw = data.frame(x = x, y = y, z = z)

new = rasterize(raw[,1:2], raster(extent(raw[,1:2]), ncol = 10, nrow = 10), raw[,3], fun = mean)

plot(new)
contour(new, add = TRUE)


image.plot(interp(x, y, z, linear = TRUE), asp = 1, col = rev(terrain.colors(255)))
image.plot(interp(x, y, z), asp = 1, col = rev(terrain.colors(255)))


#  ------------------------------------------------------------------------

load("~/Projects/SECR/bandicoots/data/RData/altitude_dataframe.RData") ; ls()

# i = sample(1:nrow(altitude_dataframe), 100) # 0.02
i = sample(1:nrow(altitude_dataframe), 1000)
# i = sample(1:nrow(altitude_dataframe), 10000)
# i = sample(1:nrow(altitude_dataframe), 50000)
# i = sample(1:nrow(altitude_dataframe), 100000)
# i = sample(1:nrow(altitude_dataframe), 500000)
# i = 1:nrow(altitude_dataframe)

par(mar = c(2,2,2,2))
ns = 2^c(1:22) ; ns
time = rep(NA, length(ns))

for(j in 1:length(ns)){
  
  i = sample(1:nrow(altitude_dataframe), ns[j])
  time[j] = system.time({
    temp = with(altitude_dataframe[i,], {
      interp(x, y, z, linear = TRUE, duplicate = "mean")
    })  
    #   image.plot(temp, asp = 1, col = rev(terrain.colors(255)))
  })["elapsed"]
  
  plot(ns[1:j], time[1:j], type = "b")
  print(cbind(ns=ns, time=time)[1:j,])
  
}


#  ------------------------------------------------------------------------

load("~/Projects/SECR/bandicoots/data/RData/altitude_dataframe.RData") ; ls()

# i = sample(1:nrow(altitude_dataframe), 1000)
# i = sample(1:nrow(altitude_dataframe), 10000)
# i = sample(1:nrow(altitude_dataframe), 100000)
i = 1:nrow(altitude_dataframe)

ext = extent(altitude_dataframe[,1:2])

res = 100
xs = seq(ext@xmin, ext@xmax, res)
ys = seq(ext@ymin, ext@ymax, res)

# ras = raster(ext, resolution = 1000)
ras = raster(nrows = length(ys), ncols = length(xs), xmn = min(xs), xmx = max(xs), ymn = min(ys), ymx = max(ys))

new = rasterize(
  x     = altitude_dataframe[i,1:2], 
  y     = ras, 
  field = altitude_dataframe[i,3], 
  fun   = mean
)

plot(new, graphics.reset = TRUE)

mat = as.matrix(new) ; dim(mat)
mat = t(mat)
mat = mat[,ncol(mat):1]
image(xs, ys, mat, asp = 1)
image.plot(xs, ys, mat, asp = 1)

missing = which(is.na(mat), arr.ind = TRUE)
missing[,1] = xs[missing[,1]]
missing[,2] = ys[missing[,2]]

points(missing)

preds = interp.surface(list(x = xs, y = ys, z = mat), missing)

sum(!is.na(preds))


str(new)

# as.data.frame(new)

# tps = Tps(altitude_dataframe[i,1:2], altitude_dataframe[i,3])




r_interpolate = interpolate(new[is.na(new)], tps)




interpolate(new, tps)




