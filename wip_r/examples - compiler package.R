
myFunction<-function() { for(i in 1:10000000) { 1*(1+1) } }

library(compiler)

myCompiledFunction <- cmpfun(myFunction) # Compiled function

(time1 <- system.time(myFunction() ))

(time2 <- system.time(myCompiledFunction() ))

cat("Compiled function is", round(time1['elapsed']/time2['elapsed'],2),"times faster!")

