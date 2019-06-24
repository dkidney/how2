require(animation)

setwd("~/Dropbox/Resources/Applications/R/Plotting")

ani.options("convert", outdir=getwd(), autobrowse=F)

saveGIF({
  for (i in 1:20) plot(runif(10), ylim = 0:1, main=paste(i))
}, movie.name = "animation.gif", interval = 0.5, nmax = 50, ani.width = 600,
        ani.height = 600)


p <- seq(0.999, .9, len=10)       
p <- c(rev(p), p)   
saveGIF({
  for (i in 1:length(p)){
    pie(c(1-p[i], p[i], 1-p[i]),    
    col=c("white", "yellow", "white"),
    border=NA, labels=NA)
    points(.3,.4, pch=16, cex=4)   
  }
}, movie.name = "pacman.gif", interval = 0.01, nmax = 50, ani.width = 600,
        ani.height = 600)
