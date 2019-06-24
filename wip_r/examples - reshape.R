
wide = data.frame(c("US", "UK"),
                c("Unites States", "United Kingdom"),
                c(1,2),
                c(3,4),
                c(5,6),
                c(7,8),
                c(9,0))
colnames(wide) = c("Code", "Country", as.character(1950:1954))
wide


# wide to long ------------------------------------------------------------

long = reshape(wide, direction = "long", varying = list(names(wide)[3:7]), v.names = "Value", 
             idvar = c("Code","Country"), timevar = "Year", times = 1950:1954)

rownames(long) = NULL

long

long = reshape(wide, direction = "long", varying = list(names(wide)[3:7]), v.names = "Value", 
             idvar = c("Code"), timevar = "Year", times = 1950:1954)

rownames(long) = NULL

long


# long to wide ------------------------------------------------------------

wide = reshape(long, direction="wide", idvar=c("Code","Country"), timevar="Year", v.names="Value")

wide
