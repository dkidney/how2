# In a recent question on Stack Overflow about speeding up group-by operations,
# Marek wondered which functions called .Internal code (and consequently were fast).
# I was surprised to see that there appears to be no built-in way to check whether or not this is the case
# (though is.primitive is available for primitive functions).

# Writing such a function is quite straight forward. We simply examine the contents of the function body, and serach for the string ".Internal" within it.

callsInternalCode <- function(fn)
{
  if(!require(stringr)) stop("stringr package required")
  any(str_detect(capture.output(body(fn)), ".Internal"))
}

# You can retrieve all the function in the base package with this one-liner taken from an example on the Filter help page.

funs <- Filter(is.function, sapply(ls(baseenv()), get, baseenv()))

# Now getting the list of functions that call internal code is easy.

names(funs)[sapply(funs, callsInternalCode)]

