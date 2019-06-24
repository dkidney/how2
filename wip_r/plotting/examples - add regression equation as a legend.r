## ************************************************************************** ##
## ************************************************************************** ##

x = rnorm(100)

y = rnorm(100)

fit = lm(y ~ x)

intercept = signif(coef(fit)[1], 3) ; intercept
slope     = signif(coef(fit)[2], 3) ; slope
R2        = signif(summary(fit)$r.squared, 3) ; R2


par(mar = c(4.5,4,3,0.5))

plot(x, y, main = bquote("log"[10]*" Scale Mn "~mu*"g" %.%"g"^-1))

abline(fit)

legend("bottomright", legend = bquote(hat(y)*" = "~.(intercept)*" + " ~.(slope)*"x"))

legend("topleft", legend = bquote("R"^2*" = "~.(R2)))


## ************************************************************************** ##
## ************************************************************************** ##
