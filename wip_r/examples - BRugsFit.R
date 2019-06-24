######################################################################################
# BRugsFit - simple example
######################################################################################

# BRugs needs the latest version of OPenBUGS to be installed

# The code below was written with 
# - R version 2.15.1
# - OpenBUGS 3.2.2
# - BRugs 0.8-0
# - coda 0.15-2

require(BRugs) 
sessionInfo()

setwd("~/Dropbox/Resources/Applications/R/Examples")

# simulate some data
n <- 100
y <- rnorm(n, 2, 2)

# write a text file containing the model code
modelFile = "bugsModel.txt"

write("model{

# Priors:
  mu ~ dnorm(0.001,0.001)
  sigma ~ dgamma(0.01,0.01)

# Likelihood:
  for(i in 1:n){ 
    y[i] ~ dnorm(mu,tau) 
  }

# Definitions:
  tau <- 1/pow(sigma,2)

}", file = modelFile)

# store data and inits in lists
dataList = list(y=as.numeric(y), n=as.numeric(n))
initsList = list(list(mu=0, sigma=1),
                 list(mu=0, sigma=1))
# NB inits list needs to be a list of lists - each sub list is for a separate chain

# look at summary
BRugsResults <- BRugsFit(modelFile        = modelFile,
                         data             = dataList,
                         inits            = initsList,
                         numChains        = 2,
                         parametersToSave = c("mu","sigma"),
                         nBurnin          = 1000, 
                         nIter            = 5000, 
                         nThin            = 10, 
                         coda             = TRUE,
                         BRugsVerbose     = FALSE)

class(BRugsResults) # can therefore use any of the functions from the code package
methods(class="mcmc.list")

summary(BRugsResults)

# Plots
plot(BRugsResults)

xyplot(BRugsResults)
densityplot(BRugsResults)

acfplot(BRugsResults)
autocorr.diag(BRugsResults)

op <- par(mfrow=c(1,2))
  traceplot(BRugsResults)
  densplot(BRugsResults)
par(op)

# BGR (you may want to set nBurnin = 0 before you use this)
gelman.diag(BRugsResults)
gelman.plot(BRugsResults)


###################################################################################

# Can do a more step-by-step approach which may help with debugging

modelCheck(modelFile)
dataFile = "bugsData.txt"
bugsData(data = dataList, fileName = dataFile)
modelData(dataFile)
modelCompile()
initsFile = "bugsInits.txt"
bugsInits(inits = initsList, numChains = 1, fileName = initsFile)
modelInits(initsFile)
samplesSet(c("mu","sigma"))
modelUpdate(1000)
samplesStats('*')

# clean up
file.remove(c(modelFile, dataFile, initsFile))

###################################################################################
###################################################################################

