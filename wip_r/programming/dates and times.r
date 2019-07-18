
# Symbol    Meaning                 Example
# %d        day as a number (0-31)  01-31
# %a        abbreviated weekday     Mon
# %A        unabbreviated weekday   Monday
# %m        month (00-12)           00-12
# %b        abbreviated month       Jan
# %B        unabbreviated month 	January
# %y        2-digit year            07
# %Y        4-digit year            2007

# to see a comprehensive list use
?strptime

# Date class --------------------------------------------------------------

# convert character to Date
x = "03/11/2014"
x = as.Date(x, "%d/%m/%Y") ; x
class(x)

# convert Date to character using specific format
y = format(x, "%Y%m%d") ; y
y = format(x, "%Y %m %d") ; y
y = format(x, "%d/%m/%y") ; y
y = format(x, "%H:%M, %A %d %B %Y") ; y
class(y)

require(lubridate)
year(x)
month(x)
month(x, TRUE)
month(x, TRUE, FALSE)
day(x)
yday(x)
mday(x)
wday(x)
wday(x, TRUE)
wday(x, TRUE, FALSE)


# "POSIXlt" "POSIXt" ------------------------------------------------------

x = "20091010"
y = as.POSIXlt(x, format = "%Y%m%d") ; y

format(y, "%Y%m%d")
format(y, "%Y %m %d")
format(y, "%d/%m/%y")










x = "154554"
y = as.POSIXlt(x, format="%H%M%S") ; y

format(y, "%a %b %d")

format(y, "%H%M%S")

format(y, "%H:%M:%S")



x = Sys.time() ; x

as.numeric(difftime(Sys.time(), x, unit = "secs"))

# try lubridate package