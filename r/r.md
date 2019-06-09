R
================

#### use a spinner while waiting for a function to run

``` r
wait = function(){
  Sys.sleep(5)
  "hello"
}
callr::r(wait, spinner = TRUE)
```
