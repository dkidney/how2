

x <- data.frame(c=1:10, d=1:10, b=1:10, a=1:10) ; x

names.neworder <- sort(names(x)) ; names.neworder

# right way
x[, match(names.neworder, names(x))]

# wrong way
x[, match(names(x), names.neworder)]
