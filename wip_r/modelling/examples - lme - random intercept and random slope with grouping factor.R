###################################################################################################################################################################################################################################
# PRACTICE WITH LME
###################################################################################################################################################################################################################################

rm(list=ls())
require(mvtnorm)
require(nlme)
require(Matrix)
require(ggplot2)

###################################################################################################################################################################################################################################
# Simulated data

# - random intercept and random slope
# - two groups: red and blue

n = 10    # number of observations per subject
K = 25    # number of subjects per group
N = K * n # total number of observations
p = 2     # number of fixed effects
q = 2     # number of random effects

x = seq(-10, 10, length=n) # x-axis for each subject

# Fixed effect coefficients:
b1 = 20 # mean intercept for blue group
b2 = 5 # mean slope for blue group
r1 = 0 # mean intercept for red group
r2 = 0 # mean slope for red group

# Random effect variances etc.:
sd.b1 = 1  
sd.b2 = 2
cov.b1.b2 = 0.4 
sd.r1 = 2  
sd.r2 = 1 
cov.r1.r2 = 0.6 
sigma   = 0.1 

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Model components

B.b = as.matrix(c(b1,b2)) # a (p x 1) vector of fixed effect coefficients
B.r  = as.matrix(c(r1,r2)) # a (p x 1) vector of fixed effect coefficients

Xi = Zi = cbind(1,x)
X = NULL ; for(i in 1:K) X <- rbind(X,Xi)
blocks = list() ; for(i in 1:K) blocks[[i]] = Zi ; Z = bdiag(blocks)
R = sigma^2*diag(n)

G.b = matrix(c(sd.b1^2,cov.b1.b2,cov.b1.b2,sd.b2^2), nr=q, nc=q)
G.r = matrix(c(sd.r1^2,cov.r1.r2,cov.r1.r2,sd.r2^2), nr=q, nc=q)
cor.b1.b2 <- cov2cor(G.b)[1,2]
cor.r1.r2 <- cov2cor(G.r)[1,2]

u.b = rmvnorm(K, rep(0,q), G.b) ; u.b = matrix(t(u.b), nc=1)
e.b = rmvnorm(K, rep(0,n), R) ; e.b = matrix(t(e.b), nc=1)
y.b = as.numeric(X %*% B.b + Z %*% u.b + e.b)

u.r = rmvnorm(K, rep(0,q), G.r) ; u.r = matrix(t(u.r), nc=1)
e.r = rmvnorm(K, rep(0,n), R) ; e.r = matrix(t(e.r), nc=1)
y.r = as.numeric(X %*% B.r  + Z %*% u.r + e.r)

test = data.frame(y=c(y.b,y.r), x=x, subject=factor(rep(1:(2*K),each=n)), group=factor(rep(c("blue","red"),each=N)))
head(test) ; tail(test)
test[1:30,]

ggplot(test, aes(x,y, group=subject, colour=group)) + 
  geom_line() + 
  scale_colour_manual(values=c("blue", "red")) +
  theme(legend.position = "none")

###################################################################################################################################################################################################################################
# Fit with lme

model <- list()

test = groupedData(y ~ x | subject, data = test)

# same G matrix for each group
(model$m1 = lme(y ~ x*group, random = pdIdent(~x), data=test))
(model$m2 = lme(y ~ x*group, random = pdDiag(~x), data=test))
(model$m3 = lme(y ~ x*group, random = pdCompSymm(~x), data=test))
(model$m4 = lme(y ~ x*group, random = pdSymm(~x), data=test))

# get fitted values for the mean (level 0) or for each subject (level 1)
plot.fitted <- function(model){
  predictions <- fitted(model, level=0:1) ; colnames(predictions) <- c("level0","level1")
  predictions <- as.data.frame(cbind(test, predictions))
  ggplot(predictions, aes(x,y,group=subject,colour=group)) +
  geom_point(aes(x, y=y)) +
  geom_line(aes(x, y=level1)) +
  geom_line(aes(x, y=level0), colour="black", linetype="longdash", size=1) +
  scale_colour_manual(values=c("blue", "red")) +
  theme(legend.position = "none")
}

