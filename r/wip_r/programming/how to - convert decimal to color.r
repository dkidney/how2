
prop2col = function(x, palette = heat.colors, ncols = 100){
    
    levels = cut(x, breaks = seq(0, 1, length = ncols + 1))
    
    palette(ncols)[levels]
    
}

n = 1000
x = runif(n)

par(mfrow = c(2,2))
plot(x, rep(1,n), ylim = c(0,1), type = "h", col = prop2col(x), pch = 19)
plot(x, rep(1,n), ylim = c(0,1), type = "h", col = prop2col(x, terrain.colors), pch = 19)
plot(x, rep(1,n), ylim = c(0,1), type = "h", col = prop2col(x, topo.colors), pch = 19)
plot(x, rep(1,n), ylim = c(0,1), type = "h", col = prop2col(x, cm.colors), pch = 19)

require(grDevices)
plot(x, rep(1,n), ylim = c(0,1), type = "h", col = prop2col(x, colorRampPalette(c("blue", "red"))), pch = 19)

