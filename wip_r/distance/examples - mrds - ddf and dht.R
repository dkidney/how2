#################################################################################################################
#################################################################################################################

# Examples - mrds

#################################################################################################################
#################################################################################################################

rm(list=ls())
source("~/Resources/R/My functions/R functions/sourceFolder.r")
sourceFolder("~/Resources/R/My functions/R functions")
requireMultiplePackages(c("spatialkernel", "mrds", "mgcv"))
source("~/Resources/R/Hacks/hack - dht.r")

#################################################################################################################
#################################################################################################################

# study region

xlim <- ylim <- c(0, 1000) # units in meters

A <- diff(xlim) * diff(ylim) / 1000^2 ; A # area of study region (square km)

#----------------------------------------------------------------------------------------------------------------

# transects

K <- 10 # number of transects

transect.utm.x <- seq(xlim[1] + diff(xlim)/K/2, xlim[2], diff(xlim)/K) ; transect.utm.x # transect x-coordinates

L <- K * diff(ylim) ; L # total line length (m)

w <- diff(xlim) / K / 2 / 2 ; w # right truncation distance (m)

l_trunc <- w * 0 ; l_trunc # left truncation distance (m)

a <- L * 2 * w / 1000^2 ; a # covered area (square km) - does NOT consider left truncation

#----------------------------------------------------------------------------------------------------------------

# simulated population

locations <- NULL ; N <- 0

while(N < 1000){
    
    x = runif(1, xlim[1], xlim[2])
    y = runif(1, ylim[1], ylim[2])

    if(rbinom(1, 1, prob=y/diff(range(ylim)))){
        locations <- rbind(locations, data.frame(x=x, y=y))
        N <- N + 1
    }
    
} ; head(locations) ; dim(locations)

# cluster sizes
size.mean <- 2
size <- sample(1:3, N, replace=TRUE)

# true density of clusters (number of individuals per square km)
D_clusters <- N / A ; D_clusters

# true density of individuals (number of individuals per square km)
D_individuals <- D_clusters * size.mean ; D_individuals 

#----------------------------------------------------------------------------------------------------------------

# true underlying detection function

sigma <- 10
curve(exp(-0.5*(x/sigma)^2), ylim=c(0,1), xlim=c(0,w)) ; abline(v = c(l_trunc, w), lwd=2, lty=2, col="grey")

# true p including left truncation
p_true <- ( pnorm(w, 0, sigma) - pnorm(l_trunc, 0, sigma) ) / ( dnorm(0,0,sigma) * w ) ; p_true

#----------------------------------------------------------------------------------------------------------------

# detections

distances <- sapply(1:K, function(i) abs(transect.utm.x[i]-locations$x)) ; head(distances) ; dim(distances) # cols = transects

capthist <- sapply(1:K, function(i) rbinom(N,1,exp(-0.5*((distances[,i])/sigma)^2))) ; head(capthist) ; dim(capthist) # cols = transects

capthist[which(distances>w, arr.ind=TRUE)] <- 0 # truncate at w

detected <- which(apply(capthist,1,sum) > 0) ; head(detected) # index of detected clusters

n_clusters <- length(detected) ; n_clusters # number of detected clusters 

#----------------------------------------------------------------------------------------------------------------

# plot

plot(locations, type="n")
for(i in 1:length(transect.utm.x)) polygon(x=c(transect.utm.x[i]-w, transect.utm.x[i]-w, transect.utm.x[i]+w, transect.utm.x[i]+w), y=c(min(xlim), max(xlim), max(xlim), min(xlim)), col="grey95")
abline(v=transect.utm.x, col=4, lwd=2)
points(locations, cex=size/2)
points(locations[detected,], cex=size[detected]/2, pch=19, col=2)

#################################################################################################################
#################################################################################################################

# information tables

detection_index <- which(capthist==1, arr.ind=TRUE) ; colnames(detection_index) <- c("animal", "transect") ; head(detection_index) ; dim(detection_index)
detection_index <- detection_index[order(detection_index[,"animal"]),] ; head(detection_index) ; dim(detection_index)

obs.table <- data.frame( 
    
    Region.Label= "region.1",
    Sample.Label= paste("transect", detection_index[,"transect"], sep="."),
    object      = 1:n_clusters,
    observer    = 1,
    detected    = 1,
    distance    = distances[detection_index],                           
    size        = sample(1:3, n_clusters, replace=TRUE),
    utm.x       = locations$x[detected],
    utm.y       = locations$y[detected]
    
) ; head(obs.table)

#----------------------------------------------------------------------------------------------------------------
transect.table <- data.frame( 
    
    Region.Label= "region.1",
    Sample.Label= paste("transect", 1:K, sep="."),
    Effort      = rep(diff(range(ylim)), K),
    start.utm.x = transect.utm.x,
    start.utm.y = min(ylim),
    stop.utm.x  = transect.utm.x,
    stop.utm.y  = max(ylim)
    
) ; transect.table

#----------------------------------------------------------------------------------------------------------------
region.table <- data.frame(
    
    Region.Label= "region.1", 
    Area        = A
    
) ; region.table

#################################################################################################################
#################################################################################################################

# ddf - fitting detection function

ddf_hn <- ddf(dsmodel   = ~ cds(key = "hn"),
              data      = obs.table,
              method    = "ds",
              meta.data = list(binned   = FALSE,
                               width    = w, 
                               left     = l_trunc) 
)

