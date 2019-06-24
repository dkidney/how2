#rm(list=ls())

ls()

x.1 <- 6
x.2 <- 7
y.1 <- 8
x1 <- 9
x2 <- 10
y.tmp <- 11
tmp <- 12

ls()

objects(pattern="^x")
objects(pattern="^x\\.")
objects(pattern="tmp$")
objects(pattern="\\.tmp$")
objects(pattern="[:punct:]")
objects(pattern="[:alnum:]")
objects(pattern="[:alpha:]")
objects(pattern="[:digit:]")
ls()[!ls() %in% objects(pattern="_Rcpp_")]

rm(list=objects(pattern="tmp$"))

ls()

