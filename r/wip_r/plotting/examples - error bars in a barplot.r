

pretend <- 1:5

names(pretend) <- letters[1:5] ; pretend

x <- barplot(pretend, ylim=c(0,6), col="green", xlab="Letter", ylab="Value", 
             main="How to make error bars on a barplot") ; x

lower <- seq(0.5, 4.5) ; lower
upper <- seq(1.5, 5.5) ; upper

arrows(x0=x, y1=upper, y0=lower, x1=x, length=0.1, code=3, col="red", angle=90)

points(x, pretend, pch=19, col="blue")
