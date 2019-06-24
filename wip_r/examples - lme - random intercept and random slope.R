################################################################################
################################################################################

# Code to generate data from a mixed model : random intercept and slope

################################################################################
################################################################################

require(mvtnorm)
require(Matrix)
require(ggplot2)
require(nlme)

nsubs <- 20 # number of subjects 
nobs  <- 10 # number of observations per subject 

xlim <- c(0,1) # limits of x-axis

# Fixed effect parameters
p <- 2       # the number of fixed effects
Beta_0 <- 2 # population mean for intercept
Beta_1 <- 10  # population mean for slope
Beta <- c(Beta_0, Beta_1)

# Random effect parameters
q   <- 2   # the number of random effects
s00 <- 2   # standard deviation of random intercepts 
s11 <- 1   # standard deviation of random slopes
c01 <- 0.5 # correlation between random intercepts and random slopes
s   <- 0.1 # standard deviation of residuals

# Covariance matrix for random effects
var.mat <- diag(c(s00, s11)^2) ; var.mat
cor.mat <- matrix(c01, nc=q, nr=q) ; diag(cor.mat) <- 1 ; cor.mat
Psi <- sqrt(var.mat) %*% cor.mat %*% sqrt(var.mat) ; Psi

# Covariance matrix for errors
Sigma <- s^2 * diag(nobs) ; Sigma


#-------------------------------------------------------------------------------
# Method 1: simulate data for each subject separately

data <- vector("list", nsubs)

for(i in 1:nsubs){
    
    x.i <- runif(nobs, xlim[1], xlim[2]) ; x.i # x-axis values for subject i

    X.i = cbind(1,x.i) # an nobs by p design matrix for the fixed effects

    Z.i = X.i # an nobs by q design matrix for the random effects

    b.i = t(rmvnorm(1, rep(0,q), Psi)) # a q-vector of random effects = c(rane.i0, ranef.i1)

    e.i = t(rmvnorm(1, rep(0,nobs), Sigma)) # a n-vector of residuals
    
    Ey.i = X.i %*% Beta + Z.i %*% b.i # an n-vector of expected values

    y.i <- Ey.i + e.i # an n-vector of observed values

    data[[i]] <- data.frame(y=y.i, x=x.i, subject=paste(i), Ey=Ey.i)
    
}

data <- do.call("rbind", data)

head(data) ; dim(data) ; str(data)

ggplot(data, aes(x,y, group=subject, col=subject)) + geom_point() + geom_line(aes(x,Ey)) + theme(legend.position = "none")

# fit with lme
fit.lme <- lme(y ~ x, random = ~ x|subject, data=data, method="ML")  
fit.lme
intervals(fit.lme) # a useful way to extract parameter estimates

# alternative fits with lm
fit.lm1 <- lm(y ~ x, data)
fit.lm2 <- lm(y ~ x + subject, data)

# compare models
anova(fit.lme, fit.lm1, fit.lm2)


#-------------------------------------------------------------------------------
# Method 2: simulate data for all subjects simulateously

x <- runif(nobs * nsubs, xlim[1], xlim[2])

X <- cbind(1,x) ; dim(X)
    
subject <- factor(rep(1:nobs,each=nsubs))

Z <- vector("list", nsubs)

for(i in 1:nsubs) Z[[i]] <- X[subject==i,]

Z <- bdiag(Z) ; Z[1:30,1:6] ; dim(Z)

b <- rmvnorm(nsubs, rep(0,q), Psi) ; b ; dim(b)

# the b matrix isn't in the right form for use in a mixed model
# we want a vector c(b[1,1], b[1,2], b[2,1], b[2,2], b[3,1], ...)

b <- matrix(t(b), nc=1) ; head(b) ; dim(b)

e <- rmvnorm(nsubs, rep(0,nobs), Sigma) ; e ; dim(e)

# again we need the errors as a vector (or a 1-column matrix)

e <- matrix(t(e), nc=1) ; head(e) ; dim(e)

Ey <- X %*% Beta + Z %*% b ; head(Ey) ; dim(Ey)

y <- Ey + e ; head(y) ; dim(y)

data <- data.frame(y=as.numeric(y), x=x, subject=subject, Ey=as.numeric(Ey))

head(data) ; dim(data) ; str(data)

ggplot(data, aes(x,y, group=subject, col=subject)) + geom_point() + geom_line(aes(x,Ey)) + theme(legend.position = "none")

# fit with lme
fit.lme <- lme(y ~ x, random = ~ x|subject, data=data, method="ML")  
fit.lme
intervals(fit.lme) 

# alternative fits with lm
fit.lm1 <- lm(y ~ x, data)
fit.lm2 <- lm(y ~ x + subject, data)

# compare models
anova(fit.lme, fit.lm1, fit.lm2)


################################################################################
################################################################################