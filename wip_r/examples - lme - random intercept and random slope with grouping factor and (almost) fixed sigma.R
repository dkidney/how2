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

n = 10        # number of observations per subject
K = 20        # number of subjects per group
M = 2         # number of groups
N = K * n * M # total number of observations per group
p = 2         # number of fixed effects
q = 2         # number of random effects

x = seq(-10, 10, length=n) # x-axis for each subject

# Fixed effect coefficients:
Beta0 = c(20,0) # mean intercepts groups 1 and 2
Beta1 = c(10,0) # mean slopes for groups 1 and 2

# Random effect covariance parameters:
sd.Beta0 = c(1,sqrt(2)) # stDev of random effects for intercept for groups 1 and 2
sd.Beta1 = c(sqrt(2),1) # stDev of random effects for slope for groups 1 and 2
cor.Beta = c(0,0)   # correlation of random intercept and random slope for groups 1 and 2

# residual covariace parameters - compound symmetry
sd.res = c(1,1)  # stDev of residuals for groups 1 and 2
phi = rep(0,2) # AR1 correlation parameter for groups 1 and 2

#----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
# Model components

Beta = G = R = list()

for(m in 1:M){ # m=1
  Beta[[paste("B (Group ",m,")",sep="")]] = matrix(c(Beta0[m],Beta1[m]), dimnames=list(c("Beta0","Beta1"),NULL))
  varMat = diag(c(sd.Beta0[m],sd.Beta1[m])^2) ; varMat
  corMat = matrix(cor.Beta[m], nc=q, nr=q) ; diag(corMat) = 1 ; corMat
  G[[paste("G (Group ",m,")",sep="")]] = sqrt(varMat) %*% corMat %*% sqrt(varMat)
  varMat = diag(n)*sd.res[m]^2 ; varMat
#  corMat = matrix(cor.res[m], nc=n, nr=n) ; diag(corMat) = 1 ; corMat
  corMat = phi[m]^abs(outer(1:n,1:n,"-")) ; corMat
  R[[paste("R (Group ",m,")",sep="")]] = sqrt(varMat) %*% corMat %*% sqrt(varMat)
}

#Beta
#G
#lapply(G, 'cov2cor')
#R
#lapply(R, 'cov2cor')

Xi = Zi = cbind(1,x) ; Xi
group = factor(sample(rep(1:M, each=K),replace=F)) ; group

y = NULL
for(i in 1:length(group)){ # i=1
  ui = rmvnorm(1, rep(0,q), G[[group[i]]]) ; ui = matrix(t(ui), nc=1) ; ui
  ei = rmvnorm(1, rep(0,n), R[[group[i]]]) ; ei = matrix(t(ei), nc=1) ; ei
  yi = as.numeric(Xi %*% Beta[[group[i]]] + Zi %*% ui + ei) ; yi
  y = append(y,yi)
}

test = data.frame(      y = y,
                        x = x,
                  subject = factor(rep(1:length(group),each=n)),
                    group = rep(group,each=n),
                    sigma = sd.res[1]) ; test[1:60,]

ggplot(test, aes(x,y, group=subject, colour=group)) + 
  geom_line() + 
  scale_colour_manual(values=c("blue", "red")) +
  theme(legend.position = "none")


###################################################################################################################################################################################################################################

# Fit with lme

# using the model matrix method

X = cbind(1, test$x) ; head(X) ; X[1:60,]
X = model.matrix(~-1+X:group, test) ; colnames(X) = c("Beta0.g1","Beta1.g1","Beta0.g2","Beta1.g2") ; X[1:60,]

test = groupedData(y ~ -1 + X | subject, data = test)

blocked.covMat = function(pd.class){
  formula.list = list()
  for(m in 1:M) formula.list[[m]] = eval(parse(text=paste(pd.class,"(~-1+X[,",2*(m-1)+1,":",m*2,"])",sep="")))
  return(pdBlocked(formula.list))
}

model <- list()

(model$m1 = lme(y ~ -1 + X,
                random = blocked.covMat("pdSymm"),
                data = test))

(model$m2 = lme(y ~ -1 + X,
                random = blocked.covMat("pdSymm"),
                weight = varFixed(~sigma^2),
                data = test))
intervals(model$m2)
intervals(model$m2)$sigma

(AICs <- as.matrix(sapply(model,AIC)))


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


###################################################################################################################################################################################################################################
# Simulation

nsims = 100
par.names = c("Beta0.g1","Beta1.g1","Beta0.g2","Beta1.g2",
              "sd.Beta0.g1","sd.Beta1.g1","cor.Beta.g1",
              "sd.Beta0.g2","sd.Beta1.g2","cor.Beta.g2",
              "phi","var.ratio","sd.res.g2")
confint = matrix(NA,nr=nsims,nc=length(par.names), dimnames=list(sim=1:nsims, parameter=par.names))
#estimates = confint