plot.fitted(model$m1)
plot.fitted(model$m2)
plot.fitted(model$m3)
plot.fitted(model$m4)

# different G matrix for each group
(model$m5 = lme(y ~ x*group, random = pdIdent(~x*group), data=test))
(model$m6 = lme(y ~ x*group, random = pdBlocked(list(pdIdent(~1), pdIdent(~-1+group))), data=test))

plot.fitted(model$m5)
plot.fitted(model$m6)

(AICs <- as.matrix(sapply(model,AIC)))

# make a dummy variable for each group
test <- within(test, r1 <- (group=="red")*1) ; head(test)
test <- within(test, r2 <- (group=="red")*x) ; head(test)
test <- within(test, b1 <- (group=="blue")*1) ; head(test)
test <- within(test, b2 <- (group=="blue")*x) ; head(test)

(model$m7 = lme(y ~ x*group, random = pdBlocked(list(pdIdent(~-1+r1+r2), pdIdent(~-1+b1+b2))), data=test))
(model$m8 = lme(y ~ x*group, random = pdBlocked(list(pdDiag(~-1+r1+r2), pdDiag(~-1+b1+b2))), data=test))
(model$m9 = lme(y ~ x*group, random = pdBlocked(list(pdCompSymm(~-1+r1+r2), pdCompSymm(~-1+b1+b2))), data=test))
(model$m10= lme(y ~ x*group, random = pdBlocked(list(pdSymm(~-1+r1+r2), pdSymm(~-1+b1+b2))), data=test))

plot.fitted(model$m7)
plot.fitted(model$m8)
plot.fitted(model$m9)
plot.fitted(model$m10)

(AICs <- as.matrix(sapply(model,AIC)))

# make nicer objects
b = cbind(1*(test$group=="blue"),x*(test$group=="blue")) ; head(b)
r = cbind(1*(test$group=="red"),x*(test$group=="red")) ; head(r)

#head(model.matrix(~-1+cbind(1,x):group, test))

(model$m11= lme(y ~ x*group, random = pdBlocked(list(pdSymm(~-1+b), pdSymm(~-1+r))), data=test))
(model$m11= lme(y ~ -1 + b + r, random = pdBlocked(list(pdSymm(~-1+b), pdSymm(~-1+r))), data=test))

(AICs <- as.matrix(sapply(model,AIC)))

# or just make your own design matrix
X <- model.matrix(~-1+cbind(1,x):group, test) ; colnames(X) = c("b1","b2","r1","r2")
(model$m12= lme(y ~ -1+X, random = pdBlocked(list(pdSymm(~-1+X[,1:2]), pdSymm(~-1+X[,3:4]))), data=test))
(AICs <- as.matrix(sapply(model,AIC)))

# chose best model
best <- model[[which.min(as.numeric(AICs))]] ; summary(best)

# extract objects of interest from best model
fixef(best) ; B   
best$sigma ; s   
getVarCov(best) ; G  

# get confidence intervals
intervals(best)
intervals(best)$fixed
intervals(best)$fixed
intervals(best)$reStruct$subject
intervals(best)$sigma

###################################################################################################################################################################################################################################
# Simulation

nsims = 100
par.names = c("b1","b2","r1","r2","sd.b1","sd.b2","cor.b1.b2","sd.r1","sd.r2","cor.r1.r2","sigma")
confint = matrix(NA,nr=nsims,nc=length(par.names), dimnames=list(sim=1:nsims, parameter=par.names))
#estimates = confint

