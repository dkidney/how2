# What about this: http://en.wikibooks.org/wiki/Data_Mining_Algorithms_In_R/Clustering/Expectation_Maximization_(EM)#A_simple_example

# I had also written a simple example in (edit)R a year ago, unfortunately I am unable to locate it. I'll try again to find it later.

# EDIT: Here it is -

### Read file, get necessary cols 

n <- 100

mu.true <- c(0,10)

group <- sample(1:2, n, replace=TRUE)

y <- rnorm(n, mu.true[group])

plot(y) ; abline(h=mu.true)

p1 <- 0.5

mu <- c(0,0)

### Init ### 
max.count <- 10
count <- 1 

while (count <= max.count){
    
    # what is gamma? The expected value of p?
    gamma <- p1 * dnorm(y, mu[1]) / 
        ( (1 - p1) * dnorm(y, mu[2]) + p1 * dnorm(y, mu[1]) ) ; gamma
    
    # estimates given 
    mu[1] <- sum((gamma) * y) / sum(gamma) ; mu[1]

    mu[2] <- sum((1 - gamma) * y) / sum(1 - gamma) ; mu[2]
    
    p1  <- sum(gamma) / n ; p1

    if (count == 1) {
        
        prevmu <- mu
        
    }else{ 
        
        val <- sqrt(sum(prevmu - mu)^2) ; val
        
        if (val <= 1) break

    }
    
    count <- count + 1

} 

newgroup <- ifelse(gamma > 0.5, 1, 2)

points(y, col=newgroup, pch=19) ; abline(h=mu, col=1:2)


