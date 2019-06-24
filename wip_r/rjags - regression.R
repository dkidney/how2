################################################################################
################################################################################
## 
## rjags example code
##
## DK 05-01-2016
##
################################################################################
################################################################################

suppressPackageStartupMessages({
    require(rjags) 
})


# settings --------------------------------------------------------------

# nBurnin = 1000
# nIter = 5000
nBurnin = 10000
nIter = 90000
# nBurnin = 50000
# nIter = 500000
# nBurnin = 100000
# nIter = 10000000
nThin = 1
nChains = 1

run.bugs.check = 0

buffer = 2000

spacing = 100

M = 1000 # upper bound for N





# bugs check function -----------------------------------------------------

bugs.check = function(model.file, data, inits, parameters = c("N", "D","sigma"), nupdates = 1000){
    
    data.file = "temp_data.txt"
    inits.file = "temp_inits.txt"
    bugsData(data, data.file)
    bugsInits(inits, 1, inits.file)
    modelCheck(model.file)
    modelData(data.file)
    start.time = Sys.time()
    modelCompile()
    run.time = Sys.time() - start.time
    message("compile time: ", round(as.numeric(run.time)), " ", attr(run.time, "units"))
    modelInits(inits.file)
    samplesSet(parameters)
    start.time = Sys.time()
    modelUpdate(nupdates)
    run.time = difftime(Sys.time(), start.time, units = "mins") ; run.time
    print(samplesStats('*'))
    mins = 1000000 * as.numeric(run.time) / nupdates ; mins
    hours = mins / 60 ; hours
    message("Estimated run time per 1,000,000 iterations = ", round(mins), " mins / ", round(hours,1), " hours\n")
    samplesStats('*')
    
}


# gibbons data ------------------------------------------------------------

load("gibbons data.rda")
class(capthist)
n = dim(capthist)[1] ; n # number of groups
S = dim(capthist)[2] ; S # number of sampling occasions
K = dim(capthist)[3] ; K # number of detectors

# use 'units' to scale mask and sigma units - which by default are in metres
# e.g. units = 1/1000 converts m to km
units = 1/1000



# choose mask spacing ----------------------------------------------------

if(0){
    
    spacings = seq(500, 10, -10)
    temp = do.call(rbind, lapply(spacings, function(spacing){ # spacing = 250
        
        print(spacing)
        mask  = make.mask(traps(capthist), buffer = buffer, spacing = spacing)
        fit = suppressWarnings(secr.fit(capthist, mask = mask, fixed = list(g0 = 1), trace = FALSE))
        data.frame(
            D = predict(fit)["D","estimate"],
            sigma = predict(fit)["sigma","estimate"],
            AIC = AIC(fit)["AIC"],
            proctime = fit$proctime,
            row.names = NULL
        )
        
    }))
    
    temp
    
    jpeg("mask spacing.jpeg", width = 14, height = 14, units = "cm", pointsize = 8, family = "serif", res = 300, quality = 150)
    par(mfrow = c(2,2), mar = c(2,2,2,2), oma = c(0,0,0,0))
    for(i in colnames(temp)) plot(spacings, temp[,i], type = "l", main = i)
    dev.off()
    
}



# secr estimate ----------------------------------------------------------------

cat("\n", rep("-", options()$width), "\nsecr package:\n\n", sep = "")

mask  = make.mask(traps(capthist), buffer = buffer, spacing = spacing)
G = nrow(mask) ; G # number of mask points
a = attributes(mask)$area / 100 ; a # divide by 100 to convert ha to sq km
A = a * G ; A # total area of mask

xlim = range(attributes(mask)$boundingbox$x) ; xlim
ylim = range(attributes(mask)$boundingbox$y) ; ylim


