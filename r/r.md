R
================

  - [Rscript](#rscript)
  - [spinners](#spinners)
  - [environment variables](#environment-variables)

<!-- * [Rscript](#rscript) -->

-----

#### Rscript

<https://support.rstudio.com/hc/en-us/articles/218012917-How-to-run-R-scripts-from-the-command-line>

-----

#### spinners

``` r
# use a spinner while waiting for a function to run 
wait = function(){
  Sys.sleep(5)
  "hello"
}
callr::r(wait, spinner = TRUE)
```

#### environment variables

R\_MAX\_MEM\_SIZE

R\_MAX\_VSIZE

R\_VSIZE

R\_NSIZE
