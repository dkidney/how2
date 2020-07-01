#################################################################################
# Practice with MCMCglmm
################################################################################

require(nlme)
require(MCMCglmm)
require(ggplot2)

################################################################################
# make some data - random slope and intercept model

b0 = 1
b1 = 10
b2 = 1
b3 = 10
n_subjects_per_group <- 50
n_obs_per_subject <- 10
n_groups <- 2
n_subjects <- n_groups * n_subjects_per_group
n_obs <- n_subjects * n_obs_per_subject

x = seq(0,1,length=n_obs_per_subject)
y <- NULL

s0 <- s1 <- s2 <- 1

for(sub in 1:n_subjects_per_group){
  y <- append(y, rnorm(1,b0,s1) + rnorm(1,b1,s2)*x + rnorm(1,0,s0))
  y <- append(y, rnorm(1,b0+b2,s1) + rnorm(1,b1+b3,s2)*x + rnorm(1,0,s0))  
}

# all random effect standard deviations are equal to 1 with no covariances

test <- data.frame(y=y,
                   x=x,
                   group=factor(rep(1:2, each=n_obs_per_subject)),
                   subject=factor(rep(1:n_subjects, each=n_obs_per_subject)))
head(test)
dim(test)

ggplot(test, aes(x,y, group=subject, colour=group)) + geom_line()

################################################################################

summary(lm(y~x*group, data=test))

################################################################################

# lme using original data frame
summary(lme(y~x*group, random=reStruct(~ x | subject, "pdDiag"), data=test))

# same thing but with grouped data
test_grouped <- groupedData(y~x|subject, data=test)
summary(lme(y~x*group, random=pdDiag(~ x), data=test_grouped))

# look ok, but the residual standard deviation is far too small

################################################################################

data(PlodiaPO)
head(PlodiaPO)
summary(MCMCglmm(y ~ x*group,
                 random = ~ subject,
#                 rcov = ~ idh(trait):units,
                 data = test,
                 verbose = F))

################################################################################
