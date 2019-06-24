
# returns the amount of memory in Mb that R is currently using
mem <- function() {
  bit <- 8L * .Machine$sizeof.pointer
  if (!(bit == 32L || bit == 64L)) {
    stop("Unknown architecture", call. = FALSE)
  }

  node_size <- if (bit == 32L) 28L else 56L

  usage <- gc()
  sum(usage[, 1] * c(node_size, 8)) / (1024 ^ 2)
}
mem()

#-------------------------------------------------------------------------------

# function to calculate how memory changes during the execution of a block of code

mem_change <- function(code) {
  start <- mem()

  expr <- substitute(code)
  eval(expr, parent.frame())
  rm(code, expr)

  round(mem() - start, 3)
}

#-------------------------------------------------------------------------------

f <- function() 1:1e6

mem_change(f()) 

# no change because nothing was saved

mem_change(x <- f()) 

# this time something was saved and persists after then function has terminated

rm(x)

#-------------------------------------------------------------------------------

f1 <- function() {
  x <- 1:1e6
  10
}

mem_change(x <- f1())

# hardly and change because x is so small

x

rm(x)

#-------------------------------------------------------------------------------

f2 <- function() {
  x <- 1:1e6
  a ~ b
}

mem_change(y <- f2())

# big change because the formula remembers the environment in which it was made

y

object.size(y)

ls(envir = attr(y, ".Environment"))

rm(list = ls(envir= attr(y, ".Environment")), envir = attr(y, ".Environment"))

object.size(y)

rm(y)

#-------------------------------------------------------------------------------

f3 <- function() {
  x <- 1:1e6
  function() 10
}

mem_change(z <- f3())

# big change because the function remembers the environment in which it was made

object.size(z)

rm(z)



#-------------------------------------------------------------------------------

n = 100
lapply(1:10000, function(i) as.data.frame(matrix(rnorm(n^2), n, n)))






