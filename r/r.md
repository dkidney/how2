R
================

#### use a spinner while waiting for a function to run

``` r
wait = function(secs = 5) Sys.sleep(secs)
> callr::r(function() wait(), spinner = TRUE)
Error in wait() : could not find function "wait"
> wait
function(secs = 5) Sys.sleep(secs)
> callr::r(wait(), spinner = TRUE)
Error in eval(substitute(expr), data, enclos = parent.frame()) : 
  no("func") || is.function(func) is not TRUE
> callr::r(wait, spinner = TRUE)
NULL
```