start.time = Sys.time()
fit.secr = suppressWarnings(secr.fit(capthist, mask = mask, fixed = list(g0 = 1), start = c(log(1), log(1000)), trace = FALSE)) ; fit.secr
finish.time = Sys.time()
run.time = difftime(finish.time, start.time)
cat("Run time =", round(run.time,1), attr(run.time, "units"), "\n\n")
nsecs = as.numeric(difftime(finish.time, start.time, units = "secs")) ; nsecs
# # effective sampling area in km2
# esa = sum(pdot(mask, traps(capthist), detectpar = detectpar(fit.secr), noccasions = 1)) * a ; esa 
# p = esa / A ; p # probability of detection

par(mfrow = c(1,1), mar = c(1,1,1,1))
plot(xlim, ylim, type = "n", asp = 1, axes = FALSE, xlab = "", ylab = "")
rect(xlim[1], ylim[1], xlim[2], ylim[2], lty = 2)
plot(mask, add = TRUE)
plot(traps(capthist), add = TRUE)
pdot.contour(traps(capthist), detectpar = detectpar(fit.secr), noccasions = 1, add = TRUE)
title("secr.fit results")

summary.secr = c(
    N = predict(fit.secr)["D","estimate"] * 100 * A, # in sq km (not scaled by the number of arrays)
    sigma = predict(fit.secr)["sigma","estimate"] * units,
    #     esa = esa,
    #     p = p,
    nsecs = nsecs,
    esN = NA,
    esNpersec = NA
) 

# summary.secr["N"] = summary.secr["D"] * A ; summary.secr
# summary.secr = summary.secr[c("D","N","esa","sigma","nsecs")]
# summary.secr["sigma"] = summary.secr["sigma"] * units
print(summary.secr[c("N","sigma","nsecs")])

save(list = ls()[grepl("\\.secr$", ls())], file = "results - secr.rda")



# prep objects for bugs ---------------------------------------------------

# convert traps and mask into km units
traps = as.matrix(traps(capthist)) * units ; traps
mask = as.matrix(mask) * units ; head(mask)
xlim = xlim * units ; xlim
ylim = ylim * units ; ylim

N     = summary.secr["N"] ; N
D     = summary.secr["D"] ; D
sigma = summary.secr["sigma"] ; sigma

dist2 = rdist(mask, traps)^2 # squared distances from mask points to detectors (in km^2)
# capthist = capthist[,1,] # single occasion, so convert captist to (n x K) matrix
# maxSigma = 5 * sigma ; maxSigma # for use with uniform prior



# semi-complete 1 -----------------------------------------------------

cat("\n", rep("-", options()$width), "\nsemi-complete v1:\n\n", sep = "")

model.file.sc1 = "DK SC1 model file - gibbons - Nov 2014.txt" ; if(!file.exists(model.file.sc1)) stop("can't find SC1 model file")
data.sc1 = list(traps = traps, capthist = capthist, dist2 = dist2, xlim = xlim,  ylim = ylim, n = n, S = S, K = K, G = G, A = A, a = a, dummy = 0, prior = rep(1/(M-n+1), M-n+1))
inits.sc1 = list(n00 = round(N - n) + 1, sigma = sigma, X = runif(n, xlim[1], xlim[2]), Y = runif(n, ylim[1], ylim[2]))
# inits.sc1 = list(n00 = round(N - n) + 1, sigma = sigma, X = runif(n, xlim[1], xlim[2]), Y = runif(n, ylim[1], ylim[2]))
parameters.sc1 = c("N","sigma")

