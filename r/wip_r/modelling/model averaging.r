##############################################################################
##############################################################################

# Model averaging example

##############################################################################
##############################################################################

require(MuMIn)
require(car)

setwd("~/Teaching/Workshops/Statistical Modelling/2013 Cork/Participant/data")

EIA <- read.csv("EIA.csv")

attach(EIA)

model <- lm(count ~ month + time + wind_strength + visibility + impact + gridcode)

# save dredge results
dredge.results <- dredge(model)

head(dredge.results)

dredge.results[dredge.results$delta < 2,]

dredge.results[cumsum(dredge.results$weight) <= 0.95,]

# extract the models you want to average over
# get.models creates a list of models from an object created by the dredge function

# e.g. all models
dredge.models <- get.models(dredge.results)

# e.g. models with delta less than 2
dredge.models <- get.models(dredge.results, subset = delta < 2)

# e.g. models with cumulative weight less than or equal to 0.95
dredge.models <- get.models(dredge.results, subset = cumsum(weight) <= 0.95)

# look at the highest ranking model (if you want to)
Anova(dredge.models[[1]])
AICc(dredge.models[[1]])

# get model averaged predictions
preds <- predict(model.avg(dredge.models))
preds[1:10]

# as above but also with standard errors for predictions
preds <- predict(model.avg(dredge.models), se=TRUE)
preds$fit[1:10]
preds$se.fit[1:10]

##############################################################################
##############################################################################