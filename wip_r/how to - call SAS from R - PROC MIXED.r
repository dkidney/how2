################################################################################
################################################################################

# How to call SAS from R - using PROC MIXED

################################################################################
################################################################################

require(mvtnorm)
require(ggplot2)

parent <- "~/Resources/R/Examples"

temp.folder.path <- file.path(parent, "SAS-temp") ; temp.folder.path

dir.create(temp.folder.path, showWarnings = FALSE)

setwd(temp.folder.path) ; getwd()

################################################################################

# make some data for analysis 
# - random slope and random intercept 
# - random effects uncorrelated with same variance

#source(file.path(parent, "how to - simulate data from a mixed model and plot using lattice and ggplot2.r"))
source(file.path(parent, "how to - simulate data from a mixed model - with two groups.r"))

dat <- mmdata(n=10, m=10, sigma=0.1) ; head(dat) ; dim(dat) ; attributes(dat)

# ggplot(dat, aes(x,y, colour=as.factor(subject))) + geom_point() + geom_line(aes(x,Ey1)) 

ggplot(dat, aes(x,y, group=subject, colour=as.factor(group))) + geom_point() + geom_line(aes(x,Ey1)) + geom_line(aes(x,Ey0), col=1, lwd=1) + facet_wrap(~group) 

################################################################################

# save it in the temporary folder

X <- cbind(1,dat$x) ; colnames(X) <- c("B0", "B1") ; head(X)

newX <- model.matrix(~-1+X:as.factor(dat$group)) ; colnames(newX) <- c(outer(colnames(X), unique(dat$group), paste, sep="_"))

head(newX) ; tail(newX)

dat <- cbind(newX, dat) ; head(dat)

write.csv(dat, file = "inputdata.csv", row.names = FALSE)

################################################################################

# write a .sas file

# the type option includes:
# - vc (variance components = diagonal = the default)
# - un (unstructured)
# - cs (compound symmetry)

output.tables <- c("fitstatistics","covparms","solutionf","solutionr")
type <- "vc"
include.groups <- TRUE

# cat("\nproc import datafile='", normalizePath(getwd()), "\\inputdata.csv' out=inputdata dbms=csv replace ;
# \nproc mixed data=inputdata ;
#  ods output ", file="temp.sas", sep="")
# 
# for(i in 1:length(output.tables)){
#     cat(output.tables[i], "=", output.tables[i], " ", file="temp.sas", sep="", append=TRUE)
# }
# 
# cat(";\n class subject ", file="temp.sas", sep="", append=TRUE)
# 
# if(include.groups) cat("group", file="temp.sas", sep=" ", append=TRUE)
# 
# cat(" ;\n model y = ", file="temp.sas", sep="", append=TRUE)
#     
# if(include.groups) cat(colnames(dat)[1:4], "/ noint", file="temp.sas", sep=" ", append=TRUE) else cat("x /", file="temp.sas", sep="", append=TRUE)
# 
# cat(" s ;\n random ", file="temp.sas", sep="", append=TRUE)
# 
# if(include.groups) cat(colnames(dat)[1:4], file="temp.sas", sep=" ", append=TRUE) else cat("intercept x", file="temp.sas", sep="", append=TRUE)
# 
# cat(" / type=",type," subject=subject s ", file="temp.sas", sep="", append=TRUE)
# 
# if(include.groups) cat("group=group", file="temp.sas", sep=" ", append=TRUE)
# 
# cat(" ;\n\n", file="temp.sas", sep=" ", append=TRUE)
# 
# for(i in 1:length(output.tables)){
#     cat("proc export data=", output.tables[i], " outfile='", normalizePath(getwd()), "\\", output.tables[i], ".csv' dbms=csv replace ;
# ", file="temp.sas", sep="", append=TRUE)
# }
# 
# cat("\nrun ;", file="temp.sas", sep=" ", append=TRUE)

cat("\nproc import datafile='", normalizePath(getwd()), "\\inputdata.csv' out=inputdata dbms=csv replace ;
\nproc mixed data=inputdata ;
 ods output ", file="temp.sas", sep="")

for(i in 1:length(output.tables)){
    cat(output.tables[i], "=", output.tables[i], " ", file="temp.sas", sep="", append=TRUE)
}

cat(";\n class subject group ;
 model y = x", file="temp.sas", sep="", append=TRUE)

if(include.groups) cat(" | group", file="temp.sas", sep="", append=TRUE)

cat(" / s ;
 random intercept x / type=",type," subject=subject s ", file="temp.sas", sep="", append=TRUE)

if(include.groups) cat("group=group", file="temp.sas", sep=" ", append=TRUE)

cat(" ;\n\n", file="temp.sas", sep=" ", append=TRUE)

for(i in 1:length(output.tables)){
    cat("proc export data=", output.tables[i], " outfile='", normalizePath(getwd()), "\\", output.tables[i], ".csv' dbms=csv replace ;
", file="temp.sas", sep="", append=TRUE)
}

cat("\nrun ;", file="temp.sas", sep=" ", append=TRUE)

################################################################################

# Submit the SAS code

sas.exe.path <- "C:/Program Files/SASHome/x86/SASFoundation/9.3/sas.exe" ; sas.exe.path

sas.file.path <- file.path(getwd(), "temp.sas") ; sas.file.path

system(paste("\"", sas.exe.path, "\"", " -sysin \"", sas.file.path, "\"", sep=""))

################################################################################

# import the results

for(i in 1:length(output.tables)) eval(parse(text=paste(output.tables[i], " <- read.csv('",output.tables[i],".csv')",sep="")))

cat("\nfitstatistics\n") ; print(fitstatistics)

covparms <- covparms[which(covparms$Estimate!=0),] ; cat("\ncovparms\n") ; print(covparms)

cat("\nsolutionf\n") ; print(solutionf)

solutionr <- solutionr[which(solutionr$Estimate!=0),] ; solutionr
solutionr <- solutionr[order(solutionr$group, as.factor(solutionr$subject)),] ; solutionr
solutionr <- solutionr[,!colnames(solutionr) %in% c("StdErrPred","DF", "tValue", "Probt")] ; solutionr
solutionr <- reshape(solutionr, direction="wide", idvar=c("subject","group"), timevar="Effect", v.names="Estimate")
colnames(solutionr) <- c("subject", "group", "Intercept", "x") ; rownames(solutionr) <- NULL
cat("\nsolutionr\n") ; print(solutionr)

################################################################################

# clean up files

if(0){
    
    # delete the contents of "SAS-temp" 
    unlink(dir("SAS-temp"), recursive = TRUE, force = TRUE)
    
    # or delete the entire folder (need to set to a different working directory first)
    setwd(parent)
    unlink("SAS-temp", recursive = TRUE, force = TRUE)
    
}

################################################################################
################################################################################
