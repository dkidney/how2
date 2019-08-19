# code evaluation -----
knitr::opts_chunk$set(
    eval = TRUE
)
# text results -----
knitr::opts_chunk$set(
    echo = TRUE,
    results = 'hold',
    comment = "##",
    collapse = TRUE,
    prompt = FALSE,
    warning = FALSE,
    message = FALSE
)
# option templates -----
# cat_file
knitr::opts_template$set(
  cat_file = list(
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
    cat(paste0("```", tools::file_ext(x), "\n", y, "\n```"))
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
# python -----
knitr::opts_chunk$set(
  collapse = TRUE,
    engine.path = list(
        python = "/usr/local/anaconda3/envs/py3/bin/python"
    ),
    python.reticulate = TRUE
)
stopifnot(file.exists(knitr::opts_chunk$get("engine.path")$python))
reticulate::use_python(knitr::opts_chunk$get("engine.path")$python)