ddfSummary(ddf_hn, a, A)

summary(ddf_hn)$n ; n_clusters # sample size - number of clusters after BOTH left and right trucation

summary(ddf_hn)$aic # AIC

# plot
plot(ddf_hn)
curve(exp(-0.5*(x/sigma)^2), col=4, lwd=2, add=TRUE) # blue is true

#################################################################################################################
#################################################################################################################

# dht

# need to convert units because sample effort is measured in m and region area is measured in km^2
dht_hn_transects <- dht(model          = ddf_hn, 
              region.table   = region.table, 
              sample.table   = transect.table, 
              obs.table      = obs.table, 
              options        = list(group = FALSE,
                                    convert.units = 1/1000^2
              )
)

dhtSummary(dht_hn_transects)

dht_hn_transects$individuals$summary$Effort ; L # total transect length
dht_hn_transects$individuals$summary$CoveredArea ; a # covered area - AFTER right truncation (i.e. includes the area accounted for by left truncation)

#----------------------------------------------------------------------------------------------------------------

# estimates by sample

# clusters

head(dht_hn_transects$clusters$bysample)

dht_hn_transects$clusters$bysample$n # sample sizes - number of clusters in each transect after BOTH left and right trucation 
sum(dht_hn_transects$clusters$bysample$n) ; summary(ddf_hn)$n 

dht_hn_transects$clusters$bysample$Nchat # estimated number of clusters within each transect
sum(dht_hn_transects$clusters$bysample$Nchat) ; ddfSummary(ddf_hn)["cluster.abundance.covered","estimate"] 

dht_hn_transects$clusters$bysample$Nhat # estimated number of clusters within each section of the study area
sum(dht_hn_transects$clusters$bysample$Nhat) ; sum(dht_hn_transects$clusters$bysample$Nchat) * A/a 

dht_hn_transects$clusters$bysample$Dhat # estimated density of clusters within each section of the study area
dht_hn_transects$clusters$bysample$Nchat / (dht_hn_transects$clusters$bysample$Effort * 2 * w / 1000^2)
sum(dht_hn_transects$clusters$bysample$Dhat * dht_hn_transects$clusters$bysample$Effort / sum(dht_hn_transects$clusters$bysample$Effort))
dhtSummary(dht_hn_transects)["cluster.density.per.sq.km","estimate"] 

# individuals

dht_hn_transects$individuals$bysample

dht_hn_transects$individuals$bysample$Nchat # estimated abundance of individuals within each transect

dht_hn_transects$individuals$bysample$Sample.Area # area of each transect

#################################################################################################################
#################################################################################################################

# Density surface

transect.table <- transect.table[order(transect.table$Sample.Label),]

plotTransects(transect.table)
points(obs.table$utm.x, obs.table$utm.y, pch=19, col=as.numeric(obs.table$Sample.Label))

segment.table <- segmentTransects(transect.table, w=w) ; head(segment.table) ; dim(segment.table)
plotSegments(segment.table)

new.obs.table <- assignSegments(segment.table, obs.table) ; head(new.obs.table) ; dim(new.obs.table)

points(new.obs.table$utm.x, new.obs.table$utm.y,
       pch = ifelse(is.na(new.obs.table$segment.number), 1, 19), 
       col = ifelse(is.na(new.obs.table$segment.number), 1, new.obs.table$segment.number)
)

dht_hn_segments <- dht(model          = ddf_hn, 
                       region.table   = region.table, 
                       sample.table   = segment.table, 
                       obs.table      = new.obs.table, 
                       options        = list(group = FALSE,
                                             convert.units = 1/1000^2
                       )
)

dhtSummary(dht_hn_transects)
dhtSummary(dht_hn_segments)

head(dht_hn_segments$individuals$bysample)

# check Sample column in the dht output is in the same order as Sample.Label in segment.table
segment.table <- segment.table[order(segment.table$Sample.Label),]
all(as.character(segment.table$Sample.Label) == as.character(dht_hn_segments$individuals$bysample$Sample))

# check segment area
(2*w)^2/1000^2

segment.table$segment.Nhat <- dht_hn_segments$individuals$bysample$Nchat
segment.table$segment.area.sq.km <- dht_hn_segments$individuals$bysample$Sample.Area # area of each transect
head(segment.table)

# fit a gam
dsm.gam1 <- gam(segment.Nhat ~ s(centre.x, centre.y), family=poisson, offset=log(segment.area.sq.km), data=segment.table) ; dsm.gam1
dsm.gam2 <- gam(segment.Nhat ~ s(centre.x) + s(centre.y), family=poisson, offset=log(segment.area.sq.km), data=segment.table) ; dsm.gam2
dsm.gam3 <- gam(segment.Nhat ~ s(centre.x) + centre.y, family=poisson, offset=log(segment.area.sq.km), data=segment.table) ; dsm.gam3
dsm.gam4 <- gam(segment.Nhat ~ centre.x + s(centre.y), family=poisson, offset=log(segment.area.sq.km), data=segment.table) ; dsm.gam4
dsm.gam5 <- gam(segment.Nhat ~ centre.x + centre.y, family=poisson, offset=log(segment.area.sq.km), data=segment.table) ; dsm.gam5

vis.gam(dsm.gam5, view = c("centre.x","centre.y"), type="response", plot.type="contour", xlab="longitude", ylab="latitude", main="Estimated density")

#################################################################################################################
#################################################################################################################
#################################################################################################################
#################################################################################################################
