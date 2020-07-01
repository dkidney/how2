
#-------------------------------------------------------------------------------

# make a call with quote()

x <- quote(read.csv("important.csv", row.names = FALSE))

x

x[1]

x[[1]]

x[[2]]

x[[3]]

is.call(x)

names(x)

as.list(x)

x$row.names

class(x)

eval(x)

#-------------------------------------------------------------------------------

# make a call with call()

y = call("read.csv", "important.csv", row.names = FALSE)

y

identical(x,y)

#-------------------------------------------------------------------------------

A = 10.5

call("round", A)

call("round", quote(A))


f = round

call(deparse(substitute(f)), A)   

call(deparse(substitute(f)), quote(A))   

g = as.call(list(f, A)) ; g

g = as.call(list(f, quote(A))) ; g

eval(g)

g = list(f, quote(A))
mode(g) = "call"
g
eval(g)

#-------------------------------------------------------------------------------

h = function(abc = 1, def = 2, ghi = 3) {

    list(sys.call = sys.call(), match.call = match.call())

}

h()

h(d = 2, 2)


#-------------------------------------------------------------------------------

# works with dots too

j = function(x, ...) {

    list(call = match.call())

}

j(x = 5, y = 10)





