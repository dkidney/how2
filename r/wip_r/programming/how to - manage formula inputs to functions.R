
test <- function (sub.models = list(sigma = ~ 1, p.available = ~ 1, surface = ~ 1), data){

    sm <- sub.models
    
    X <- list()
    
    for(i in 1:length(sm)) X[[names(sm)[i]]] <- model.matrix(sm[[i]], data)
    
    return(X)
    
}

if(0){
    
    n <- 5
    
    dat <- data.frame(size=rnorm(n), sex=sample(letters[1:2], n, TRUE), time=1:n) ; dat
    
    test() # need to specify a data frame

    test(data=dat)

    test(sub.models = list(sigma        = ~ size,
                           p.available  = ~ sex,
                           surface      = ~ 1),
         data=dat)

    test(sub.models = list(sigma        = ~ size * sex,
                           p.available  = ~ size + sex + time,
                           surface      = ~ size * time),
         data=dat)
    
}
