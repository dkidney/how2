setwd("~/Resources/R/CREEM R user group/Rcpp")


# Hello World -------------------------------------------------------------

cat('
#include <R.h>
#include <Rinternals.h>
#include <Rmath.h>
#include <Rdefines.h>

SEXP sayhello(){
    printf("Hello World!");
    return(R_NilValue);      
}', file = "sayhello.c")

system('open sayhello.c')

system('R CMD SHLIB sayhello.c')

dyn.load('sayhello.dll')

.Call("sayhello")

temp <- .Call("sayhello")


# A simple function -------------------------------------------------------

cat('
#include <R.h>
#include <Rinternals.h>
#include <Rmath.h>
#include <Rdefines.h>    

SEXP vecSum1(SEXP x){
    double value = 0;
    int n = length(x);
    for (int i = 0; i < n; i++) value += x[i];
    return value;
}', file = "vecSum1.c")

system('R CMD SHLIB vecSum1.c')

# what's going wrong?
# the input is an SEXP and needs to be coerced into the correct type
# the output also needs to be an SEXP

cat('
#include <R.h>
#include <Rinternals.h>
#include <Rmath.h>
#include <Rdefines.h>    
SEXP vecSum2(SEXP x){
    SEXP result;
    PROTECT(result = allocVector(REALSXP,1));
    double *input, value = 0;
    input = REAL(x);
    int n = length(x);
    for (int i = 0; i < n; i++) value += input[i];
    REAL(result)[0] = value;
    UNPROTECT(1);
    return result;
}', file = "vecSum2.c")

system('R CMD SHLIB vecSum2.c')

dyn.load('vecSum2.dll')

.Call("vecSum2", as.numeric(1:10))

vecSum <- function(x) .Call("vecSum2", as.numeric(x))

vecSum(1:10)




