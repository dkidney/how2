rm(list=ls())
require(sabreR)

#set up response 1
x<- 1:100
a1<- 10
a2<- 8
k1<- 10/100
k2<- 2/100

dataForOutput<- c()

for( id in 1:10){
  
  u1<- rnorm(1, 0, 1)
  u2<- rnorm(1, 0, 0.05)
  
  mu1<- (a1+u1)*(1-exp(-k1*(x)))
  mu2<- (a2+u1)*(1-exp(-k2*(x)))
  mu3<- (0.01+u2)*x
  mu4<- (0.1+u2)*x
  
  error1<- rnorm(100, 0, 0.7)
  error2<- rnorm(100, 0, 0.7)
  
  error3<- rnorm(100, 0, 0.7)
  error4<- rnorm(100, 0, 0.7)
  
  y1<- mu1 + error1
  y2<- mu2 + error2
  y1<- c(y1[1:50], y2[51:100])
  
  y3<- mu3 + error3
  y4<- mu4 + error4
  y2<- c(y3[1:50], y4[51:100])
  
  
  data<-cbind(x,y1,y2, id)
  dataForOutput<- rbind(dataForOutput, data)
  
}


dataForOutput<- data.frame(dataForOutput)
names(dataForOutput)<- c("x", "y1","y2" ,"id")

plot(dataForOutput$x,dataForOutput$y1, col="grey", pch=20,
     xlab="Time", ylab="Response 1")
for(i in 1:10){
  lines(dataForOutput$x[dataForOutput$id==i],
        dataForOutput$y1[dataForOutput$id==i], col=i)}

plot(dataForOutput$x,dataForOutput$y2, col="grey", pch=20,
     xlab="Time", ylab="Response 2")
for(i in 1:10){
  lines(dataForOutput$x[dataForOutput$id==i],
        dataForOutput$y2[dataForOutput$id==i], col=i)}

dataForOutput$obs<- 1:1000
rm(x,y1,y2,id)
attach(dataForOutput)
require(splines)
b<- bs(dataForOutput$x, knots=c(50))
b1<- b[,1]
b2<- b[,2]
b3<- b[,3]
b4<- b[,4]

hist(y1)
hist(y2)
#fit <- sabre(y1 ~ x, y2 ~ x, case=id, first.family="gaussian", second.family="gaussian", adaptive.quad=T) ; fit$lfit.estimates.print.message
#fit <- sabre(y1 ~ bs(x,knots=5), y2 ~ x, case=id, first.family="gaussian", second.family="gaussian", adaptive.quad=T) ; fit$lfit.estimates.print.message
#fit <- sabre(y1 ~ bs(x,knots=5), y2 ~ bs(x,knots=5), case=id, first.family="gaussian", second.family="gaussian", adaptive.quad=T) ; fit$lfit.estimates.print.message
#fit <- sabre(y1 ~ bs(x,knots=c(5,10)), y2 ~ bs(x,knots=c(5,10)), case=id, first.family="gaussian", second.family="gaussian", adaptive.quad=T) ; fit$lfit.estimates.print.message
#fit <- sabre(y1 ~ bs(x,knots=c(10,20)), y2 ~ bs(x,knots=c(10,20)), case=id, first.family="gaussian", second.family="gaussian", adaptive.quad=T) ; fit$lfit.estimates.print.message
#fit <- sabre(y1 ~ bs(x,knots=c(10,20,30)), y2 ~ bs(x,knots=c(10,20,30)), case=id, first.family="gaussian", second.family="gaussian", adaptive.quad=T) ; fit$lfit.estimates.print.message
#fit <- sabre(y1 ~ bs(x,knots=10*1:4), y2 ~ bs(x,knots=10*1:4), case=id, first.family="gaussian", second.family="gaussian", adaptive.quad=T) ; fit$lfit.estimates.print.message
#fit <- sabre(y1 ~ bs(x,knots=10*1:5), y2 ~ bs(x,knots=10*1:5), case=id, first.family="gaussian", second.family="gaussian", adaptive.quad=T) ; fit$lfit.estimates.print.message
#fit <- sabre(y1 ~ bs(x,knots=10*1:6), y2 ~ bs(x,knots=10*1:6), case=id, first.family="gaussian", second.family="gaussian", adaptive.quad=T) ; fit$lfit.estimates.print.message
#fit <- sabre(y1 ~ bs(x,knots=10*1:7), y2 ~ bs(x,knots=10*1:7), case=id, first.family="gaussian", second.family="gaussian", adaptive.quad=T) ; fit$lfit.estimates.print.message
#fit <- sabre(y1 ~ bs(x,knots=10*1:8), y2 ~ bs(x,knots=10*1:8), case=id, first.family="gaussian", second.family="gaussian", adaptive.quad=T) ; fit$lfit.estimates.print.message
fit <- sabre(y1 ~ bs(x,knots=10*1:9), y2 ~ bs(x,knots=10*1:9), case=id, first.family="gaussian", second.family="gaussian", adaptive.quad=T) ; fit$lfit.estimates.print.message

# function to extract parameter estimates from sabre model
require(gdata)
get.sabre.estimates <- function(fit){
  x = fit$lfit.estimates.print.message
  results = NULL
  for(i in seq(1,length(x)-1)[-c(1,2)]){
    line = strsplit(x[i], " ")[[1]]
    results = rbind(results, line[which(nchar(line)!=0)])
  }
  results = matrix(as.numeric(results[,-1]), nc=3, dimnames=list(results[,1],c("Estimate","Std.Err.","Z-score")))
  return(results)
}
estimates = get.sabre.estimates(fit) ; estimates
B1 <- as.matrix(estimates[1:12,1]) ; B1
B2 <- as.matrix(estimates[13:24,1]) ; B2
X <- cbind(1,bs(x,knots=10*1:8)) ; head(X) ; dim(X)

# fitted values for y1
plot(dataForOutput$x,dataForOutput$y1, col="grey", pch=20,
     xlab="Time", ylab="Response 1")
for(i in 1:10){
  lines(dataForOutput$x[dataForOutput$id==i],
        dataForOutput$y1[dataForOutput$id==i], col=i)}
title("Response 1")
lines(x[1:100], (X%*%B1)[1:100,], lwd=5, lty=2)

# fitted values for y2
plot(dataForOutput$x,dataForOutput$y2, col="grey", pch=20,
     xlab="Time", ylab="Response 2")
for(i in 1:10){
  lines(dataForOutput$x[dataForOutput$id==i],
        dataForOutput$y2[dataForOutput$id==i], col=i)}
title("Response 2")
lines(x[1:100], (X%*%B2)[1:100,], lwd=5, lty=2)
