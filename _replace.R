
suppressPackageStartupMessages({
    library(fs)
    library(magrittr)
    library(tidyverse)
})
rmd_files = fs::dir_ls(glob = "r_*.Rmd", recurse = TRUE)
rmd_files

pattern = ""
replace = ""

for (rmd_file in rmd_files) { # rmd_file = rmd_files[1] ; rmd_file
    old_content = readLines(rmd_file, warn = FALSE)
    # old_content %>% head(10) %>% writeLines()
    # i = which(old_content %in% 'source("~/github/how2/_knitr_config.R")')
    i = 3
    if (length(i) == 1) {
        message(rmd_file)
        new_content = c(
            old_content[1:(i - 2)],   
            "editor_options:",
            "\tchunk_output_type: console",
            old_content[(i + 2):length(old_content)]   
        )
        # new_content %>% head(10) %>% writeLines()
        writeLines(new_content, con = rmd_file)
    }
}
