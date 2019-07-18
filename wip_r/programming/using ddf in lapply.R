## ************************************************************************** ##
## ************************************************************************** ##
## ************************************************************************** ##
## ************************************************************************** ##

# Hi Dave

# Here's an example of a problem I've had trying to run a bunch of models using ddf

# WOuld be good to know:
# i) why it throws an error
# ii) if there's a less messy way to do it

# rm(list = ls())

require(mymrds)

n = 30

data = data.frame(distances = rnorm(n), object = 1:n, observer = 1, detected = 1)

# an arbitrary covariate
data$x1 = runif(n) 

# candidate key functions
keys = c("hn", "hr")

# candidate formulas for the scale paramter
formulas = c("~1", "~x1")

# an index of all possible models
model = expand.grid(key = keys, formula = formulas, stringsAsFactors = FALSE) ; model

key = model[,"key"]
formula = model[,"formula"]

nmodels = nrow(model) ; nmodels

# this works fine
ddf(~mcds(formula[1], key[1]), data = data)

# But I'd like an automated way of fitting all model combinations
# and I'd rather use an apply function so I can parallelize it

# using lapply in the following way doesn't work:
ddf.fits = lapply(1:nmodels, function(i){
    
    ddf(~mcds(formula[i], key[i]), data = data)
    
})

# but this does work:
ddf.fits = lapply(1:nmodels, function(i){
    
    dsmodel = eval(expression(~mcds(formula[i], key[i])))

    ddf(dsmodel, data = data)

})


# What's going on?

# Cheers, 

# Darren (19 Dec 2013)

## ************************************************************************** ##
## ************************************************************************** ##
## ************************************************************************** ##
## ************************************************************************** ##




















