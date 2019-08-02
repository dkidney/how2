Rmarkdown + knitr
================

  - [emojis](#emojis)
  - [css styling](#css-styling)
  - [data\_table](#data_table)
  - [images](#images)
  - [links to sections](#links-to-sections)
  - [links to tables and figures](#links-to-tables-and-figures)
  - [multiple rmarkdown files](#multiple-rmarkdown-files)
  - [print text from a file](#print-text-from-a-file)
  - [put all code in an appendix](#put-all-code-in-an-appendix)
  - [style chunks](#style-chunks)
  - [configuration chunk](#configuration-chunk)

-----

<https://rmarkdown.rstudio.com/lesson-1.html>  
<https://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf>  
<https://bookdown.org/yihui/rmarkdown/>  
<https://yihui.name/knitr/>  
<https://yihui.name/knitr/demo/graphics/>
<https://kbroman.org/knitr_knutshell/>  
<https://www.markdownguide.org/basic-syntax/>  
<https://guides.github.com/features/mastering-markdown/>  
<https://cran.r-project.org/web/packages/kableExtra/vignettes/awesome_table_in_html.html>

-----

#### emojis

<https://github.com/ikatyang/emoji-cheat-sheet/blob/master/README.md>  
<https://gist.github.com/rxaviers/7360908>

:monkey:

-----

#### css styling

##### yaml

*TODO*

##### css chunck

*TODO*

##### out.extra

*TODO*

-----

#### data\_table

-----

#### images

`![](path/to/smallorb.png)` (markdown)

`knitr::include_graphics(img1_path_or_url)`

(HTML)

*TODO*

-----

#### links to sections

`### Missingness {#missingness}`

`(see [Missingness](#missingness) section)`

-----

#### links to tables and figures

*TODO*

-----

#### multiple rmarkdown files

<https://stackoverflow.com/questions/25824795/how-to-combine-two-rmarkdown-rmd-files-into-a-single-output>

    ---  
    title: My Report  
    output: 
      html_document:
        toc: yes 
    ---
    
    ```{r child = 'chapter1.Rmd'}
    ```
    
    ```{r child = 'chapter2.Rmd'}
    ```

**chapter1.Rmd**

    # Chapter 1
    
    This is chapter 1.

**chapter2.Rmd**

    # Chapter 2
    
    This is chapter 2.

-----

#### print text from a file

    ```{r code=readLines("my_file.txt")}
    ```

-----

#### put all code in an appendix

    # Appendix: R code {-}
    
    ```{r ref.label=knitr::all_labels(), echo = TRUE, eval = FALSE}
    ```

-----

#### style chunks

##### out.extra

    out.extra='style="background-color: #9ecff7; padding:10px; display: inline-block;'

##### class

<http://zevross.com/blog/2017/06/19/tips-and-tricks-for-working-with-images-and-figures-in-r-markdown-documents/>

*TODO*

-----

#### configuration chunk

> It is recommended to create a knit configuration chunk as the first
> chunk in a script with cache = FALSE and include = FALSE options set.

    ```{r config, cache=FALSE, include=FALSE}
    # configuration code goes here
    ```

Example configuration code:

```` r
# code evaluation -----
knitr::opts_chunk$set(
    eval = TRUE
)
# text results -----
knitr::opts_chunk$set(
    echo = TRUE,
    results = 'hold',
    collapse = FALSE,
    warning = FALSE,
    message = FALSE
)
# code decoration -----
knitr::opts_chunk$set(
    tidy = "styler" ,
    comment = "# ",
    background = '#F7F7F7'
)
# plots -----
golden_ratio = (1 + sqrt(5)) / 2
knitr::opts_chunk$set(
    fig.path = "figures/fig_",
    fig.show = "hold",
    dev = "svg", # svg looks better on web pages
    # dev = c("png", "jpeg"),
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
par(
    family = knitr::opts_chunk$get("dev.args")$family
)
# engines -----
knitr::opts_chunk$set(
    engine.path = list(
        python = "/usr/local/anaconda3/envs/py3/bin/python"
    )
)
stopifnot(file.exists(knitr::opts_chunk$get("engine.path")$python))
# python -----
# requires reticulate
knitr::opts_chunk$set(
    python.reticulate = TRUE
)
reticulate::use_python(knitr::opts_chunk$get("engine.path")$python)
# paged tables -----
# when using `df_print: paged` in yaml header
knitr::opts_chunk$set(
    max.print = 10, # The number of rows to print.
    rows.print = 10, # The number of rows to display.
    cols.print = 10, # The number of columns to display.
    cols.min.print = 10, # The minimum number of columns to display.
    pages.print = 10, # The number of pages to display under page navigation.
    paged.print = TRUE, # When set to FALSE turns off paged tables.
    rownames.print = TRUE # When set to FALSE turns off row names.
)
# option templates -----
# cat_file
knitr::opts_template$set(
  cat_file = list(eval = TRUE, echo = FALSE, results = "asis")
)
cat_file <- function(x, ext = NULL) {
  y <- paste0(readLines(x, warn = FALSE), collapse = "\n")
  cat("`", x, "`\n")
  if (is.null(ext)) ext <- tools::file_ext(x)
  cat(paste0("```", ext, "\n", y, "\n```"))
}
# cat_text
knitr::opts_template$set(
  cat_text = knitr::opts_template$get("cat_file")
)
cat_text = function(x, ext = NULL){
    if (is.null(ext)) ext = "txt"
    cat(paste0("```", ext, "\n", x, "\n```"))
}
# cat_sql
knitr::opts_template$set(
  cat_sql = knitr::opts_template$get("cat_file")
)
cat_sql = function(x) cat_text(x, "sql")# package options -----
# see ?opts_knit
knitr::opts_knit$set(
    aliases = c(h = 'fig.height', w = 'fig.width'),
    width = 80
)
# working directory -----
if (interactive()) {
    setwd(fs::path_dir(rstudioapi::getActiveDocumentContext()$path))
}
````
