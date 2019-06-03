
knitr::opts_chunk$set(
    comment = "##",
    echo = TRUE,
    engine.path = "/usr/local/Cellar/python3/3.7.0/bin/python3",
    eval = TRUE,
    message = FALSE,
    warning = FALSE,

    # > figures -----

    dev = "png",
    dev.args = list(
        family = "Avenir",
        pointsize = 11
    ),
    dpi = 150,
    fig.align = "center",
    fig.path = "figures/fig_",
    fig.show = "hold",
    # fig.dim = c(7, 5),
    fig.height = 7 * 2 / (1 + sqrt(5)),
    fig.width = 7,
    out.width = "75%",

    # > code style -----

    tidy = "styler" # use pretty code in output without modfying source

)

# knitr::opts_chunk$set(
#     max.print = 10, # The number of rows to print.
#     rows.print = 10, # The number of rows to display.
#     cols.print = 10, # The number of columns to display.
#     cols.min.print = 10, # The minimum number of columns to display.
#     pages.print = 10, # The number of pages to display under page navigation.
#     paged.print = TRUE, # When set to FALSE turns off paged tables.
#     rownames.print = TRUE # When set to FALSE turns off row names.
# )
