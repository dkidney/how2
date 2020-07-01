################################################################################################################
################################################################################################################

# Calling C from R

################################################################################################################
################################################################################################################

# directory where the C++ code is to be stored
setwd("~/Resources/Applications/C++/My C++ Functions")

# write a C++ function and save it in a text file with extension .c
write('

#include <R.h>

void sayhello(){

    Rprintf("Hello World!\\n");

}

', "sayhello.c")

# compile the code using the shell command
system("R CMD SHLIB sayhello.c")

# load the compiled code
dyn.load("sayhello.dll")
is.loaded("sayhello")

# use the function
.C("sayhello")
#.Call("sayhello")

# add an R interface to the compiled code
sayhello <- function(x) result <- .C("sayhello")

# try it out
sayhello()

# unload the compiled code
dyn.unload("sayhello.dll")


################################################################################################################
################################################################################################################


