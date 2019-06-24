
# trnearpd

require(mvtnorm)
require(Matrix)

Sigma <- diag(10)

diag(Sigma[-1,]) <- diag(Sigma[,-1]) <- 0.9

diag(Sigma[-(1:2),]) <- diag(Sigma[,-(1:2)]) <- 0.7

diag(Sigma[-(1:3),]) <- diag(Sigma[,-(1:3)]) <- 0.5

Sigma

dmvnorm(rep(0, 10), rep(0, 10), Sigma) 

pdSigma <- as.matrix(nearPD(Sigma)$mat) ; pdSigma

dmvnorm(rep(0, 10), rep(0, 10), pdSigma)