

n = 100

data = data.frame(x = rnorm(100), y = rnorm(100)) ; head(data)

form = y ~ x

X = model.matrix(form, data) ; head(X)

require(mgcv)

form = y ~ s(x)

temp = gam(form, data = data, fit = FALSE)

X = temp$X

colnames(X) = temp$term.names

head(X)


