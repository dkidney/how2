################################################################################
################################################################################

x = c(0.1, 1, 10)

x

# round doesn't add trailing zeros 
round(x,2)

# adds the right number of trailing zeros
sprintf("%.2f", round(x,2))

# signif keeps trailing zeros
signif(x,2)

# sprintf options
sprintf("%#.2g", signif(x,2)) # annoying decimal
sprintf("%.2f", signif(x,2))  # too many trailing zeros
sprintf("%.2g", signif(x,2))  # not enough trailing zeros

# not ideal...
sprintf(c("%.2f", "%.1f", "%.0f"), signif(x,2))
        
format(signif(x,2), scientific=FALSE)


sprintf("%#.2g", signif(x,2))

sprintf("%d.%.0f", signif(x,2))
sprintf("%.0d%.4g\n", signif(x,2))

# add leading zeros
sprintf("%04d", 1)

# get rid of trailing zeros
prettyNum(x)

# keep the same number of decimal places including zeros
format(x, nsmall = 2)

# sceitific notation
format(x, scientific = TRUE, digits = 2)


sprintf("%2.2f",34)


sprintf("%f", pi)
sprintf("%.3f", pi)
sprintf("%1.0f", pi)
sprintf("%5.1f", pi)
sprintf("%05.1f", pi)
sprintf("%+f", pi)
sprintf("% f", pi)
sprintf("%-10f", pi) # left justified
sprintf("%e", pi)
sprintf("%E", pi)
sprintf("%g", pi)
sprintf("%g",   1e6 * pi) # -> exponential
sprintf("%.9g", 1e6 * pi) # -> "fixed"
sprintf("%G", 1e-6 * pi)

################################################################################
################################################################################
