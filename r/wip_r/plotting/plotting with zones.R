# PLotting with zones and layouts
zones <- matrix(c(1,2,3,4,5,6),ncol=3,byrow=T)
zones
layout(zones, widths=c(3/5,1,1,3/5,1,1),heights=c(1/2,1/2,1/2,1/2,1/2,1/2)); layout.show(6)
par(mar=c(4,4,0,0))

zones <- matrix(c(1,2,3,3),ncol=2,byrow=F)
zones
layout(zones, widths=c(1/3,1/3,1,1),heights=c(1/2,1/2,1,1)); layout.show(3)
par(mar=c(4,4,0,0))

zones <- matrix(c(1,2,3,4,4,4),ncol=3,byrow=T)
zones
layout(zones, widths=c(1/3,1/3,1,1),heights=c(1/2,1/2,1,1)); layout.show(4)
par(mar=c(4,4,0,0))

zones <- matrix(c(1,2,3,4,4,4,5,6,6),ncol=3,byrow=T)
zones
layout(zones, widths=c(1/4,1/4,1,1,1/3,1/2),heights=c(1/2,1/2,1,1,1/3,1/3)); layout.show(6)
par(mar=c(4,4,0,0))
#zone1
plot(c(1:5), c(1:5), bty="n", type="n", xaxt="n", yaxt="n", col="black", ylim=c(1,5), xlim=c(1,5), ylab="", xlab="") 
text(x=3, y=2, labels="lindesay", cex=1)
#zone2
plot(c(1:5), c(1:5), bty="n", type="n", xaxt="n", yaxt="n", col="black", ylim=c(1,5), xlim=c(1,5), ylab="", xlab="") 
text(x=3, y=2, labels="lindesay", cex=1)
#zone3
plot(c(1:5), c(1:5), bty="n", type="n", xaxt="n", yaxt="n", col="black", ylim=c(1,5), xlim=c(1,5), ylab="", xlab="") 
text(x=3, y=2, labels="lindesay", cex=1)
#zone4
plot(c(1:5), c(1:5), bty="n", type="n", col="black", ylim=c(1,5), xlim=c(1,5), ylab="", xlab="") 
text(x=3, y=2, labels="lindesay", cex=1)
#zone5
plot(c(1:5), c(1:5), bty="n", type="n", col="black", ylim=c(1,5), xlim=c(1,5), ylab="", xlab="") 
text(x=3, y=2, labels="lindesay", cex=1)
#zone6
plot(c(1:5), c(1:5), bty="n", type="n", col="black", ylim=c(1,5), xlim=c(1,5), ylab="", xlab="") 
text(x=3, y=2, labels="lindesay", cex=1)

