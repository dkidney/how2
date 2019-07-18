
n=5
sigma = sqrt(2)
corr  = 0.5
varMat = diag(n)*sigma^2 ; varMat
corMat = matrix(corr, nc=n, nr=n) ; diag(corMat) = 1 ; corMat
covMat = sqrt(varMat) %*% corMat %*% sqrt(varMat) ; covMat

# check
cov2cor(covMat)

