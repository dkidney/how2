###############################################################################################################
###############################################################################################################

# How to call SAS from R

###############################################################################################################
###############################################################################################################

parent <- "~/Resources/R/Examples"

temp.folder.path <- file.path(parent, "SAS-temp") ; temp.folder.path

dir.create(temp.folder.path, showWarnings = FALSE)

setwd(temp.folder.path) ; getwd()

#--------------------------------------------------------------------------------------------------------------
# make some data for analysis - e.g. simple regression

sigma <- 1
b0 <- 0
b1 <- 1
n <- 100
x <- seq(0,10,length=n)
y <- rnorm(n, b0+b1*x, sigma)

#--------------------------------------------------------------------------------------------------------------
# save it somewhere

write.csv(x=data.frame(y=y,x=x), file = "inputdata.csv", row.names = FALSE)

#--------------------------------------------------------------------------------------------------------------
# write a .sas file

cat("
proc import datafile='", normalizePath(getwd()), "\\inputdata.csv' out=inputdata dbms=csv replace;
proc reg data=inputdata;
    ods output ParameterEstimates=estimates;
    model y = x;
    output out=predictions p=predictions;
proc export data=estimates dbms=csv outfile='", normalizePath(getwd()),"\\estimates.csv' replace; 
proc export data=predictions dbms=csv outfile='", normalizePath(getwd()),"\\predictions.csv' replace;
run;
", file = "temp.sas", sep="")

#--------------------------------------------------------------------------------------------------------------
# Submit the SAS code

sas.exe.path <- "C:/Program Files/SASHome/x86/SASFoundation/9.3/sas.exe" ; sas.exe.path

sas.file.path <- file.path(getwd(), "temp.sas") ; sas.file.path

system(paste("\"", sas.exe.path, "\"", " -sysin \"", sas.file.path, "\"", sep=""))

#--------------------------------------------------------------------------------------------------------------
# import the results

predictions <- read.csv("predictions.csv") ; print(head(predictions))
estimates <- read.csv("estimates.csv") ; print(head(estimates))

#--------------------------------------------------------------------------------------------------------------
# clean up files

# delete the contents of "SAS-temp" 
unlink(dir("SAS-temp"), recursive = TRUE, force = TRUE)

# or delete the entire folder (need to set to a different working directory first)
setwd(parent)
unlink("SAS-temp", recursive = TRUE, force = TRUE)

###############################################################################################################
###############################################################################################################

