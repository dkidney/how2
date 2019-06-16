R
================

  - [use a spinner while waiting for a function to
    run](#use-a-spinner-while-waiting-for-a-function-to-run)
  - [environment variables](#environment-variables)

#### use a spinner while waiting for a function to run

``` r
wait = function(){
  Sys.sleep(5)
  "hello"
}
callr::r(wait, spinner = TRUE)
```

### environment variables

R\_MAX\_MEM\_SIZE

R\_MAX\_VSIZE

R\_VSIZE

R\_NSIZE
