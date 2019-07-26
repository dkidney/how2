
knitr::opts_chunk$set(
  eval = FALSE,
  collapse = TRUE,
    engine.path = list(
        python = "/usr/local/anaconda3/envs/py37/bin/python"
    ),
    python.reticulate = TRUE
)
stopifnot(file.exists(knitr::opts_chunk$get("engine.path")$python))
reticulate::use_python(knitr::opts_chunk$get("engine.path")$python)
