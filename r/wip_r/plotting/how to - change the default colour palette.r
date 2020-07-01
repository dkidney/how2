
# How to change the default colour palette

palette()
plot(1:10, col=1:10, pch=19, cex=2)

palette(gray(seq(0,1,length=10))) ; palette()
plot(1:10, col=1:10, pch=19, cex=2)

palette(rainbow(10)) ; palette()
plot(1:10, col=1:10, pch=19, cex=2)

palette(rgb(red=seq(0,1,length=10),blue=0, green=0, alpha=1)) ; palette()
plot(1:10, col=1:10, pch=19, cex=2)

palette(rgb(red=1,blue=seq(1,0,length=10), green=seq(1,0,length=10), alpha=1)) ; palette()
plot(1:10, col=1:10, pch=19, cex=2)

palette(rgb(red=seq(0,1,length=10),blue=0, green=0, alpha=0.5)) ; palette()
plot(1:10, col=1:10, pch=19, cex=2)

palette('default')
