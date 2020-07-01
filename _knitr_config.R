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
    fig.show = "hold",
    dev = "svg", # svg looks better on web pages
    dpi = 96, # dpi * inches = pixels
    fig.width = 7,
    fig.asp = 2 / (1 + sqrt(5)), # fig.height = fig.width * fig.asp
    out.width = "75%",
    fig.retina = 1,
    fig.align = "center"
)
# python -----
knitr::opts_chunk$set(
  collapse = TRUE,
    engine.path = list(
        python = "/usr/local/anaconda3/envs/how2/bin/python"
    ),
    python.reticulate = TRUE
)
if(!file.exists(knitr::opts_chunk$get("engine.path")$python)){
  message("can't find python engine:\n\t", knitr::opts_chunk$get("engine.path")$python)
}else{
  reticulate::use_python(knitr::opts_chunk$get("engine.path")$python)
}
# option templates -----
# cat_file
knitr::opts_template$set(
  cat_file = list(
    cache = FALSE,
    eval = TRUE,
    echo = FALSE,
    results = "asis",
    collapse = FALSE,
    comment = ""
  )
)
cat_file = function(x){
    y = paste0(readLines(x, warn = FALSE), collapse = "\n")
    cat("`", x, "`\n")
    ext = tools::file_ext(x)
    # if (!tolower(ext) %in% c("r", "python", "sql")) {
    #   ext = ""
    # }
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
# cache -----
knitr::opts_chunk$set(cache = TRUE)
