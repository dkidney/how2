
n = 6

x = seq(0,1,length = n)

V = diag(0.5*exp(x)) ; V
V = diag((x-0.5)^2) ; V

d = outer(1:n, 1:n, function(x,y) abs(x-y))

i = !upper.tri(d)

j = order(d[i])

C = 0.9^d ; C

Sigma = sqrt(V) %*% C %*% sqrt(V) ; Sigma

if(inherits(try(solve(chol(Sigma)),TRUE), "try-error")) stop("Sigma not postitive definite")

par(mfrow = c(2,2), mar = c(2,2,1,1))

plot(x, diag(V), type = "l")

plot(d[i][j], C[i][j], type = "l")

#-------------------------------------------------------------------------------

if(1){
    
    require(bdsmatrix)   
    
    gt = gchol(Sigma)
    
    L = as.matrix(gt) ; L
    
    D = diag(diag(gt)) ; D
    
#     gt = gchol(solve(Sigma))
#     
#     L = as.matrix(gt) ; L
#     
#     D = solve(diag(diag(gt))) ; D
    
}else{
    
    U = chol(Sigma)
    
    D = diag(U) 
    
    L = t(U/D) ; L
    
    D = diag(D^2) ; D
    
}

T = solve(L) ; print(round(T,2))

# all.equal(L %*% solve(D) %*% t(L), solve(Sigma))

all.equal(t(T) %*% solve(D) %*% T, solve(Sigma))

all.equal(L %*% D %*% t(L), Sigma)

plot(x, diag(D), type = "l")

plot(d[i][j], -T[i][j], type = "l")
