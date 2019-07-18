
X <- matrix(c(1,1,1,1,8,10,12,14), nc=2) ; X

Xqr <- qr(X) # creates a QR structure

Rt <- qr.R(Xqr) ; Rt # returns Rt (R truncated)

R <- qr.R(Xqr, complete=TRUE) ; R # returns R (the full R)

Qt <- qr.Q(Xqr) ; Qt # returns Q_t (Q truncated)

Q <- qr.Q(Xqr, complete=TRUE) ; Q # returns Q (the full Q)

qr.X(Xqr) # returns the original X

# checking that these work

Qt %*% Rt # should equal X

p <- ncol(X)
n <- nrow(X)

zero <- matrix(0, nr=n-p, nc=p) ; zero

Q %*% rbind(Rt, zero) # should also equal R



