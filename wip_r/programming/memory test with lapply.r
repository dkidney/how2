################################################################################
################################################################################

n = 1000

N = 1e5

#-------------------------------------------------------------------------------
# matrix

gc()[2,2]/gc()[2,4]

# memory in use: 1.5 GB

results = t(sapply(1:n, function(i){
    
    if(i %% 100 == 0) print(i)
    
    cbind(a = rnorm(N),
          b = rnorm(N),
          c = rnorm(N))
        
}))

gc()[2,2]/gc()[2,4]

# memory in use: 3.7 GB

rm(results)

# memory in use: 3.7 GB

gc()[2,2]/gc()[2,4]

# memory in use: 2.0 GB

#-------------------------------------------------------------------------------
# data frame

gcinfo(TRUE)

gc()[2,2]/gc()[2,4]

# memory in use: 1.5 GB

results = lapply(1:n, function(i){
    
    if(i %% 100 == 0) print(i)
    
    data.frame(a = rnorm(N),
               b = rnorm(N),
               c = rnorm(N))
    
})

gc()[2,2]/gc()[2,4]

# memory in use: 3.7 GB

rm(results)

# memory in use: 3.7 GB

gc()[2,2]/gc()[2,4]

# memory in use: 1.5 GB

#-------------------------------------------------------------------------------
# data.frame inside a list

# memory in use: 1.5 GB

results = lapply(1:n, function(i){ 
    
    print(i)
    
    list(
        
        data.frame(a = rnorm(N),
                   b = rnorm(N),
                   c = rnorm(N))
        
    )
    
})

# memory in use: 3.6 GB

rm(results)

# memory in use: 3.6 GB

gc()

# memory in use: 1.5 GB


#-------------------------------------------------------------------------------
# speed

d1 = function(n){
    
    do.call(rbind, lapply(1:n, function(i){
        
        do.call(rbind, lapply(1:n, function(i){
            
            data.frame(a = 1, b = 1, c = 1)
            
        }))
        
    }))
    
} 

d2 = function(n){
    
    do.call(rbind, lapply(1:n, function(i){
        
        t(sapply(1:n, function(i){
            
            data.frame(a = 1, b = 1, c = 1)
            
        }))
        
    }))
    
} 

s1 = function(n){
    
    do.call(rbind, lapply(1:n, function(i){
        
        do.call(rbind, lapply(1:n, function(i){
            
            c(a = 1, b = 1, c = 1)
            
        }))
        
    }))
    
} 

s2 = function(n){
    
    do.call(rbind, lapply(1:n, function(i){
        
        t(sapply(1:n, function(i){
            
            c(a = 1, b = 1, c = 1)
            
        }))
        
    }))
    
}

n = 10

all(as.matrix(s1(5)) == as.matrix(s2(5)))

all(as.matrix(s1(5)) == as.matrix(d1(5)))

require(rbenchmark)

benchmark(d1(n), d2(n), s1(n), s2(n),
          columns = c("test", "replications", "elapsed", "relative"), 
          order = "relative", replications = 100, relative = "elapsed")

benchmark(s1(n), s2(n),
          columns = c("test", "replications", "elapsed", "relative"), 
          order = "relative", replications = 1000, relative = "elapsed")

################################################################################
################################################################################
