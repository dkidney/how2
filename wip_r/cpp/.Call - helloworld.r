
setwd("~/Resources/R/CREEM R user group/Rcpp")



# Make a cpp file

cat('
#include <iostream>
int main()
{
    using namespace std;
    cout << "Hello world!" << endl;
    return 0;
}
', file = "helloworld.cpp")

system('open helloworld.cpp')



# Compile the c code

system('g++ -o sayhello helloworld.cpp')



# use the function

system('sayhello')



# acts like a function, but returns a zero

(value <- system('sayhello'))


# Not really calling C from R... we haven't made an R function.



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



