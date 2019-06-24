
n <- 10
x <- y <- seq(-3,3,length=n)
g <- expand.grid(x=x,y=y)

mu <- 0:1
sd <- 1:2

myData <- NULL

for(m in mu){
    for(s in sd){
        d = c(dnorm(g$x, mean=m, sd=s) * dnorm(g$y, mean=m, sd=s))
        myData <- rbind(myData, data.frame(y1=g$x, y2=g$y, density=d, mu=paste("mu =",m), sd=paste("sd =",s)))
    }
}

require(ggplot2)
      
ggplot(data = myData, mapping = aes(x = y1, y = y2, fill=density)) + geom_tile() + 
    facet_grid(mu ~ sd) +
    scale_fill_gradient(low="red", high="yellow")
