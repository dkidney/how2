

n <- 10

x <- 1:n ; x

X <- cbind(1,x) ; colnames(X) <- c("B0", "B1") ; X

fac <- factor(rep(c("A","B"), each = n/2)) ; fac

# make the design matrix for an interaction-only model

newX <- model.matrix(~-1+X:fac)

colnames(newX) <- c(outer(colnames(X), c("A","B"), paste, sep="."))

print(newX)

