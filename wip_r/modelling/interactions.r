##############################################################################
##############################################################################

# Interactions

##############################################################################
##############################################################################

setwd("~/Teaching/Workshops/Statistical Modelling/2013 Cork/Participant/data")

EIA <- read.csv("EIA.csv")

attach(EIA)

head(EIA)

pairs(EIA[,c("wind_strength","cloud_cover","visibility","impact","count")])

##############################################################################

# one continuous covariate and one factor with two levels

plot(visibility, count)

plot(visibility, count, col=c("blue","red")[as.factor(impact)], cex=0.5, pch=19)

lm(count ~ impact + visibility)




##############################################################################
##############################################################################