for(sim in 1:nsims){ # sim=1
  u.b = rmvnorm(K, rep(0,q), G.b) ; u.b = matrix(t(u.b), nc=1)
  e.b = rmvnorm(K, rep(0,n), R) ; e.b = matrix(t(e.b), nc=1)
  y.b = as.numeric(X %*% B.b + Z %*% u.b + e.b)
  u.r = rmvnorm(K, rep(0,q), G.r) ; u.r = matrix(t(u.r), nc=1)
  e.r = rmvnorm(K, rep(0,n), R) ; e.r = matrix(t(e.r), nc=1)
  y.r = as.numeric(X %*% B.r  + Z %*% u.r + e.r)
  temp = data.frame(y=c(y.b,y.r), x=x, subject=factor(rep(1:(2*K),each=n)), group=factor(rep(c("blue","red"),each=N)))
  temp = groupedData(y ~ x | subject, data = temp)
  r = cbind(1*(test$group=="red"),x*(test$group=="red")) 
  b = cbind(1*(test$group=="blue"),x*(test$group=="blue")) 
  model = lme(y ~ x*group, random = pdBlocked(list(pdSymm(~-1+b), pdSymm(~-1+r))), method="REML", data=temp)
  ints <- try(intervals(model), silent=T)
  if(class(ints)!="try-error"){
#    estimates[sim,"b1"]        = ints$fixed[1,"est."]            
#    estimates[sim,"b2"]        = ints$fixed[2,"est."]            
#    estimates[sim,"r1"]        = ints$fixed[3,"est."]            
#    estimates[sim,"r2"]        = ints$fixed[4,"est."]            
#    estimates[sim,"sd.b1"]     = ints$reStruct$subject[1,"est."] 
#    estimates[sim,"sd.b2"]     = ints$reStruct$subject[2,"est."] 
#    estimates[sim,"cor.b1.b2"] = ints$reStruct$subject[3,"est."] 
#    estimates[sim,"sd.r1"]     = ints$reStruct$subject[4,"est."] 
#    estimates[sim,"sd.r2"]     = ints$reStruct$subject[5,"est."] 
#    estimates[sim,"cor.r1.r2"] = ints$reStruct$subject[6,"est."] 
#    estimates[sim,"sigma"]     = ints$sigma["est."]              
    confint[sim,"b1"]        = b1        > ints$fixed[1,"lower"]            & b1        < ints$fixed[1,"upper"]
    confint[sim,"b2"]        = b2        > ints$fixed[2,"lower"]            & b2        < ints$fixed[2,"upper"]
    confint[sim,"r1"]        = r1-b1     > ints$fixed[3,"lower"]            & r1-b1     < ints$fixed[3,"upper"]
    confint[sim,"r2"]        = r2-b2     > ints$fixed[4,"lower"]            & r2-b2     < ints$fixed[4,"upper"]
    confint[sim,"sd.b1"]     = sd.b1     > ints$reStruct$subject[1,"lower"] & sd.b1     < ints$reStruct$subject[1,"upper"]
    confint[sim,"sd.b2"]     = sd.b2     > ints$reStruct$subject[2,"lower"] & sd.b2     < ints$reStruct$subject[2,"upper"]
    confint[sim,"cor.b1.b2"] = cor.b1.b2 > ints$reStruct$subject[3,"lower"] & cor.b1.b2 < ints$reStruct$subject[3,"upper"]
    confint[sim,"sd.r1"]     = sd.r1     > ints$reStruct$subject[4,"lower"] & sd.r1     < ints$reStruct$subject[4,"upper"]
    confint[sim,"sd.r2"]     = sd.r2     > ints$reStruct$subject[5,"lower"] & sd.r2     < ints$reStruct$subject[5,"upper"]
    confint[sim,"cor.r1.r2"] = cor.r1.r2 > ints$reStruct$subject[6,"lower"] & cor.r1.r2 < ints$reStruct$subject[6,"upper"]
    confint[sim,"sigma"]     = sigma     > ints$sigma["lower"]              & sigma     < ints$sigma["upper"]
  }
  print(sim) ; flush.console()
}

#estimates
as.matrix(apply(confint,2,mean,na.rm=T))

###################################################################################################################################################################################################################################
###################################################################################################################################################################################################################################
