R
================

  - [Rscript](#rscript)
  - [spinners](#spinners)
  - [environment variables](#environment-variables)

<!-- * [Rscript](#rscript) -->

-----

#### Rscript

<https://support.rstudio.com/hc/en-us/articles/218012917-How-to-run-R-scripts-from-the-command-line>

``` sh
# raw expressions
Rscript -e 'print("hello")'

# scripts
Rscript ~/my_script.R

# options 
Rscript --vanilla ~/my_script.R

# as above, but allows renviron
Rscript --no-save --no-restore --no-site-file --no-init-file ~/my_script.R
```

Need to use this header in the script

    #!/usr/bin/Rscript

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

-----

#### environment variables

R\_MAX\_MEM\_SIZE

R\_MAX\_VSIZE

R\_VSIZE

R\_NSIZE
