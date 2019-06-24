################################################################################
################################################################################

# Brownian motion

if(0){
    
    N <- 100
    
    res <- data.frame(x=rep(NA, N), y=NA, dist=NA, angle=NA)
    
    res$x[1] <- res$y[1] <- 0
    
    for(t in 2:N){
        
        res$theta[t] <- runif(1, 0, 2*pi) ; res$theta[t]/(2*pi)*360
        
        res$dist[t] <- abs(rnorm(1)) ; res$dist[t]
        
        dx <- sin(res$theta[t]) * res$dist[t] ; dx
        
        dy <- cos(res$theta[t]) * res$dist[t] ; dy
        
        res$x[t] <- res$x[t-1] + dx ; res$x[t] 
        
        res$y[t] <- res$y[t-1] + dy ; res$y[t] 
        
    }
    
    with(res, {
        
        plot(x, y, type="n")
        
        arrows(x0=x[-N], x1=x[-1], y0=y[-N], y1=y[-1], length=0.1, col="grey")
        
        points(x, y, pch=19, cex=0.5)
        
        points(x[1], y[1], pch=19, cex=1.5, col=4)
        
    })
    
}

################################################################################
################################################################################

# correlated motion

if(1){
    
    require(mvtnorm)
    
    N <- 100
    
    rho <- 0.99
    
    sigma <- 1
    
    delta.time <- outer(1:N, 1:N, function(x,y) abs(x-y)) ; delta.time[1:10,1:10] ; dim(delta.time)
    
    cor <- rho ^ delta.time ; cor[1:10,1:10] ; dim(cor)
    
    var <- sigma * diag(N) ; var[1:10,1:10] ; dim(var)
    
    cov <- sqrt(var) %*% cor %*% sqrt(var) ; cov[1:10,1:10] ; dim(cov)
    
    x <- rmvnorm(1, sigma = cov)
    
    # plot(as.numeric(x), type="l", ylim=c(-3,3))
    # 
    # abline(h=0, col=4)
    
    y <- rmvnorm(1, sigma = cov)
    
    plot(x, y, type="n", xlim=c(-3,3), ylim=c(-3,3))
    
    arrows(x0=x[-N], x1=x[-1], y0=y[-N], y1=y[-1], length=0.1, col="grey")
    
    points(x, y, pch=19, cex=0.5)
    
    points(0, 0, pch=19, cex=1.5, col=4)
    
}

################################################################################
################################################################################