for(sim in 1:nsims){ # sim=1
  y = NULL
  for(i in 1:length(group)){ # i=1
    ui = rmvnorm(1, rep(0,q), G[[group[i]]]) ; ui = matrix(t(ui), nc=1) ; ui
    ei = rmvnorm(1, rep(0,n), R[[group[i]]]) ; ei = matrix(t(ei), nc=1) ; ei
    yi = as.numeric(Xi %*% Beta[[group[i]]] + Zi %*% ui + ei) ; yi
    y = append(y,yi)
  }
  test = data.frame(y=y, x=x, subject=factor(rep(1:length(group),each=n)), group=rep(group,each=n)) ; test[1:60,]
  test = groupedData(y ~ -1 + X | subject, data = test)
  m0 = lme(y ~ -1 + X, random=blocked.covMat("pdSymm"), correlation=corAR1(form=~1), weight=varIdent(form=~1|group), data=test)
  ints = try(intervals(m0), silent=T)
  if(class(ints)!="try-error"){
#    estimates[sim,"Beta0.g1"]    = ints$fixed[1,"est."]            
#    estimates[sim,"Beta1.g1"]    = ints$fixed[2,"est."]            
#    estimates[sim,"Beta0.g2"]    = ints$fixed[3,"est."]            
#    estimates[sim,"Beta1.g2"]    = ints$fixed[4,"est."]            
#    estimates[sim,"sd.Beta0.g1"] = ints$reStruct$subject[1,"est."] 
#    estimates[sim,"sd.Beta1.g1"] = ints$reStruct$subject[2,"est."] 
#    estimates[sim,"cor.Beta.g1"] = ints$reStruct$subject[3,"est."] 
#    estimates[sim,"sd.Beta0.g2"] = ints$reStruct$subject[4,"est."] 
#    estimates[sim,"sd.Beta1.g2"] = ints$reStruct$subject[5,"est."] 
#    estimates[sim,"cor.Beta.g2"] = ints$reStruct$subject[6,"est."] 
#    estimates[sim,"phi"]         = ints$corStruct[1,"est."] 
#    estimates[sim,"var.ratio"]   = ints$varStruct[1,"est."]               
#    estimates[sim,"sd.res.g2"]   = ints$sigma["est."]              
    confint[sim,"Beta0.g1"]    = Beta[[1]][1] > ints$fixed[1,"lower"]            & Beta[[1]][1] < ints$fixed[1,"upper"]
    confint[sim,"Beta1.g1"]    = Beta[[1]][2] > ints$fixed[2,"lower"]            & Beta[[1]][2] < ints$fixed[2,"upper"]
    confint[sim,"Beta0.g2"]    = Beta[[2]][1] > ints$fixed[3,"lower"]            & Beta[[2]][1] < ints$fixed[3,"upper"]
    confint[sim,"Beta1.g2"]    = Beta[[2]][2] > ints$fixed[4,"lower"]            & Beta[[2]][2] < ints$fixed[4,"upper"]
    confint[sim,"sd.Beta0.g1"] = sd.Beta0[1]  > ints$reStruct$subject[1,"lower"] & sd.Beta0[1]  < ints$reStruct$subject[1,"upper"]
    confint[sim,"sd.Beta1.g1"] = sd.Beta1[1]  > ints$reStruct$subject[2,"lower"] & sd.Beta1[1]  < ints$reStruct$subject[2,"upper"]
    confint[sim,"cor.Beta.g1"] = cor.Beta[1]  > ints$reStruct$subject[3,"lower"] & cor.Beta[1]  < ints$reStruct$subject[3,"upper"]
    confint[sim,"sd.Beta0.g2"] = sd.Beta0[2]  > ints$reStruct$subject[4,"lower"] & sd.Beta0[2]  < ints$reStruct$subject[4,"upper"]
    confint[sim,"sd.Beta1.g2"] = sd.Beta1[2]  > ints$reStruct$subject[5,"lower"] & sd.Beta1[2]  < ints$reStruct$subject[5,"upper"]
    confint[sim,"cor.Beta.g2"] = cor.Beta[2]  > ints$reStruct$subject[6,"lower"] & cor.Beta[2]  < ints$reStruct$subject[6,"upper"]
    confint[sim,"phi"]         = phi[1]       > ints$corStruct[1,"lower"]        & phi[1]       < ints$corStruct[1,"upper"]
    confint[sim,"var.ratio"]   = varRatio     > ints$varStruct[1,"lower"]        & varRatio     < ints$varStruct[1,"upper"]
    confint[sim,"sd.res.g2"]   = sd.res[2]    > ints$sigma["lower"]              & sd.res[2]    < ints$sigma["upper"]
  }
  print(sim) ; flush.console()
}

#estimates
as.matrix(apply(confint,2,mean,na.rm=T))

###################################################################################################################################################################################################################################
###################################################################################################################################################################################################################################
