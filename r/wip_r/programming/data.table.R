
################################################################################
## dplyr

library(data.table)

x = data.table(a = 1:6, b = 8:3, c = c("a","b","a","b","a","b")) ; x

# sort by b
setkey(x, b)

# summary of c
x[, list(g = sum(a))]

# summarise a by c
x[, sum(a), by = "c"]

# summarise a by c
x[, list(g = sum(a)), by = "c"]

# 1st row
x[1, ]

# 2nd column
x[, 2, with = FALSE]

# summarise a by c
x[, min := min(a), by = "c"]

# don't do this!
x = x[,-1]


################################################################################
## dplyr

library(dplyr)

data = tbl_df(fread("~/Dropbox/resources/r/examples/Global Superstore.csv"))
data

as.Date("31/07/2012", format = "%d/%m/%Y")

