################################################################################
################################################################################

# go from T'DT to Sigma

T = matrix(c( 1, 0,0,
             -0.6, 1,0,
             0,-0.6,1), byrow = TRUE, nc = 3, nr = 3) ; T

D = matrix(c(5,0,0,
             0,6,0,
             0,0,7), byrow = TRUE, nc = 3, nr = 3) ; D

Sigma = solve(t(T) %*% solve(D) %*% T) ; Sigma

cov2cor(Sigma)

cov2cor(Sigma/Sigma[1,1])

all.equal(T %*% Sigma %*% t(T), D)

solve(chol(Sigma))

################################################################################

# go from Sigma to T'DT 

mod.chol = function(Sigma){
    
    U = t(chol(Sigma)) ; U
    
    D = diag(diag(U^2)) ; D
    
    T = solve(U %*% solve(sqrt(D))) ; T
    
    return(list(D = D, T = T))
    
}

mc = mod.chol(Sigma) ; mc

all.equal(mc$D, D)

all.equal(mc$T, T)

all.equal(solve(t(mc$T) %*% solve(mc$D) %*% mc$T), Sigma)



# 
# mod.chol2 = function(Sigma){
#     
#     U = t(chol(Sigma)) ; U
#     
#     D = diag(diag(U^2)) ; D
#     
#     L = solve(sqrt(D)) %*% U ; L
# 
#     return(list(D = D, L = L))
#     
# }
# 
# mc = mod.chol2(Sigma) ; mc
# 
# all.equal(mc$D, D)
# 
# all.equal(solve(mc$L), T)
# 
# all.equal(sqrt(mc$D) %*% mc$L %*% t(mc$L) %*% sqrt(mc$D), Sigma)
# 

################################################################################
################################################################################

n = 10

x = seq(0, 1, length = n)
d = outer(1:n, 1:n, function(x,y) abs(x-y)) ; d
C = 0.6^d ; C

# x = sort(runif(n))
# d = outer(x, x, function(x,y) abs(x-y)) ; d
# C = 0.05^d ; C

# require(glsSplines)
# x = sort(runif(n))
# d = outer(x, x, function(x,y) abs(x-y)) ; d
# knots = seq(0,1,length = 8)[-c(1,8)] ; knots
# beta = c(1,  0.97591935,  0.08234638, -1.03156589, -0.32162117,  0.70001262,  0.40993557, -0.41971536, -0.42188591, -0.30898161)
# X = bs(d, df = 9, knots = seq(0, 1, length = 8)[-c(1, 8)], intercept = TRUE) ; head(X) ; dim(X)
# C = matrix(X %*% beta, nr = n) ; C[1:10, 1:10] ; dim(C)

V = diag(exp(x)) ; V[1:10, 1:10] ; dim(V)

Sigma = sqrt(V) %*% C %*% sqrt(V) ; Sigma

!inherits(try(solve(chol(Sigma))), "try-error")

i = lower.tri(d) ; i

j = order(d[i]) ; j

mc = mod.chol(Sigma)

round(mc$D[1:10,1:10], 3)

round(mc$T[1:10,1:10], 3)

par(mfrow = c(2,2), mar = c(2,2,1,1))

plot(x, diag(V), type = "l")

plot(d[i][j], C[i][j], type = "l")

plot(x, diag(mc$D), type = "l")

plot(d[i][j], mc$T[i][j], type = "l")


# first 4 sub-diagonals

par(mfrow = c(2,2), mar = c(2,2,1,1))

plot(diag(d[-1,]), diag(mc$T[-1,]))

plot(diag(d[-(1:2),]), diag(mc$T[-(1:2),]))

plot(diag(d[-(1:3),]), diag(mc$T[-(1:3),]))

plot(diag(d[-(1:4),]), diag(mc$T[-(1:4),]))


# first 4 columns

par(mfrow = c(2,2), mar = c(2,2,1,1))

plot(d[-1,1], mc$T[-1,1])

plot(d[-(1:2),1], mc$T[-(1:2),1])

plot(d[-(1:3),1], mc$T[-(1:3),1])

plot(d[-(1:4),1], mc$T[-(1:4),1])


################################################################################
################################################################################