if(run.bugs.check){
    
    bugs.check(model.file.sc1, data.sc1, list(inits.sc1), parameters.sc1)
    
}else{
    
    jags.model.sc1 = jags.model(model.file.sc1, data.sc1, inits.sc1, nChains, nBurnin, quiet = FALSE)
    start.time = Sys.time()
    coda.samples.sc1 =  coda.samples(jags.model.sc1, parameters.sc1, nIter, nThin)
    finish.time = Sys.time()
    run.time = difftime(finish.time, start.time)
    cat("\nRun time =", round(run.time,1), attr(run.time, "units"), "\n\n")
    nsecs = as.numeric(difftime(finish.time, start.time, units = "secs")) ; nsecs
    effectiveSize.sc1 = lapply(coda.samples.sc1, effectiveSize)
    esN = sum(sapply(effectiveSize.sc1, function(x) x["N"])) ; esN
    esNpersec = mean(sapply(effectiveSize.sc1, function(x) x["N"]) / nsecs) ; esNpersec #samples per second
    #     summary(coda.samples.sc1)
    #     temp = do.call(c, lapply(coda.samples.sc1, function(x) x[,"N"]))
    #     density.sc1 = density(temp, n = max(temp), from = 1, to = max(temp))
    #     mode.sc1 = density.sc1$x[which(density.sc1$y == max(density.sc1$y))]
    #     par(mar = c(2,2,2,0), oma = c(0,0,0,0))
    #     plot(density.sc1, main = "Semi-complete v1 (N)") ; abline(v = mode.sc1, col = "grey")
    par(mar = c(2,2,2,0), oma = c(0,0,2,0))
    plot(coda.samples.sc1) ; title(main = "Semi-complete v1", outer = TRUE)
    
    if(nChains > 1){   
        bgr.sc1 = gelman.diag(coda.samples.sc1, transform = TRUE)
        bgr.sc1$psrf
        bgr.sc1$mpsrf
    }
    
    summary.sc1 = c(summary(coda.samples.sc1)[[2]][,"50%"], nsecs = nsecs, esN = esN, esNpersec = esNpersec)
    print(summary.sc1)
    
}

save(list = ls()[grepl("\\.sc1$", ls())], file = "results - SC.rda")



# semi-complete 2 -----------------------------------------------------

cat("\n", rep("-", options()$width), "\nsemi-complete v2:\n\n", sep = "")

model.file.sc2 = "DK SC2 model file - gibbons - Nov 2014.txt" ; if(!file.exists(model.file.sc2)) stop("can't find SC2 model file")
data.sc2 = list(traps = traps, capthist = capthist, dist2 = dist2, xlim = xlim,  ylim = ylim, n = n, S = S, K = K, G = G, A = A, a = a, dummy = 0)
inits.sc2 = list(n0 = round(N - n), sigma = sigma, X = runif(n, xlim[1], xlim[2]), Y = runif(n, ylim[1], ylim[2]))
# inits.sc2 = list(n0 = round(N - n), sigma = sigma, X = runif(n, xlim[1], xlim[2]), Y = runif(n, ylim[1], ylim[2]))
parameters.sc2 = c("N","sigma")

if(run.bugs.check){
    
    bugs.check(model.file.sc2, data.sc2, list(inits.sc2), parameters.sc2)
    
}else{
    
    jags.model.sc2 = jags.model(model.file.sc2, data.sc2, inits.sc2, nChains, nBurnin, quiet = FALSE)
    start.time = Sys.time()
    coda.samples.sc2 =  coda.samples(jags.model.sc2, parameters.sc2, nIter, nThin)
    finish.time = Sys.time()
    run.time = difftime(finish.time, start.time)
    cat("\nRun time =", round(run.time,1), attr(run.time, "units"), "\n\n")
    nsecs = as.numeric(difftime(finish.time, start.time, units = "secs")) ; nsecs
    effectiveSize.sc2 = lapply(coda.samples.sc2, effectiveSize)
    esN = sum(sapply(effectiveSize.sc2, function(x) x["N"])) ; esN
    esNpersec = mean(sapply(effectiveSize.sc2, function(x) x["N"]) / nsecs) ; esNpersec #samples per second
    #     summary(coda.samples.sc2)
    #     temp = do.call(c, lapply(coda.samples.sc2, function(x) x[,"N"]))
    #     density.sc2 = density(temp, n = max(temp), from = 1, to = max(temp))
    #     mode.sc2 = density.sc2$x[which(density.sc2$y == max(density.sc2$y))]
    #     par(mar = c(2,2,2,0), oma = c(0,0,0,0))
    #     plot(density.sc2, main = "Semi-complete v2 (N)") ; abline(v = mode.sc2, col = "grey")
    par(mar = c(2,2,2,0), oma = c(0,0,2,0))
    plot(coda.samples.sc2) ; title(main = "Semi-complete v2", outer = TRUE)
    
    if(nChains > 1){   
        bgr.sc2 = gelman.diag(coda.samples.sc2, transform = TRUE)
        bgr.sc2$psrf
        bgr.sc2$mpsrf
    }
    
    summary.sc2 = c(summary(coda.samples.sc2)[[2]][,"50%"], nsecs = nsecs, esN = esN, esNpersec = esNpersec)
    print(summary.sc2)
    
}

