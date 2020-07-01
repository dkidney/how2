################################################################################
################################################################################

# Examples - debugging

################################################################################
################################################################################

# debug()

# marks a function for debugging, so that browser() will be called on entry

silly <- function(x){
    
    y <- sqrt(x)
    
    z <- log(x)
    
    condition <- y == TRUE
    
    if(condition) y else z
    
}

silly(3)

silly(-1)

traceback()

debug(silly)

silly(-1)

undebug(silly)

silly(-1)

silly2 <- function(x) if(sqrt(x)) x else log(x)

silly2(-1)

traceback()



################################################################################

# traceback()

# allows you to see where an error occured
# prints a list of functions that were called before the error occurred
# functions printed in reverse order
# doesn't tell you where the error occurred

f <- function(x) x-g(x) 

g <- function(y) y*h(y)

h <- function(z) {
    r <- log(z)
    if(r<10)
        r^2
    else
        r^3
}

f(-1)

log(-1)

traceback()

debug(f)

f(-1)

undebug(f)

## compute sum of squares
SS <- function(mu, x) {
    d <- x - mu
    d2 <- d^2
    ss <- sum(d2)
    ss
}

set.seed(100)
x <- rnorm(100)
SS(1, x)
debug(SS)
SS(1, x)
undebug(SS)




################################################################################

# recover()

################################################################################

# trace()

# modifies a function to allow debug code to be temporarily inserted

################################################################################

# browser()

# allows you to single step through the execution of an R function

h<-function(z) {
    browser() ## a break point inserted here
    r<-log(z)
    if(r<10)
        r^2
    else
        r^3
}

f(-1)


################################################################################
################################################################################