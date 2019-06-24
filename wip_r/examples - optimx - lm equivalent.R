################################################################################
################################################################################

# Examples - optimx - fitting a simple linear model

################################################################################
################################################################################

require(optimx)

# Data

n <- 100
x <- sample(0:100, n, TRUE)
z <- sample(0:100, n, TRUE)
B <- c(1,2,3)
sd <- 0.1
y <- rnorm(n, B[1]+B[2]*x+B[3]*z, sd)
plot(x, y)
plot(z, y)

# lm fit
lm(y ~ 1)
lm(y ~ x)
lm(y ~ z)
lm(y ~ x + z)

# Likelihood function
negloglik <- function(y, X, pars){
    
    p <- nrow(X)
    
    mu <- X %*% pars[1:p]
    
}    
    
# Fitting function
lm.optim <- function(model=call(), data){
    
    model = y ~ x
    
    attr(model, "term.labels")
    
    data = data.frame(x=x, y=y, z=z)
    
    if(!exists(data)) stop("data argument required")
    
    if(class(data)!="data.frame") stop("data must be a data frame")

    model.terms <- terms(model) ; model.terms
    
    model.frame(model)

    model.frame(model, data)
    
    attr(model.frame(model, data), "terms")

    model.response(model.frame(model, data))

    y <- model.response(model, "numeric") ; y
    
    
    if(is.null(data)) data <- 
    
    model.matrix(, data=)
    
    optimx(par = pars,
           fn = negloglik,
           y = y,
           X = X
           )    
    
}


a <- model.frame(cbind(ncases,ncontrols) ~ agegp + tobgp + alcgp, data = esoph)
model.extract(a, "response")
stopifnot(model.extract(a, "response") == model.response(a))

a <- model.frame(ncases/(ncases+ncontrols) ~ agegp + tobgp + alcgp,
                 data = esoph, weights = ncases+ncontrols)
model.response(a)
model.extract(a, "weights")

a <- model.frame(cbind(ncases,ncontrols) ~ agegp,
                 something = tobgp, data = esoph)
names(a)
stopifnot(model.extract(a, "something") == esoph$tobgp)




################################################################################
################################################################################