save(list = ls()[grepl("\\.sc2$", ls())], file = "results - SC.rda")



# data augmentation --------------------------------------------------

cat("\n", rep("-", options()$width), "\ndata augmentation:\n\n", sep = "")

psi = N / M ; cat("psi =", psi, "\n")
n0 = M - n ; cat("n0 =", n0, "\n")

model.file.da = "DK DA model file - gibbons - Nov 2014.txt" ; if(!file.exists(model.file.da)) stop("can't find DA model file")
data.da = list(traps = traps, capthist = abind(capthist, array(0, dim = c(n0, S, K)), along = 1), xlim = xlim, ylim = ylim, M = M, S = S, K = K)
inits.da = list(psi = psi, sigma = sigma, X = runif(M, xlim[1], xlim[2]), Y = runif(M, ylim[1], ylim[2]), z = c(rep(1,n), rbinom(n0, 1, psi)))
# inits.da = list(psi = psi, sigma = sigma, X = jitter(rep(mean(traps[,"x"]), M)), Y = jitter(rep(mean(traps[,"y"]), M)), z = c(rep(1,n), rbinom(n0, 1, psi)))
parameters.da = c("N","sigma")

if(run.bugs.check){
    
    bugs.check(model.file.da, data.da, list(inits.da), parameters.da)
    
}else{
    
    jags.model.da = jags.model(model.file.da, data.da, inits.da, nChains, nBurnin, quiet = FALSE)
    start.time = Sys.time()
    coda.samples.da =  coda.samples(jags.model.da, parameters.da, nIter, nThin)
    finish.time = Sys.time()
    run.time = difftime(finish.time, start.time)
    cat("\nRun time =", round(run.time,1), attr(run.time, "units"), "\n\n")
    nsecs = as.numeric(difftime(finish.time, start.time, units = "secs")) ; nsecs
    effectiveSize.da = lapply(coda.samples.da, effectiveSize)
    esN = sum(sapply(effectiveSize.da, function(x) x["N"])) ; esN
    esNpersec = mean(sapply(effectiveSize.da, function(x) x["N"]) / nsecs) ; esNpersec # samples per second
    #     summary(coda.samples.da)
    #     temp = do.call(c, lapply(coda.samples.da, function(x) x[,"N"]))
    #     density.da = density(temp, n = max(temp), from = 1, to = max(temp))
    #     mode.da = density.da$x[which(density.da$y == max(density.da$y))]
    #     par(mar = c(2,2,2,0), oma = c(0,0,0,0))
    #     plot(density.da, main = "Data augmentation (N)") ; abline(v = mode.da, col = "grey")
    par(mar = c(2,2,2,0), oma = c(0,0,2,0))
    plot(coda.samples.da) ; title(main = "Data augmentation", outer = TRUE)
    
    if(nChains > 1){   
        bgr.da = gelman.diag(coda.samples.da, transform = TRUE)
        bgr.da$psrf
        bgr.da$mpsrf
    }
    
    summary.da = c(summary(coda.samples.da)[[2]][,"50%"], nsecs = nsecs, esN = esN, esNpersec = esNpersec)
    print(summary.da)
    
}

save(list = ls()[grepl("\\.da$", ls())], file = "results - DA.rda")



# data augmentation - durban elston ----------------------------------------

cat("\n", rep("-", options()$width), "\ndata augmentation - durban elston:\n\n", sep = "")

psi = N/M ; cat("psi =", psi, "\n")
n0 = M - n ; cat("n0 =", n0, "\n")

