# ROTATE 3D PLOTS

require(rgl)
require(car)
#attach(iris)

# iris data
with(iris,{
plot3d(Sepal.Length, Petal.Length, Petal.Width, col=c("red", "green3", "blue")[as.numeric(Species)], type="s", size=1)
model1 <- lm(Petal.Width ~ Sepal.Length * Petal.Length)
print(Anova(model1))
n <- 10
x <- seq(min(Sepal.Length),max(Sepal.Length),length=n) ; x
y <- seq(min(Petal.Length),max(Petal.Length),length=n) ; y
grid <- expand.grid(x,y) ; grid
newdata <- data.frame(Sepal.Length=grid[,1], Petal.Length=grid[,2])
z <- matrix(predict(model1, newdata), ncol=n, byrow=F)
#z <- matrix(rep(mean(Petal.Width), 100), ncol=10) ; z
#surface3d(x,y,z,color="#FF2222",alpha=0.5)
#surface3d(x,y,z,color="#CCCCFF", alpha=0.5)
surface3d(x,y,z, alpha=0.5, col="grey50")
surface3d(x,y,z, back="lines", alpha=0.5, col=2, front="lines")
play3d(spin3d(axis=c(0,0,1), rpm=3), duration=60)
})

#detach(iris)
