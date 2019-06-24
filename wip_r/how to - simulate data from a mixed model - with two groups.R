###########################################################################################################
###########################################################################################################

# How to - simulate data from a mixed model

###########################################################################################################
###########################################################################################################

# Example using random intercept and random slope

# - iid N(0,sigma^2) errors
# - random effects uncorrelated, each coming from N(0,1)

mmdata <- function(m=10, n=10, xlim=c(0,1), beta=list(c(1,-2),c(-1,2)), sigma=0.1, sigma_u=list(c(0.1,0.1), c(0.1,0.1))){
    
    # m = number of observations per subject
    # n = number of subjects
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
    
    # error covariance matrix
    Sigma <- diag(rep(sigma^2, m)) ; Sigma[1:5, 1:5] ; dim(Sigma)
    
    # list to store results 
    K <- length(beta) ; K # number of groups
    
    results <- vector("list", K)
    
    sub.id <- 0
    
    for(grp in 1:K){ # grp=1
        
        # list to store results 
        results.temp <- vector("list", K)
        
        # covariance matrix for the random effects
        G <- diag(sigma_u[[grp]]) ; G
        
        # for each subject in the dive type
        for(sub in 1:n){ # sub=1
            
            sub.id <- sub.id + 1
            
            # random effects (sigma argument to rmvnorm must be a COVARIANCE matrix)
            u_i <- t(rmvnorm(1, mean=rep(0,q), sigma=G)) ; u_i ; dim(u_i) 
            
            # group mean y
            Ey0_i <- as.matrix(X_i %*% beta[[grp]]) ; head(Ey0_i) ; dim(Ey0_i)
            
            # subject mean y
            Ey1_i <- as.matrix(Ey0_i + Z_i %*% u_i) ; head(Ey1_i) ; dim(Ey1_i)
            
            # errors
            e_i <- t(rmvnorm(1, mean=rep(0,m), sigma=Sigma)) ; head(e_i) ; dim(e_i)
            
            # observed y
            y_i <- Ey1_i + e_i ; head(y_i) ; dim(y_i)
            
            # store Y_ij and EY_ij
            results.temp[[sub]] <- data.frame(y=y_i, x=x, group=grp, subject=sub.id, Ey0=Ey0_i, Ey1=Ey1_i, e=e_i)
            
        }
        
        results[[grp]] <- do.call("rbind", results.temp)
        
    }
    
    results <- do.call("rbind", results)

    results$group <- as.character(results$group)
    results$subject <- as.character(results$subject)
    
    attr(results, "pars") <- list(beta=beta, sigma=sigma, sigma_u=sigma_u)
    
    attr(results, "settings") <- list(n.groups=K, n.subjects.per.group=n, n.measurements.per.subject=m, xlim=xlim)
    
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
    xyplot(y ~ x, groups=subject, data=results)
    xyplot(Ey1 ~ x, groups=subject, data=results, type="l")

    xyplot(y ~ x | group, groups=subject, data=results)
    xyplot(Ey1 ~ x | group, groups=subject, data=results, type="l")

    # define your own colours and overlay
    xyplot(y ~ x | group, groups=subject, data=results,
           panel = function(x, y, groups, subscripts){
               panel.xyplot(x, y, col=my.colours[subscripts])
               panel.xyplot(x, results$Ey1[subscripts], groups=groups, subscripts=subscripts, col=my.colours[subscripts], type="l")
               panel.xyplot(x, results$Ey0[subscripts], groups=groups, subscripts=subscripts, col=1, lwd=2, type="l")
           }
    )

    ###########################################################################################################
    
    # plot data using ggplot2 - so much easier!
    
    require(ggplot2)
    
    main <- ggplot(results, aes(x,y, group=subject, colour=as.factor(group))) + theme_bw() + theme(legend.position="none", panel.grid.major=element_blank(), plot.title=element_text(lineheight=.8, face="bold")) + ggtitle("Mixed model data") + scale_colour_manual(values=c("blue","red"))
    
    main + geom_point()
    
    main + geom_line(aes(x,Ey1))
    
    main + geom_point() + geom_line(aes(x,Ey1))
    
    main + geom_point() + geom_line(aes(x,Ey1)) + facet_wrap(~group)
    
    main + geom_point() + geom_line(aes(x,Ey1)) + geom_line(aes(x,Ey0), col=1, lwd=1) + facet_wrap(~group) 
    
}

###########################################################################################################
###########################################################################################################