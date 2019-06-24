
inv.sqrtm <- function(A){
    
    A.eigen <- eigen(A)
    
    if(all(A.eigen$values>0)){
        
        A.sqrt <- A.eigen$vectors %*% diag(sqrt(A.eigen$values)) %*% t(A.eigen$vectors)
        
    }else{
        
        stop("Matric must be positive semi-definite")
        
    }
    
    return(solve(A.sqrt))
    
}

# Testing

if(0){
    
    require(rbenchmark)
    
    n <- 5
    
    A <- matrix(rnorm(n^2), nr=n) ; A
    
    inv.sqrtm(A)

    A <- matrix(0.2, nc=n, nr=n) ; diag(A) <- 1 ; A
    
    inv.sqrtm(A)
    
    require(pracma)

    sqrtm(A)$Binv
    
    benchmark(inv.sqrtm(A),
              denman.beavers(A)$sqrt.inv,
              sqrtm(A)$Binv,
              columns = c("test", "relative", "elapsed", "replications"), order = "relative")
    
    detach("package:pracma")

    require(expm)
    
    solve(sqrtm(A))
    
    benchmark(inv.sqrtm(A),
              solve(sqrtm(A)),
              columns = c("test", "relative", "elapsed", "replications"), order = "relative")
    
    
}
