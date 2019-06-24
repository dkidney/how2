###########################################################################################################
###########################################################################################################

# How to - simulate data from a mixed model

###########################################################################################################
###########################################################################################################

# Example using random intercept and random slope

# - iid N(0,sigma^2) errors
# - random effects uncorrelated, each coming from N(0,1)

mmdata <- function(m=10, n=10, xlim=c(0,1), beta.vec=c(1,1), sigma=0.1, sigma_u=0.1){
    
    # m = number of observations per subject
    # n= number of subjects
    # sigma = error standard deviation
    # sigma_u = standard deviation of random effects
    
    # continuous covariate
    x <- seq(xlim[1], xlim[2], length=m) ; x
    
    
    # Design matrix for the fixed effects for a single individual
    X_i <- cbind(1,x) ; head(X_i)
    p <- ncol(X_i) ; p
    
    # Design matrix for the random effects for a single individual
    Z_i <- X_i ; head(Z_i)
    q <- ncol(Z_i) ; q
    
    # covariance matrix for the random effects
    G <- diag(rep(sigma_u^2, q)) ; G
    
    # error covariance matrix
    Sigma <- diag(rep(sigma^2, m)) ; Sigma[1:5, 1:5] ; dim(Sigma)
    
    # list to store results 
    results <- vector("list", n)
    
    # for each subject in the dive type
    for(i in 1:n){ # i=1
        
        # random effects (sigma argument to rmvnorm must be a COVARIANCE matrix)
        u_i <- t(rmvnorm(1, mean=rep(0,q), sigma=G)) ; u_i ; dim(u_i) # this returns a matrix with m rows and p ncols
        
        # expected y
        Ey_i <- as.matrix(X_i %*% beta.vec + Z_i %*% u_i) ; head(Ey_i) ; dim(Ey_i)
        
        # errors
        e_i <- t(rmvnorm(1, mean=rep(0,m), sigma=Sigma)) ; head(e_i) ; dim(e_i)
        
        # observed y
        y_i <- Ey_i + e_i ; head(y_i) ; dim(y_i)
        
        # store Y_ij and EY_ij
        results[[i]] <- data.frame(y=y_i, x=x, subject=i, Ey=Ey_i, e=e_i)
        
    }
    
    results <- do.call("rbind", results)
    
    attr(results, "pars") <- list(beta=beta.vec, sigma=sigma, sigma_u=sigma_u)
    
    attr(results, "settings") <- list(m=m, n=n, xlim=xlim)

    return(results)
    
}

###########################################################################################################
###########################################################################################################

# plot data using lattice

if(0){
    
    require(mvtnorm)
    require(lattice)
    
    results <- mmdata() ; head(results) ; tail(results) ; dim(results)
    
    # simple examples
    xyplot(y ~ x | subject, data = results)
    xyplot(Ey ~ x | subject, data = results, type="l")
    
    xyplot(y ~ x | subject, group = subject, data = results)
    xyplot(Ey ~ x | subject, group = subject, data = results, type="l")
    
    xyplot(y ~ x, group = subject, data = results)
    xyplot(Ey ~ x, group = subject, data = results, type="l")
    
    # plot groups on the same panel and overlay a different variable
    xyplot(y ~ x, groups = subject, data = results,
           panel = function(x, y, ...){
               panel.xyplot(x, y, ...)
               panel.superpose(x, results$Ey, type="l", ...)
           }
    )
    
    # this is the same as the above, but shows arguments explicitly
    xyplot(y ~ x, groups = subject, data = results,
           panel = function(x, y, groups, subscripts){
               panel.xyplot(x, y, groups=groups, subscripts=subscripts)
               panel.superpose(x, results$Ey, type="l", groups=groups, subscripts=subscripts)
           }
    )
    
    # plot groups on different panels and overlay a different variable
    xyplot(y ~ x | subject, data = results,
           panel = function(x, y, subscripts){
               panel.xyplot(x, y)
               panel.xyplot(x, results$Ey[subscripts], type="l")
           }
    )
    
    # plot groups on different panels and overlay a different variable, using the groupings to set the colour
    xyplot(y ~ x | subject, groups = subject, data = results,
           panel = function(x, y, subscripts, groups){
               panel.xyplot(x, y, groups=groups, subscripts=subscripts)
               panel.xyplot(x, results$Ey[subscripts], type="l", groups=groups, subscripts=subscripts)
           }
    )
    
    ###########################################################################################################
    
    # plot data using ggplot2 - so much easier!
    
    require(ggplot2)
    
    main <- ggplot(results, aes(x,y, colour=as.factor(subject))) + theme_bw() + theme(legend.position="none", panel.grid.major = element_blank(), plot.title = element_text(lineheight=.8, face="bold")) + ggtitle("Mixed model data")
    
    main + geom_point()
    
    main + geom_line(aes(x,Ey))
    
    main + geom_point() + geom_line(aes(x,Ey))
    
    main + geom_point() + geom_line(aes(x,Ey)) + facet_grid(~subject)
    
    main + geom_point() + geom_line(aes(x,Ey)) + facet_wrap(~subject)
    
    main + geom_point() + geom_line(aes(x,Ey)) + facet_wrap(~subject)
    
}

###########################################################################################################
###########################################################################################################