model.file.dade = "DK DADE model file - gibbons - Nov 2014.txt" ; if(!file.exists(model.file.dade)) stop("can't find DADE model file")
data.dade = list(traps = traps, capthist = abind(capthist, array(0, dim = c(n0, S, K)), along = 1), xlim = xlim, ylim = ylim, M = M, n = n, S = S, K = K, dummy = 0, prior = rep(1/(M-n+1),(M-n+1)))
inits.dade = list(n00 = round(N - n) + 1, psi = psi, sigma = sigma, X1 = runif(M, xlim[1], xlim[2]),  X2 = runif(M, xlim[1], xlim[2]), Y1 = runif(M, ylim[1], ylim[2]), Y2 = runif(M, ylim[1], ylim[2]))
# inits.dade = list(n00 = round(N - n) + 1, psi = psi, sigma = sigma, X1 = jitter(rep(mean(traps[,"x"]), M)),  X2 = jitter(rep(mean(traps[,"x"]), M)), Y1 = jitter(rep(mean(traps[,"y"]), M)), Y2 = jitter(rep(mean(traps[,"y"]), M)))
parameters.dade = c("N","sigma")

if(run.bugs.check){
    
    bugs.check(model.file.dade, data.dade, list(inits.dade), parameters.dade)
    
}else{
    
    jags.model.dade = jags.model(model.file.dade, data.dade, inits.dade, nChains, nBurnin, quiet = FALSE)
    start.time = Sys.time()
    coda.samples.dade =  coda.samples(jags.model.dade, parameters.dade, nIter, nThin)
    finish.time = Sys.time()
    run.time = difftime(finish.time, start.time)
    cat("\nRun time =", round(run.time,1), attr(run.time, "units"), "\n\n")
    nsecs = as.numeric(difftime(finish.time, start.time, units = "secs")) ; nsecs
    effectiveSize.dade = lapply(coda.samples.dade, effectiveSize)
    esN = sum(sapply(effectiveSize.dade, function(x) x["N"])) ; esN
    esNpersec = mean(sapply(effectiveSize.dade, function(x) x["N"]) / nsecs) ; esNpersec # samples per second
    #     summary(coda.samples.dade)
    #     temp = do.call(c, lapply(coda.samples.dade, function(x) x[,"N"]))
    #     density.dade = density(temp, n = max(temp), from = 1, to = max(temp))
    #     mode.dade = density.dade$x[which(density.dade$y == max(density.dade$y))]
    #     par(mar = c(2,2,2,0), oma = c(0,0,0,0))
    #     plot(density.dade, main = "Data augmentation - Durban-Elston (N)") ; abline(v = mode.dade, col = "grey")
    par(mar = c(2,2,2,0), oma = c(0,0,2,0))
    plot(coda.samples.dade) ; title(main = "Data augmentation - Durban-Elston", outer = TRUE)
    
    if(nChains > 1){   
        bgr.dade = gelman.diag(coda.samples.dade, transform = TRUE)
        bgr.dade$psrf
        bgr.dade$mpsrf
    }
    
    summary.dade = c(summary(coda.samples.dade)[[2]][,"50%"], nsecs = nsecs, esN = esN, esNpersec = esNpersec)
    print(summary.dade)
    
}

save(list = ls()[grepl("\\.dade$", ls())], file = "results - DADE.rda")


#  ------------------------------------------------------------------------

if(!run.bugs.check){
    
    cat("\n", rep("-", options()$width), "\nsummary:\n\n", sep = "")
    
    cols = c("N","sigma","nsecs","esN","esNpersec")
    overall = rbind(
        secr = summary.secr[cols],
        sc1  = summary.sc1[cols],
        sc2  = summary.sc2[cols],
        da   = summary.da[cols],
        dade = summary.dade[cols]
    )
    colnames(overall) = cols
    print(round(overall,2))
    
}


## ************************************************************************** ##
## ************************************************************************** ##
## ************************************************************************** ##
## ************************************************************************** ##
