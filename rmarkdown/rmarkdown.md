Rmarkdown + knitr
================

<https://rmarkdown.rstudio.com/lesson-1.html>  
<https://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf>  
<https://bookdown.org/yihui/rmarkdown/>  
<https://yihui.name/knitr/>  
<https://kbroman.org/knitr_knutshell/>

-----

##### images

`![](path/to/smallorb.png)` (markdown)

`knitr::include_graphics(img1_path_or_url)`

(HTML)

*TODO*

##### links to sections

`### Missingness {#missingness}`

`(see [Missingness](#missingness) section)`

##### links to tables / figures

*TODO*

##### multiple `.Rmd` files

*TODO*

##### put all code in an appendix

    # Appendix: R code {-}
    
    ```{r ref.label=knitr::all_labels(), echo = TRUE, eval = FALSE}
    ```

##### configuration chunk

> It is recommended to create a knit configuration chunk as the first
> chunk in a script with cache = FALSE and include = FALSE options set.

    ```{r config, cache=FALSE, include=FALSE}
    # configuration code goes here
    ```

Example configuration code:

```` r
# code evaluation
knitr::opts_chunk$set(
    eval = TRUE
)
# text results
knitr::opts_chunk$set(
    echo = TRUE,
    results = 'hold',
    collapse = FALSE,
    warning = FALSE,
    message = FALSE
)
# code decoration
knitr::opts_chunk$set(
    tidy = "styler" ,
    comment = "# ",
    background = '#F7F7F7'
)
# plots
golden_ratio = (1 + sqrt(5)) / 2
knitr::opts_chunk$set(
    fig.path = "figures/fig_",
    fig.show = "hold",
    dev = c("png", "jpeg"),
    dev.args = list(
        family = "Avenir",
        pointsize = 11
    ),
    dpi = 96, # dpi * inches = pixels
    fig.width = 7,
    # fig.height = 7 / golden_ratio,
    fig.asp = 1 / golden_ratio, # fig.height = fig.width * fig.asp
    # fig.dim = c(7, 7 / golden_ratio),
    out.width = "75%",
    fig.retina = 1,
    fig.align = "center"
)
ggplot2::theme_set(
    ggplot2::theme_minimal(
        base_family = knitr::opts_chunk$get("dev.args")$family,
        base_size = knitr::opts_chunk$get("dev.args")$pointsize,
        base_line_size = 0.5
    )
)
# engines
knitr::opts_chunk$set(
    engine.path = list(
        python = "/usr/local/Cellar/python/3.7.3/bin/python3",
        sh = ,
        zsh = 
    )
)
stopifnot(file.exists(knitr::opts_chunk$get("engine.path")$python))
# python - requires reticulate
knitr::opts_chunk$set(
    python.reticulate = TRUE
)
reticulate::use_python(knitr::opts_chunk$get("engine.path"))
# paged tables - when using `df_print: paged` in yaml header
knitr::opts_chunk$set(
    max.print = 10, # The number of rows to print.
    rows.print = 10, # The number of rows to display.
    cols.print = 10, # The number of columns to display.
    cols.min.print = 10, # The minimum number of columns to display.
    pages.print = 10, # The number of pages to display under page navigation.
    paged.print = TRUE, # When set to FALSE turns off paged tables.
    rownames.print = TRUE # When set to FALSE turns off row names.
)
# option templates
knitr::opts_template$set(
    cat_file = list(eval = TRUE, echo = FALSE, results = "asis")
)
cat_file = function(x){
    y = readLines(x, warn = FALSE) %>% paste0(collapse = "\n")
    paste0("```", tools::file_ext(x), "\n", y, "\n```")
}
# package options - see ?opts_knit
knitr::opts_knit$set(
    aliases = c(h = 'fig.height', w = 'fig.width'),
    width = 96
)
# working directory
if (interactive()) {
    setwd(fs::path_dir(rstudioapi::getActiveDocumentContext()$path))
}
````
