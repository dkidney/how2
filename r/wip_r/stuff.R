https://jsonlint.com/



Gitignore



*.Rproj

.Rproj.user

.Rhistory

.Data

.Ruserdata



Meta

doc

/src/*.o

/src/*.o-*

/src/*.d

/src/*.so

.DS_Store

.Rapp.history

.Rbuildignore

.Rhistory

.Rprofile

.Rproj.user

.Ruserdata

.tar.gz

*.Rproj

*.Rd

/CIdata.Rcheck

.httr-oauth





Rbuildignore



^README\.Rmd$

^Meta$

^doc$

^.*\.Rproj$

^\.Rproj\.user$

deprecated

development

FAQ.md

^\.httr-oauth$







Batch



#!/usr/bin/env Rscript

args = commandArgs(trailingOnly = TRUE)





Email



smtp = list(

    "host.name" = "smtp.gmail.com",

    "port"      = "465",

    "ssl"       = TRUE,

    "user.name" = “******”,

    "passwd"    = “******”

)



mailR::send.mail(

                        from = “me <me@what..com>",

                        to = someone@somewhere.com,

                        subject =“subject”,

                        body = body,

                        attach.files = report_names,

                        smtp = smtp,

                        authenticate = TRUE,

                        debug = FALSE

                    )



css = str_c(

    "<!DOCTYPE html>",

    "<html>",

    "<head>",

    "<style>",

    "body { font-family: Avenir; }",

    "body { font-size: 7pt; }",

    "h1 { font-size: 12pt; } ",

    "h1 { padding: 8px 0 8px 0; } ",

    "h1 { margin: 0; } ",

    "h2 { font-size: 9pt; } ",

    "h2 { padding: 8px 0 8px 0; } ",

    "h2 { margin: 0; } ",

    "table, th, td { font-size: 7pt; }",

    "table, th, td { white-space: nowrap; }",

    "table, th, td { border: 1px solid black; }",

    "table { border-collapse: collapse; }",

    "th { text-align: center; }",

    "td { vertical-align: center; }",

    "th { vertical-align: center; }",

    "th { background-color: #C40F11; }",

    "th { color: white; }",

    "th { font-face: normal; }",

    "th, td { padding: 5px 5px 5px 5px; }",

    "</style>",

    "</head>",

    collapse = "\n"

)



view_html = function(x){

    if(interactive()){

        file_path = tempfile(fileext = ".html")

        writeLines(as.character(x), file_path)

        rstudioapi::viewer(file_path)

    }

}



kable_total = df %>%

    knitr::kable(

        format = "html",

        align = "lllllrrrrrrrrrr",

        escape = TRUE

    ) %>%

    kableExtra::column_spec(

        column = c(6:9, 14:15),

        background = "#EEEEEE"

    ) %>%

    kableExtra::add_header_above(

        header = c(

            " " = 1,

            " " = 1,

            " " = 1,

            " " = 1,

            " " = 1,

            "Daily volume" = 4,

            "Cumulative volume" = 4,

            "Cumulative %" = 2

        ),

        line = FALSE

    )



htmltools::tagList(

    htmltools::HTML(css),

    htmltools::HTML(kable_total)

) %>%

    view_html





is_laptop = function(){

  str_detect(str_to_lower(Sys.info()[["sysname"]]), "(darwin|windows)")

}



inst_pkgs = installed.packages(lib)

base_pkgs = rownames(inst_pkgs)[inst_pkgs[,"Priority"] %in% "base"]







#' @title Insert a page break

#' @description Insert a page break in an html or pdf rmarkdown document

#' @param hrule ???

#' \preformatted{

#' ```{r, echo=FALSE, results="asis"}

#' insert_pagebreak()

#' ```

#' }

#'

#' @export



insert_pagebreak = function(hrule = FALSE){

    output = knitr::opts_knit$get("rmarkdown.pandoc.to")

    if(!is.null(output)){

        txt = output %>%

            switch(

                html  = "<P style='page-break-before: always'>",

                docx  = "##### pagebreak",

                latex = "\\newpage"

            )

        if(hrule){

            txt %<>% c("**********\n\n", .)

        }

        cat(txt)

    }

    invisible()

}





tabPanel(

                title = strong("Scores"),

                icon = icon("area-chart"),

                value = "models_tab",

                br(),

		column(

                    width = 9,

                    tabsetPanel(

                        id = “other_tab",

…

)





    # updateTabsetPanel(session, "models_tab", selected = “other_tab“)







knitr::opts_chunk$set(

    comment = "##",

    echo = TRUE,

    # engine = "",

    eval = TRUE,

    dev = "jpeg",

    dev.args = list(

        family = "Avenir",

        # family = "Century Gothic",

        pointsize = 10

    ),

    dpi = 150,

    # fig.align = "center",

    fig.align = "default",

    # fig.dim = c(6, 4),

    fig.asp = 1 / ((1+sqrt(5))/2), # golden ratio :)

    fig.width = 6, # fig width in inches

    # fig.height = 4, # fig height in inches

    fig.path = 'figures/fig_',

    fig.show = 'hold',

    out.width = "50%", # size of figures on page

    message = FALSE,

    warning = FALSE

)

```



******************************************************************************************



## Preamble {-}



```{r r_setup}

library(tidyverse)

library(CIdata)

options(

    knitr.table.format = "html",

    stringsAsFactors = FALSE

)

par(

    family = knitr::opts_chunk$get("dev.args")$family

)

theme_set(

    theme_creditinfo(

        base_family = knitr::opts_chunk$get("dev.args")$family,

        base_size = knitr::opts_chunk$get("dev.args")$pointsize

    )

)

main_dir = "~/Google Drive/Risk Analytics/Projects"

df_print = function(x, caption = NULL, row.names = FALSE){

    x %>%

        knitr::kable(

            caption = caption,

            digits = 5,

            format = "html",

            format.args = list(big.mark = ","),

            row.names = row.names

        ) %>%

        kableExtra::kable_styling(

            full_width = FALSE,

            bootstrap_options = c("striped", "condensed"),

            position = "center"

        ) %>%

        kableExtra::scroll_box(

            height = "400px",

            width = "100%",

            box_css = "border: 0px;"

        )

}

```





snippet trainControl

	ctrl = trainControl(

	    method = "repeatedcv",

	    number = 5,

	    repeats = 1,

	    verboseIter = TRUE,

	    returnResamp = "all",

	    savePredictions = TRUE,

	    classProbs = TRUE,

	    summaryFunction = twoClassSummary

	)





snippet preamble

	# =========================================================================================== #

	# Author: Darren Kidney (Data Scientist, Risk Analytics)

	# Date: 2018-XX-XX

	# Description:

	# =========================================================================================== #



	suppressPackageStartupMessages({

		library(tidyverse)

		library(CIdata)

	})

	options(

		# digits = 5,

		# scipen = 20,

		warn = 1, # print warnings as they occur

		stringsAsFactors = FALSE

	)

	par(family = "Avenir")

	theme_set(theme_creditinfo(base_family = "Avenir"))

	main_dir = "~/Google Drive/Risk Analytics"

	file.exists(main_dir)

	seed = 42







#' @rdname get_credentials

#' @name get_aws_credentials

#' @title Get access credentials for AWS or MySQL

#' @description Loads credentials from a local file and sets the appropriate

#'   environment variables.

#' @param credentials_file full path of the credentials file on the current machine,

#'   including filename.

#' @export

get_aws_credentials = function(credentials_file = "~/.aws/credentials"){

  if(is_laptop()){

    credentials = get_credentials(credentials_file)

    Sys.setenv(

      "AWS_ACCESS_KEY_ID"     = credentials$aws_access_key_id,

      "AWS_SECRET_ACCESS_KEY" = credentials$aws_secret_access_key,

      "AWS_DEFAULT_REGION"    = "eu-west-1"

    )

  }

  invisible()

}





#' @rdname get_credentials

#' @name get_mysql_credentials

#' @export

get_mysql_credentials = function(credentials_file = "~/.mysql/credentials"){

  if(is_laptop()){

    credentials = get_credentials(credentials_file)

    Sys.setenv(

      "MYSQL_01_HOST_STG" = credentials$mysql_01_host_stg,

      "MYSQL_01_HOST_PRD" = credentials$mysql_01_host_prd,

      "MYSQL_01_USERNAME" = credentials$mysql_01_username,

      "MYSQL_01_PASSWORD" = credentials$mysql_01_password,

      "MYSQL_03_HOST_PRD" = credentials$mysql_03_host_prd,

      "MYSQL_03_USERNAME" = credentials$mysql_03_username,

      "MYSQL_03_PASSWORD" = credentials$mysql_03_password

    )

  }

  invisible()

}





get_credentials = function(credentials_file){

  if(!file.exists(credentials_file)){

    stop("credentials file '", credentials_file, "' not found")

  }

  credentials_file %>%

    readLines %>%

    str_split(" = ") %>%

    { set_names(map(., 2), map_chr(., 1)) } %>%

    compact

}



is_laptop = function(){

  str_detect(str_to_lower(Sys.info()[["sysname"]]), "(darwin|windows)")

}









#' @rdname s3_helper

#' @name s3_read_file

#' @title S3 helper functions

#' @description Read/download/upload objects/files to/from AWS S3.

#' @param object the file path of the s3 object

#' @param bucket the name of the s3 bucket

#' @param FUN function to use to read file

#' @param overwrite either "no" (don't overwrite), "ask" (ask before overwriting) or "yes"

#'   (overwrite without asking)

#' @param cleanup if \code{TRUE}, any temporary local files be deleted

#' @param verbose if \code{TRUE}, progress messages will be printed to the console

#' @param ... additional arguments to pass to \code{FUN}

#' @export



s3_read_file = function(object,

                        bucket = "coremetrix-analytics",

                        FUN = NULL,

                        local_path = NULL,

                        overwrite = "yes",

                        cleanup = TRUE,

                        verbose = getOption("CIdata_verbose"), ...){



    op = options(CIdata_verbose = verbose)

    on.exit(options(op))

    file_name = object %>% basename

    ext = file_name %>% tools::file_ext()

    if(isTRUE(ext == "")){

        warn("no file extension - returning NULL")

        return(NULL)

    }

    if(is.null(FUN)){

        FUN = ext %>%

            switch(

                "csv"  = readr::read_csv,

                "json" = jsonlite::fromJSON,

                "rds"  = base::readRDS,

                "tsv"  = readr::read_tsv,

                "xls"  = readxl::read_xls,

                "xlsx" = readxl::read_xlsx,

                "jpeg" = read_image,

                "jpg" = read_image,

                "gif" = read_image,

                NULL

            )

    }

    if(is.null(FUN)){

        warn("no function provided for this file extension - returning NULL")

        return(NULL)

    }

    if(is.null(local_path)){

        local_path = file.path(tempdir(), file_name)

    }

    s3_download_file(

        bucket = bucket,

        object = object,

        local_path = local_path,

        overwrite = overwrite,

        verbose = verbose

    )

    if(!file.exists(local_path)){

        return(NULL)

    }

    out = FUN(local_path, ...)

    if(cleanup){

        unlink(local_path, force = TRUE, recursive = TRUE)

    }

    out

}





#' @rdname s3_helper

#' @name s3_download_file

#' @param local_path local path to downloaded to / upload from

#' @export

s3_download_file = function(object,

                            bucket = "coremetrix-analytics",

                            local_path = NULL,

                            overwrite = "ask",

                            verbose = getOption("CIdata_verbose")){



    op = options(CIdata_verbose = verbose)

    on.exit(options(op))

    get_aws_credentials()

    object_exists = s3_object_exists(

        object = object,

        bucket = bucket

    )

    if(!object_exists){

        message("s3:", file.path(bucket, object), " does not exist")

        return(invisible())

    }

    if(is.null(local_path)){

        local_path = file.path("~/Downloads", basename(object))

    }

    if(!file.exists(dirname(local_path))){

        warn("dirname(local_path) does not exist")

        return(invisible())

    }

    file_exists = file.exists(local_path)

    if(file_exists && isTRUE(overwrite == "no")) return(invisible())

    if(file_exists && isTRUE(overwrite == "ask")){

        response = select.list(

            choices = c("No", "Yes"),

            title = str_c(

                "\nfile already exists in:\n\n",

                local_path,

                "\n\nare you sure you want to overwrite it?"

            )

        )

        if(response == "No") return(invisible())

    }

    print_progress("downloading file to ", local_path, " ...")

    command = str_c("aws s3 cp s3://", bucket, "/", object, " ", local_path)

    result = try(system(command, intern = TRUE), TRUE)

    if(inherits(result, "try-error") || !file.exists(local_path)){

        warn("file could not be downloaded")

    }

}





#' @rdname s3_helper

#' @name s3_upload_file

#' @export

s3_upload_file = function(local_path,

                          object,

                          bucket = "coremetrix-analytics",

                          overwrite = "ask",

                          verbose = getOption("CIdata_verbose")){



    op = options(CIdata_verbose = verbose)

    on.exit(options(op))

    get_aws_credentials()

    object_exists = s3_object_exists(bucket = bucket, object = object)

    if(object_exists && isTRUE(overwrite == "no")){

        print_progress("object already exists on S3 - not overwriting")

        return(invisible())

    }

    if(object_exists && isTRUE(overwrite == "ask")){

        response = select.list(

            choices = c("No", "Yes"),

            title = str_c(

                "\nobject already exists on s3:\n\n",

                file.path(bucket, object),

                "\n\nare you sure you want to overwrite it?"

            )

        )

        if(response == "No"){

            print_progress("file not uploaded")

            return(invisible())

        }

    }

    print_progress("uploading file to S3: ", file.path(bucket, object), " ...")

    temp = capture.output({

        aws.s3::put_object(

            bucket = bucket,

            object = object,

            file = local_path

        )

    })

    if(!s3_object_exists(bucket = bucket, object = object)){

        warn("file could not be uploaded")

    }

}





#' @rdname s3_helper

#' @name s3_upload_json

#' @param x an R object to be uploaded

#' @export

s3_upload_json = function(x, object, bucket = "coremetrix-analytics", ...){

    local_path = tempfile(fileext = ".json")

    x %>% write(local_path)

    s3_upload_file(

        bucket = bucket,

        object = object,

        local_path = local_path,

        ...

    )

    unlink(local_path, force = TRUE, recursive = TRUE)

}





#' @rdname s3_helper

#' @name s3_upload_rds

#' @export

s3_upload_rds = function(x, object, bucket = "coremetrix-analytics", ...){

    local_path = tempfile(fileext = ".rds")

    x %>% saveRDS(local_path)

    s3_upload_file(

        bucket = bucket,

        object = object,

        local_path = local_path,

        ...

    )

    unlink(local_path, force = TRUE, recursive = TRUE)

}





#' @rdname s3_helper

#' @name s3_upload_csv

#' @export

s3_upload_csv = function(x, object, bucket = "coremetrix-analytics", ...){

    local_path = tempfile(fileext = ".csv")

    x %>% write_csv(local_path)

    s3_upload_file(

        bucket = bucket,

        object = object,

        local_path = local_path,

        ...

    )

    unlink(local_path, force = TRUE, recursive = TRUE)

}





#' @rdname s3_helper

#' @name s3_bucket_exists

#' @export

s3_bucket_exists = function(bucket){

    get_aws_credentials()

    as.logical(aws.s3::bucket_exists(bucket))

}



#' @rdname s3_helper

#' @name s3_object_exists

#' @export

s3_object_exists = function(object, bucket = "coremetrix-analytics"){

    length(s3_bucket_contents(bucket = bucket, prefix = object)) >= 1

}





#' @rdname s3_helper

#' @name s3_bucket_contents

#' @param prefix character string that limits the response to keys that begin with the

#'   specified prefix

#' @export

s3_bucket_contents = function(prefix = "", bucket = "coremetrix-analytics", ...){

    aws.s3::get_bucket(bucket = bucket, prefix = prefix, ...) %>%

        map_chr("Key") %>%

        unname

}





#' @rdname s3_helper

#' @name s3_delete_object

#' @export

s3_delete_object = function(object,

                            bucket = "coremetrix-analytics",

                            overwrite = "ask"){



    get_aws_credentials()

    if(!s3_object_exists(bucket = bucket, object = object)){

        message("file not found")

        return(invisible())

    }

    if(overwrite){

        response = select.list(

            choices = c("No", "Yes"),

            title = str_c(

                "\nare you sure you want to delete this file?\n\n",

                file.path(bucket, object)

            )

        )

        if(response == "No"){

            message("file not deleted")

            return(invisible())

        }

    }

    temp = capture.output({

        aws.s3::delete_object(bucket = bucket, object = object)

    })

}









#' @title Print R session information

#' @description Prints to the console:

#' \itemize{

#'   \item timestamp (using local UK time)

#'   \item computer node name

#'   \item R version

#'   \item versions of currently loaded packages

#' }

#' @param tz timezone to use for timestamps

#' @export

session_info = function(tz = Sys.timezone()){

    info = list(

        date = format(Sys.Date(), tz = tz),

        time = format(Sys.time(), "%H:%M:%S", tz = tz),

        tz = tz,

        version = R.version.string,

        os = utils::sessionInfo()$running,

        system = version$system,

        ui = .Platform$GUI,

        nodename = Sys.info()["nodename"],

        interactive = interactive()

    )

    cli::cat_rule("Session info", width = getOption("width"))

    cat("\n")

    w = max(nchar(names(info))) + 1

    for(i in seq_along(info)){

        names(info)[i] %>% str_pad(w, "right") %>% cat

        info[[i]] %>% cat("\n")

    }

    cat("\n")

    cli::cat_rule("Loaded packages", width = getOption("width"))

    cat("\n")

    info$attached_packages = attached_packages()

    if(is.null(info$attached_packages)){

        cat("no packages loaded")

    }else{

        temp = info$attached_packages %>%

            arrange(.data$name)

        w = max(nchar(temp$name)) + 1

        for(i in 1:nrow(temp)){

            temp$name[i] %>% str_pad(w, "right") %>% cat

            temp$version[i] %>% cat("\n")

        }

    }

    cat("\n")

    invisible(info)

}



attached_packages = function(){

    attached = sessionInfo()[["otherPkgs"]]

    if(is.null(attached)) return(NULL)

    data_frame(

        name = attached %>% names,

        version = attached %>% map_chr("Version")

    )

}



loaded_packages = function(){

    installed_packages() %>%

        filter(.data$name %in% loadedNamespaces())

}



installed_packages = function(){

    installed = installed.packages()

    data_frame(name = rownames(installed),

               version = installed[, "Version"])

}



is_attached = function(pkgs){

    attached = attached_packages()

    if(is.null(attached)) return(rep(FALSE, length(pkgs)))

    pkgs %in% attached$name

}



is_loaded = function(pkgs){

    loaded = loaded_packages()

    if(is.null(loaded)) return(rep(FALSE, length(pkgs)))

    pkgs %in% loaded$name

}



is_installed = function(pkgs){

    installed = installed_packages()

    if(is.null(installed)) return(rep(FALSE, length(pkgs)))

    pkgs %in% installed$name

}





# ---------------------------------------------------------------------------- #



#' @rdname file_utils

#' @name file_name_sans_ext

#' @title File utilities

#' @description

#'

#' \code{file_name_sans_ext} - extracts file names from file paths (like \link[base]{basename}

#' but omits the extension)

#'

#' \code{check_file_exists} - checks to see if the files/folders exist - if \code{TRUE} then

#' paths are silently returned, if \code{FALSE} then prints files not found and throws an error

#'

#' @param x character vector of file paths

#' @export

#' @examples

#' \dontrun{

#'

#' x = c("a/file/path/my_file.txt",

#'       "a/file/path/my_other_file.txt")

#' tools::file_path_sans_ext(x)

#' basename(x)

#' file_name_sans_ext(x)

#' check_file_exists(x)

#' }

file_name_sans_ext = function(x){

    x %>%

        basename %>%

        tools::file_path_sans_ext()

}



#' @rdname file_utils

#' @name check_file_exists

#' @export

check_file_exists = function(x){

    ok = x %>% path.expand %>% file.exists

    if(any(!ok)){

        error("can't find")

        items(x[!ok])

        stop()

    }

    invisible(x)

}





# ---------------------------------------------------------------------------- #



#' @title Print exact decimal places

#' @description Print a value to the exact number of decimal places required. This function is

#'   a wrapper for \link[base]{sprintf}.

#' @param x a numeric vector

#' @param digits the number of decimal places required

#' @export

#' @examples

#' 1 %>% round(3)

#' 1 %>% round_chr(3)

round_chr = function(x, digits = 0){

    i = is.na(x)

    out = sprintf(str_c("%.", digits, "f"), x)

    out[i] = NA_character_

    out

}





# ---------------------------------------------------------------------------- #



#' @rdname tri

#' @name lower_tri

#' @title Get the lower or upper triangle of a matrix.

#' @description Convert the upper/lower elements of a square matrix to NA.

#' @param x a square matrix

#' @export

#' @examples

#' x = matrix(1:16, 4)

#' x %>% lower_tri

#' x %>% upper_tri

lower_tri = function(x){

    if(!(inherits(x, 'matrix') && nrow(x) == ncol(x)))

        stop("expecting a square matrix")

    x[!lower.tri(x)] = NA

    return(x)

}



#' @rdname tri

#' @name lower_tri

#' @export

upper_tri = function(x){

    if(!(inherits(x, 'matrix') && nrow(x) == ncol(x)))

        stop("expecting a square matrix")

    x[!upper.tri(x)] = NA

    return(x)

}





# ---------------------------------------------------------------------------- #



sum_na = function(x){

    sum(is.na(x))

}



prop_na = function(x){

    mean(is.na(x))

}



any_na = function(x){

    any(is.na(x))

}



all_na = function(x){

    all(is.na(x))

}



not_any_na = function(x){

    !anyNA(x)

}



not_all_na = function(x){

    !all(is.na(x))

}



replace_null = function(x, replacement = NULL){

    x %>% rlang::`%||%`(replacement)

}



get_hostname = function(){

    Sys.info()["nodename"] %>% unname

}



is_macbook = function(){

    get_hostname() %>% str_detect("MacBook")

}





# ---------------------------------------------------------------------------- #



#' @rdname is_true

#' @name is_true

#' @title Identify TRUE/FALSE elements of a logical vector

#' @description Identify TRUE/FALSE elements of a logical vector - \code{NA} elements are

#'   converted to \code{FALSE}. Note that \link[rlang]{is_true} isn't used since it isn't

#'   vectorised.

#' @param x logical vector

#' @export

#' @examples

#' x = c(TRUE, FALSE, NA)

#' is_true(x)

#' is_false(x)

#' is_not_true(x)

#' is_not_false(x)

is_true = function(x){

    x %in% TRUE

}



#' @rdname is_true

#' @name is_false

#' @export

is_false = function(x){

    x %in% FALSE

}



#' @rdname is_true

#' @name is_not_true

#' @export

is_not_true = function(x){

    !x %in% TRUE

}



#' @rdname is_true

#' @name is_not_false

#' @export

is_not_false = function(x){

    !x %in% FALSE

}



isFALSE = function(x){

    identical(FALSE, x)

}



# ---------------------------------------------------------------------------- #



split_data_frame = function(x, column, drop = FALSE, reorder = FALSE){

    f = x[[column]]

    if(!is.factor(f)){

        f %<>% as.factor

        if(!reorder) f %<>% fct_inorder

    }

    if(drop) x %<>% select(-one_of(!!column))

    x %>% split(f)

}



# ---------------------------------------------------------------------------- #



has_names = function(x, names){

    all(names %in% names(x))

}



theme_blank = function(base_size = 10, base_family = "Century Gothic"){

    theme_void(base_size, base_family) +

        theme(

            panel.border = element_blank(),

            panel.grid.major = element_blank(),

            panel.grid.minor = element_blank()

        )

}







#' @rdname connect_db

#' @name connect_mysql

#' @title Connect to a MySQL database

#' @description ???

#' @param host ???

#' @param dbname ???

#' @param stg ???

#' @details ???

#' @export

connect_mysql = function(host = "mysql-01", dbname = "quizdb", stg = FALSE){



    # check for an existing connection

    host_ = host

    host %<>% str_c(".", if(stg) "stg" else "prd")

    cons = DBI::dbListConnections(DBI::dbDriver(drv = "MySQL")) %>%

        keep(., map_chr(map(., DBI::dbGetInfo), "host") %>% str_detect(str_c("^", host_))) %>%

        keep(., map_chr(map(., DBI::dbGetInfo), "dbname") == dbname)

    if(length(cons) > 0) return(cons[[1]])



    # establish a new connection

    get_mysql_credentials()

    prefix = host_ %>% str_to_upper %>% str_replace("-", "_")

    conn = try({

        DBI::dbConnect(

            drv      = RMySQL::MySQL(),

            host     = Sys.getenv(str_c(prefix, "_HOST_", if(stg) "STG" else "PRD")),

            port     = 3306,

            user     = Sys.getenv(str_c(prefix, "_USERNAME")),

            password = Sys.getenv(str_c(prefix, "_PASSWORD")),

            dbname   = dbname

        )

    }, TRUE)

    if(inherits(conn, "try-error")){

        warn("can't connect to ", host, ":", dbname, " - check your internet and VPN connection")

        return(invisible())

    }

    conn



}



#' @rdname connect_db

#' @name connect_analyticsdb

#' @export

connect_analyticsdb = function(){

    connect_mysql(host = "mysql-03", dbname = "analyticsdb", stg = FALSE)

}



#' @rdname connect_db

#' @name get_table

#' @param table ???

#' @export

get_table = function(table = "quiz", dbname = "analyticsdb", host = "mysql-03", stg = FALSE){

    con = connect_mysql(host = host, dbname = dbname, stg = stg)

    if(is.null(con)) return(NULL)

    suppressWarnings(tbl(con, table))

}













#' @title ROC plot

#' @description \code{ggplot} implementation of a ROC plot. Uses \link[dplyr]{do} and

#'   \link[pROC]{roc} under the hood. It allows for three additional categorical variables to

#'   be used: one for colour and two for faceting.

#'

#' @param x vector of continuous predictor values

#' @param y vector of binary response values

#' @param colour vector of values to use for colour coding (optional)

#' @param facet_x vector of values to use for horizontal faceting (optional)

#' @param facet_y vector of values to use for vertical faceting (optional)

#' @param na_rm if \code{TRUE} then missing values will be removed from grouping variables

#'   prior to plotting

#' @param ... additional arguments to pass to \link[pROC]{roc}

#'

#' @export

#' @examples

#' \dontrun{

#'

#' library(CIdata)

#' n = 1000

#' mu = runif(n)

#' x = mu + rnorm(n)

#' y = as.integer(mu > 0.5)

#' group1 = sample(c("1A", "1B"), n, replace = TRUE)

#' group2 = sample(c("2A", "2B"), n, replace = TRUE)

#' group3 = sample(c("3A", "3B"), n, replace = TRUE)

#' plot_roc(x, y, group1, group2, group3)

#' plot_roc(x, y, group1, group2, group3, smooth = TRUE)

#' }



plot_roc = function(x,

                    y,

                    colour = NULL,

                    facet_x = NULL,

                    facet_y = NULL,

                    na_rm = TRUE,

                    ...){



    # raw data for plotting

    df = data_frame(

        x       = x,

        y       = y,

        colour  = if(is.null(colour)) "" else colour,

        facet_x = if(is.null(facet_x)) "" else facet_x,

        facet_y = if(is.null(facet_y)) "" else facet_y

    ) %>%

        drop_na(.data$x, .data$y) %>%

        mutate_at(c("colour", "facet_x", "facet_y"), as.factor)



    if(na_rm){

        df %<>%

            drop_na(colour, facet_x, facet_y)

    }



    # sensitivities and specificities

    df %<>%

        drop_na %>%

        split_data_frame("colour") %>%

        map(function(x){

            x %>%

                split_data_frame("facet_x") %>%

                map(function(x){

                    x %>%

                        split_data_frame("facet_y") %>%

                        map(function(x){

                            # browser()

                            result = try({

                                pROC::roc(response = x$y, predictor = x$x, ...) %>%

                                    `[`(c("sensitivities", "specificities")) %>%

                                    as_data_frame %>%

                                    mutate(

                                        colour = x$colour %>% unique,

                                        facet_x = x$facet_x %>% unique,

                                        facet_y = x$facet_y %>% unique

                                    )

                            }, TRUE)

                            if(inherits(result, "try-error")) return(NULL)

                            result

                        }) %>%

                        bind_rows

                }) %>%

                bind_rows

        }) %>%

        bind_rows



    # base plot

    plot_obj = df %>%

        mutate(fpr = 1 - .data$sensitivities) %>%

        mutate(tpr = .data$specificities) %>%

        ggplot(aes_string("fpr", "tpr")) +

        geom_abline(slope = 1, intercept = 0, col = ci_grey) +

        coord_equal() +

        scale_x_continuous(limits = c(0, 1), expand = c(0,0), breaks = seq(0, 1, 0.2)) +

        scale_y_continuous(limits = c(0, 1), expand = c(0,0), breaks = seq(0, 1, 0.2)) +

        labs(x = "False positive rate", y = "True positive rate", colour = substitute(colour))



    # colours

    if(is.null(colour)){

        plot_obj = plot_obj +

            geom_line()

    }else{

        plot_obj = plot_obj +

            geom_line(aes(col = colour)) +

            scale_colour_manual(values = c(ci_colors(), ci_colors()) %>% unname)

    }



    # faceting

    if(!is.null(facet_x) & !is.null(facet_y)){

        plot_obj = plot_obj + facet_grid(facet_y ~ facet_x)

    }

    if(!is.null(facet_x) & is.null(facet_y)){

        plot_obj = plot_obj + facet_grid(. ~ facet_x)

    }

    if(is.null(facet_x) & !is.null(facet_y)){

        plot_obj = plot_obj + facet_grid(facet_y ~ .)

    }



    plot_obj



}









flatten_text = function(...){

    list(...) %>%

        map(as.character) %>%

        map_chr(str_flatten) %>%

        str_flatten

}



print_progress = function(..., .verbose = getOption("CIdata_verbose")){

    if(isTRUE(.verbose)) cli::cat_line(flatten_text(...))

}

# print_progress = function(...,

#                           # .colour = "white",

#                           .prefix = NULL,

#                           # .bold = FALSE,

#                           .n_lines_before = 0,

#                           .n_lines_after = 1,

#                           .verbose = getOption("CIdata_verbose")){

#     # check_is_scalar_character(.colour)

#     if(!is.null(.prefix)) check_is_scalar_character(.prefix)

#     # check_is_scalar_logical(.bold)

#     # check_is_scalar_logical(.n_lines_after)

#     # check_is_scalar_logical(.n_lines_before)

#     if(is.null(.verbose)) .verbose = TRUE

#     check_is_scalar_logical(.verbose)

#     txt = flatten_text(...) %>%

#     # txt = list(...) %>%

#     #     map(as.character) %>%

#     #     map_chr(str_flatten) %>%

#     #     str_flatten %>%

#         str_c(.prefix, .)

#     # if(!is.null(.colour) && !is.na(.colour)){

#     #     try({

#     #         txt %<>% crayon::make_style(.colour)()

#     #     }, TRUE)

#     # }

#     # if(.bold){

#     #     try({

#     #         txt %<>% crayon::bold()

#     #     }, TRUE)

#     # }

#     txt %<>% str_c(str_c(rep("\n", .n_lines_before), collapse = ""), .)

#     txt %<>% str_c(str_c(rep("\n", .n_lines_after), collapse = ""))

#     if(is.null(.verbose) || .verbose){

#         cat(txt)

#     }

#     invisible(txt)

# }



#' @rdname print_progress

#' @name heading

#' @aliases print_progress

#' @title Progress messages

#' @description Convenience functions for printing progress messages to the console.

#' @param ... one or more character vectors

# @param .width line width

# @param .char character to use for the line or bullet

# @param .prefix optional prefix

# @param .colour text colour

# @param .bold text bold

# @param .n_lines_before if \code{TRUE}, a new line character will be added to the beginning of the text

# @param .n_lines_after if \code{TRUE}, a new line character will be added to the end of the text

#' @param .verbose if \code{FALSE}, messages will not be printed

#' @export

#' @examples

#' \dontrun{

#'

#' heading("a heading")

#' bullet("a bullet")

#' bullet("a ", "bullet")

#' bullet(c("a ", "bullet"))

#' bullets("some", "bullets")

#' bullets(c("some", "more", "bullets"))

#' item("an item")

#' items("some", "items")

#' items(c("some", "more", "items"))

#' error("an error")

#' warn("a warning")

#' }

heading = function(..., .verbose = getOption("CIdata_verbose")){

    if(isTRUE(.verbose)){

        cat("\n")

        cli::cat_rule(flatten_text(...), width = getOption("width"))

        cat("\n")

    }

}



#' @rdname print_progress

#' @name bullet

#' @export

bullet = function(..., .verbose = getOption("CIdata_verbose")){

    if(isTRUE(.verbose)) cli::cat_bullet(flatten_text(...))

}



#' @rdname print_progress

#' @name item

#' @export

item = function(..., .verbose = getOption("CIdata_verbose")){

    if(isTRUE(.verbose)) cli::cat_bullet(flatten_text(...), bullet = "line")

}



#' @rdname print_progress

#' @name bullets

#' @export

bullets = function(..., .verbose = getOption("CIdata_verbose")){

    if(isTRUE(.verbose)) walk(as.list(c(...)), bullet)

}



#' @rdname print_progress

#' @name items

#' @export

items = function(..., .verbose = getOption("CIdata_verbose")){

    if(isTRUE(.verbose)) walk(as.list(c(...)), item)

}



#' @rdname print_progress

#' @name warn

#' @param .prefix prefix string

#' @export

# warn = rlang::warn

warn = function(..., .prefix = "WARNING: "){

    if(getOption("warn") != 0) message(.prefix, flatten_text(...))

}



#' @rdname print_progress

#' @name error

#' @export

error = function(...) stop(...)







#' @title Mosaic plot

#' @description A ggplot implementation of mosaic plots. The function is Based on

#'   \link[ggplot2]{geom_bar}, with \code{stat = "identity"} and \code{position = "fill"},

#'   but with a modified \code{width} aesthetic so that the width of the bars reflects the

#'   sample sizes of the x-category levels and the spacings between the bars are equally

#'   sized.

#' @param X categorical variable for the x-axis

#' @param Y categorical variable for the y-axis

#' @param gap numeric scalar controlling the spacing between the bars (giving the

#'   percentage of the combined bar width to be used for the spacing between bars

#' @param border_col colour of the border around the bars

#' @param na_rm if \code{TRUE} then missing values will be ignored

#' @param plot if \code{TRUE} the plot will be drawn, if \code{FALSE} the plot

#'   object will be invisibly returned.

#' @export

#' @examples

#' \dontrun{

#'

#' id = "a80fbe01-3288-4829-9c04-a3f49afbd059"

#' quiz = get_quiz(id)

#' plot_mosaic(quiz$data$Q1, quiz$data$Q12)

#' plot_mosaic(quiz$data$Q1, quiz$data$Q12, border_col = 1)

#' plot_mosaic(quiz$data$Q1, quiz$data$Q12, border_col = 1, gap = 0)

#' plot_mosaic(quiz$data$Q1, quiz$data$Q12, border_col = 1, gap = 20, na_rm = FALSE)

#' }



plot_mosaic = function(X, Y, gap = 10, border_col = NA, na_rm = TRUE, plot = TRUE){



    if(gap < 0) stop("gap must be greater than or equal to 0")



    df = data_frame(x = X, y = Y)



    if(na_rm){

        df %<>% na.omit

    }



    df %<>%

        group_by(.data$x, .data$y) %>%

        summarise(n = n()) %>%

        ungroup



    breaks = df %>%

        group_by(.data$x) %>%

        summarise(width = sum(.data$n)) %>%

        mutate(breaks = mosaic_x_breaks(.data$width, gap = gap))



    df %>%

        left_join(breaks, by = "x") %>%

        ggplot(aes_string("breaks", "n", fill = "y", width = "width")) +

        geom_bar(stat = "identity", position = "fill", colour = border_col) +

        scale_x_continuous(breaks = breaks$breaks, labels = breaks$x, expand = c(0,0)) +

        scale_y_continuous(expand = c(0,0)) +

        labs(x = "X", fill = "Y") +

        scale_fill_manual(values = c(ci_colors(), ci_colors()) %>% unname) +

        theme(

            axis.text.y  = element_blank(),

            axis.ticks   = element_blank(),

            axis.title.y = element_blank(),

            panel.background = element_blank(),

            panel.grid.major = element_blank(),

            panel.grid.minor = element_blank(),

            panel.border = element_blank()

        )



}



mosaic_x_breaks = function(widths, gap = 10){

    half_width = widths / 2

    lag_half_width = half_width %>% lag %>% if_else(is.na(.), 0, .)

    gap = sum(widths) * gap / 100 / (length(widths) - 1)

    cumsum(half_width + lag_half_width + gap)

}







#' @title WOE plot

#' @description Plot a bar chart of weight-of-evidence values. This function uses

#'   \link[CImodelling]{characteristic_table} to compute the weight-of-evidence values and

#'   \link[ggplot2]{ggplot} + \link[ggplot2]{geom_bar} to make the plot.

#'

#' @param x data frame containing predictor variable(s) (numeric predictors will be ignored)

#' @param y vector of binary response values (1 = bad, 0 = good), or column name of response

#'   variable if \code{x} contains the response (if \code{NULL}, the first column of \code{x}

#'   is assumed to be the response)

#' @param values if \code{TRUE}, iv values will added as labels at the end of each bar

#' @param values_cex text size to use for values

#' @param ... additional arguments to pass to \link[CImodelling]{characteristic_table}

#'

#' @export

#' @examples

#' \dontrun{

#'

#' library(tidyverse)

#' library(CIdata)

#' n = 100

#' x = data_frame(

#'   y = sample(0:1, n, prob = c(0.8, 0.2), replace = TRUE),

#'   x1 = sample(LETTERS[1:5], n, replace = TRUE),

#'   x2 = sample(9:12, n, replace = TRUE) %>% as.character, # will be plotted alphabetically

#'   x3 = sample(9:12, n, replace = TRUE) %>% factor(9:12) # level order preserved

#' )

#' plot_woe(x)

#' }



plot_woe = function(x,

                    y = NULL,

                    values = TRUE,

                    values_cex = 3,

                    ...){



    if(is.null(y)){

        y = x[[1]] %>% as.integer

        check_is_binary(y)

        x = x %>% select(-1)

    }

    ctable = CImodelling::characteristic_table(x, y, ...)

    ctable %>%

        plot_woe_(values = values, values_cex = values_cex)



}



plot_woe_ = function(ctable,

                     values = TRUE,

                     values_cex = 3,

                     ...){



    df = ctable %>%

        select(.data$predictor,

               .data$level,

               .data$woe,

               "n" = .data$n_w,

               "nbad" = .data$n_bad_w,

               "badrate" = .data$bad_rate_w) %>%

        mutate(label = str_c(.data$nbad, .data$n, sep = " / ")) %>%

        mutate(vjust = if_else(.data$woe < 0, 1.5, -0.75))



    # hack to preserve factor level order in facet_wrap

    # adds white space around any duplicated levels

    while(any(duplicated(df$level))){

        df$level[duplicated(df$level)] %<>% str_c(" ", ., " ")

    }



    good_over_bad = ctable %>%

        drop_na(.data$bad_rate_w, .data$woe) %>% {

            cor(.$bad_rate_w, .$woe) %>% `<`(., 0)

        }



    plot_obj = df %>%

        mutate(level = .data$level %>% as.factor %>% fct_inorder) %>%

        ggplot(aes_string("level", "woe", fill = "woe")) +

        geom_bar(stat = "identity") +

        geom_hline(yintercept = 0) +

        labs(x = NULL, y = "Weight-of-evidence") +

        scale_fill_gradient2(

            high = if(good_over_bad) ci_teal else ci_red,

            low = if(good_over_bad) ci_red else ci_teal,

            mid = ci_grey

        ) +

        theme(legend.position = "none")



    # facets

    if(nlevels(df$predictor) > 1){

        plot_obj = plot_obj +

            facet_wrap(~ predictor, scales = "free_x")

    }



    if(values){

        plot_obj = plot_obj +

            geom_text(aes_string(label = "label"), vjust = df$vjust, col = grey(0.1),

                      size = values_cex)

    }



    plot_obj



}











#' @rdname characteristic_table

#' @name characteristic

#' @title Calculate WoE and IV values

#' @description Functions to calculate Information Value and Weight-of-Evidence. Each

#'   function can take a single predictor or a data frame of predictors as an input.

#' @author Darren Kidney & Vaishali Mahalingam

#'

#'   The main function is \code{characteristic_table} which returns a data_frame with one

#'   row per predictor level. The \code{iv} and \code{woe} functions are convenience

#'   wrappers to \code{characteristic_table} and produce more concise output.

#' @param y binary response vector: 1 = bad, 0 = good

#' @param x predictor variable vector or data frame of predictors (numeric predictors

#'   will be ignored)

#' @param w optional vector of sampling weights

#' @param adjust adjustment factor to avoid undefined WoE values (reference needed)

#' @param min_total minimum (unweighted) sample size per predictor level

#' @param min_bads minimum (unweighted) number of bads per predictor level

#' @param woe_min_range minimum threshold for the WoE range within each predictor

#' @param woe_min_level minimum threshold for the WoE value for each predictor level

#' @param woe_ignore_level predictor levels to ignore

#' @param good_over_bad ???

#' @param na_rm ???

#' @param ... ???

#' @details Explain what the control arguments do...

#  \tabular{ll}{

#   asdf \tab asfd \cr

#  }

#'

#' \deqn{WOE_i = log((ngood_i / Ngood) / (nbad_i / Nbad))}

#' \deqn{IV = SUM_i {((ngood_i / Ngood) - (nbad_i / Nbad)) * WOE_i}}

#'

#' SAS support help page on computing weight of evidence and information value:

#'

#' \url{http://support.sas.com/documentation/cdl/en/prochp/66704/HTML/default/viewer.htm#prochp_hpbin_details02.htm}

#'

#' @return A data frame of statistics.

#' @example inst/examples/example-characteristic_table.r

#' @export



characteristic_table = function(x, y, w = NULL,

                                adjust = 0,

                                min_total = 1,

                                min_bads = 0,

                                woe_min_range = 0,

                                woe_min_level = 0,

                                woe_ignore_level = "NA",

                                good_over_bad = TRUE,

                                na_rm = FALSE){



    # coerce x from vector to data_frame

    if(!inherits(x, "data.frame")){

        x %<>% data_frame(x = .)

    }



    # coerce y from name to vector

    if(is_scalar_character(y)){

        if(!y %in% colnames(x)){

            stop("no column named ", y, " in x")

        }

        tmp = y

        y = x[[y]]

        x[[tmp]] = NULL

    }



    # coerce y from factor to binary

    if(is.factor(y)){

        y = as.integer(y) - 1

    }



    # coerce w from name to vector

    if(is_scalar_character(w)){

        if(!w %in% colnames(x)){

            stop("no column named ", w, " in x")

        }

        tmp = w

        w = x[[w]]

        x[[tmp]] = NULL

    }



    x %>%

        as_data_frame %>%

        map(

            characteristic_table_,

            y                = y,

            w                = w,

            adjust           = adjust,

            min_total        = min_total,

            min_bads         = min_bads,

            woe_min_range    = woe_min_range,

            woe_min_level    = woe_min_level,

            woe_ignore_level = woe_ignore_level,

            good_over_bad    = good_over_bad,

            na_rm            = na_rm

        ) %>% {

            # add a predictor column

            map2(., names(.), function(x, y){

                x %>%

                    mutate(predictor = y) %>%

                    select(predictor, everything())

            })

        } %>%

        compact %>%

        bind_rows %>%

        mutate(predictor = predictor %>% factor %>% fct_inorder)



}



#' @rdname characteristic_table

#' @name iv

#' @export

iv = function(x, y, ...){

    characteristic_table(x, y, ...) %>%

        select(predictor, iv) %>%

        distinct

}



#' @rdname characteristic_table

#' @name woe

#' @export

woe = function(x, y, ...){

    characteristic_table(x, y, ...) %>%

        select(-N_w, -N_bad_w, -N_good_w) %>%

        select(-prop_w, -prop_bad_w, -prop_good_w) %>%

        select(predictor, level, level_order, woe, ends_with("_w"))

}



#' @rdname characteristic_table

#' @name woe2

#' @export

woe2 = function(x, y, w = NULL,

                adjust = 0,

                min_total = 1,

                min_bads = 0,

                woe_min_range = 0,

                woe_min_level = 0,

                woe_ignore_level = NULL,

                good_over_bad = TRUE,

                na_rm = FALSE){



    # check inputs

    if(!inherits(x, c("character", "factor"))){

        warning("x is not character or factor")

        return(NULL)

    }

    w = if(is.null(w) || all_na(w)){

        rep(1, length(y))

    }else{

        w / sum(w) * length(y)

    }

    if(length(x) != length(y)){

        stop("length x not equal to length y")

    }

    if(length(w) != length(y)){

        stop("length w not equal to length y")

    }

    if(anyNA(w)){

        stop("w contains missing values")

    }



    # check classes

    # coerce y from factor to binary

    if(is.factor(y)){

        y = as.integer(y) - 1

    }



    # x %<>% pull



    # summary df

    df = data_frame(x = x, y = y, w = w) %>%

        filter(!is.na(y)) %>%

        mutate(x = x %>% as.factor)



    if(na_rm){

        df %<>% filter(!is.na(x))

    }else{

        df %<>% mutate(x = x %>% fct_explicit_na("NA"))

    }



    df %>%

        group_by(x) %>%

        summarise(

            # unweighted stats

            n_bad  = sum(y == 1),

            n_good = sum(y == 0),

            n = n_bad + n_good,

            # # weighted stats

            n_bad_w  = sum((y == 1) * w),

            n_good_w = sum((y == 0) * w)

        ) %>%

        complete(x) %>%

        ungroup() %>%

        mutate_if(colnames(.) != "x", funs(ifelse(is.na(.), 0, .))) %>%

        mutate(

            prop_bad_w  = (n_bad_w + adjust) / sum(n_bad_w),

            prop_good_w = (n_good_w + adjust) / sum(n_good_w),

            # use weighted stats to calculate woe

            woe = if(good_over_bad){

                log(prop_good_w / prop_bad_w)

            }else{

                log(prop_bad_w / prop_good_w)

            },

            # but use unweighted stats for corrected woe

            woe = if_else(n_bad < min_bads, 0, woe),

            woe = if_else(n < min_total, 0, woe),

            woe = if_else(abs(woe) < woe_min_level, 0, woe),

            woe = if(abs(diff(range(woe))) < woe_min_range) 0 else woe,

            woe = if_else(x %in% woe_ignore_level, 0, woe)

        ) %>%

        mutate_if(colnames(.) != "x", funs(ifelse(is.finite(.), ., NA))) %>%

        rename(level = x) %>%

        select(level, woe) %>%

        mutate_if(function(x) inherits(x, "factor"), as.character)

}



#####



characteristic_table_ = function(x, y, w = NULL,

                                 adjust = 0,

                                 min_total = 1,

                                 min_bads = 0,

                                 woe_min_range = 0,

                                 woe_min_level = 0,

                                 woe_ignore_level = NULL,

                                 good_over_bad = TRUE,

                                 na_rm = FALSE){



    # check inputs

    if(!inherits(x, c("character", "factor"))){

        warning("x is not character or factor")

        return(NULL)

    }

    w = if(is.null(w) || all_na(w)){

        rep(1, length(y))

    }else{

        w / sum(w) * length(y)

    }

    if(length(x) != length(y)){

        stop("length x not equal to length y")

    }

    if(length(w) != length(y)){

        stop("length w not equal to length y")

    }

    if(anyNA(w)){

        stop("w contains missing values")

    }

    # check classes

    if(!inherits(y, c("integer", "numeric")) ||

       any(!unique(na.omit(y)) %in% c(0,1))){

        stop("y is not a binary vector")

    }



    # summary df

    df = data_frame(x = x, y = y, w = w) %>%

        filter(!is.na(y)) %>%

        mutate(x = x %>% as.factor)



    if(na_rm){

        df %<>% filter(!is.na(x))

    }else{

        df %<>% mutate(x = x %>% fct_explicit_na("NA"))

    }



    df %>%

        group_by(x) %>%

        summarise(

            # unweighted stats

            n_bad  = sum(y %in% 1),

            n_good = sum(y %in% 0),

            n = n_bad + n_good,

            # weighted stats

            n_bad_w  = sum((y %in% 1) * w),

            n_good_w = sum((y %in% 0) * w),

            n_w = n_bad_w + n_good_w

        ) %>%

        complete(x) %>%

        ungroup() %>%

        mutate_if(colnames(.) != "x", funs(ifelse(is.na(.), 0, .))) %>%

        mutate(

            # unweighted stats

            N = sum(n),

            N_bad  = sum(n_bad),

            N_good = sum(n_good),

            bad_rate = n_bad / n,

            prop = n / N,

            prop_bad  = (n_bad + adjust) / N_bad,

            prop_good = (n_good + adjust) / N_good,

            # weighted stats

            N_w = sum(n_w),

            N_bad_w  = sum(n_bad_w),

            N_good_w = sum(n_good_w),

            bad_rate_w = n_bad_w / n_w,

            prop_w = n_w / N_w,

            prop_bad_w  = (n_bad_w + adjust) / N_bad_w,

            prop_good_w = (n_good_w + adjust) / N_good_w,

            # use weighted stats to calculate woe

            woe = if(good_over_bad){

                log(prop_good_w / prop_bad_w)

            }else{

                log(prop_bad_w / prop_good_w)

            },

            # but use unweighted stats for corrected woe

            woe = if_else(n_bad < min_bads, 0, woe),

            woe = if_else(n < min_total, 0, woe),

            woe = if_else(abs(woe) < woe_min_level, 0, woe),

            woe = if(abs(diff(range(woe))) < woe_min_range) 0 else woe,

            woe = if_else(x %in% woe_ignore_level, 0, woe),

            # use weighted stats and corrected woefor iv

            iv = if(good_over_bad){

                sum((prop_good_w - prop_bad_w) * woe)

            }else{

                sum((prop_bad_w - prop_good_w) * woe)

            }

        ) %>%

        mutate_if(colnames(.) != "x", funs(ifelse(is.finite(.), ., NA))) %>%

        rename(level = x) %>%

        mutate(level_order = row_number()) %>%

        select(

            level, level_order,

            N,   N_bad,   N_good,   n,   n_bad,   n_good,   prop,   prop_bad,   prop_good,   bad_rate,

            N_w, N_bad_w, N_good_w, n_w, n_bad_w, n_good_w, prop_w, prop_bad_w, prop_good_w, bad_rate_w,

            woe, iv

        ) %>%

        mutate_if(function(x) inherits(x, "factor"), as.character)



}









#' @title WOE plot

#' @description Plot a bar chart of weight-of-evidence values. This function uses

#'   \link[CImodelling]{characteristic_table} to compute the weight-of-evidence values and

#'   \link[ggplot2]{ggplot} + \link[ggplot2]{geom_bar} to make the plot.

#'

#' @param x data frame containing predictor variable(s) (numeric predictors will be ignored)

#' @param y vector of binary response values (1 = bad, 0 = good), or column name of response

#'   variable if \code{x} contains the response (if \code{NULL}, the first column of \code{x}

#'   is assumed to be the response)

#' @param values if \code{TRUE}, iv values will added as labels at the end of each bar

#' @param values_cex text size to use for values

#' @param ... additional arguments to pass to \link[CImodelling]{characteristic_table}

#'

#' @export

#' @examples

#' \dontrun{

#'

#' library(tidyverse)

#' library(CIdata)

#' n = 100

#' x = data_frame(

#'   y = sample(0:1, n, prob = c(0.8, 0.2), replace = TRUE),

#'   x1 = sample(LETTERS[1:5], n, replace = TRUE),

#'   x2 = sample(9:12, n, replace = TRUE) %>% as.character, # will be plotted alphabetically

#'   x3 = sample(9:12, n, replace = TRUE) %>% factor(9:12) # level order preserved

#' )

#' plot_woe(x)

#' }



plot_woe = function(x,

                    y = NULL,

                    values = TRUE,

                    values_cex = 3,

                    ...){



    if(is.null(y)){

        y = x[[1]] %>% as.integer

        check_is_binary(y)

        x = x %>% select(-1)

    }

    ctable = CImodelling::characteristic_table(x, y, ...)

    ctable %>%

        plot_woe_(values = values, values_cex = values_cex)



}



plot_woe_ = function(ctable,

                     values = TRUE,

                     values_cex = 3,

                     ...){



    df = ctable %>%

        select(.data$predictor,

               .data$level,

               .data$woe,

               "n" = .data$n_w,

               "nbad" = .data$n_bad_w,

               "badrate" = .data$bad_rate_w) %>%

        mutate(label = str_c(.data$nbad, .data$n, sep = " / ")) %>%

        mutate(vjust = if_else(.data$woe < 0, 1.5, -0.75))



    # hack to preserve factor level order in facet_wrap

    # adds white space around any duplicated levels

    while(any(duplicated(df$level))){

        df$level[duplicated(df$level)] %<>% str_c(" ", ., " ")

    }



    good_over_bad = ctable %>%

        drop_na(.data$bad_rate_w, .data$woe) %>% {

            cor(.$bad_rate_w, .$woe) %>% `<`(., 0)

        }



    plot_obj = df %>%

        mutate(level = .data$level %>% as.factor %>% fct_inorder) %>%

        ggplot(aes_string("level", "woe", fill = "woe")) +

        geom_bar(stat = "identity") +

        geom_hline(yintercept = 0) +

        labs(x = NULL, y = "Weight-of-evidence") +

        scale_fill_gradient2(

            high = if(good_over_bad) ci_teal else ci_red,

            low = if(good_over_bad) ci_red else ci_teal,

            mid = ci_grey

        ) +

        theme(legend.position = "none")



    # facets

    if(nlevels(df$predictor) > 1){

        plot_obj = plot_obj +

            facet_wrap(~ predictor, scales = "free_x")

    }



    if(values){

        plot_obj = plot_obj +

            geom_text(aes_string(label = "label"), vjust = df$vjust, col = grey(0.1),

                      size = values_cex)

    }



    plot_obj



}









# helper function to access httr::GET/POST/PATCH/DELETE

rest = function(url, what = c("GET", "POST", "PATCH", "DELETE"), config = NULL, ...){

    what = match.arg(what)

    FUN = eval(parse(text = str_c("httr::", what)))

    if(is.null(config)) config = httr::add_headers(

        "accept" = "application/json",

        "content-type" = "application/json"

    )

    print_progress(what, ": ", url)

    result = try(FUN(url, config = config, ...), TRUE)

    if(inherits(result, "try-error")){

        message("can't connect to model publishing API - check your VPN connection")

        return(invisible())

    }

    if(isTRUE(getOption("CIdata_versonse"))){

        if(what %in% c("POST", "PATCH", "DELETE")){

            type = if(what %in% c("POST", "PATCH")) "publication" else "deletion"

            if(httr::http_status(result)$category == "Success"){

                print_progress(type, " successful :)")

            }else{

                print_progress(type, " unsuccessful :(\n", httr::content(result))

                return(invisible())

            }

        }

    }

    result

}







.onAttach = function(libname, pkgname){

    packageStartupMessage(

        cli::boxx(

            c(

                paste('This is CIdata version', utils::packageVersion('CIdata')),

                'Type "?CIdata" for a package overview',

                'Type "browseVignettes(package = "CIdata")" for links to package vignettes'

            ),

            float = "center"

        )

    )

    options(CIdata_verbose = TRUE)

}



.onDetach = function(libpath){

    invisible(lapply(DBI::dbListConnections(DBI::dbDriver(drv = "MySQL")), DBI::dbDisconnect))

}



 out %<>%

            filter(!is.na(!!sym("quiz_id"))) %>%

            arrange(!!sym("quiz_id"),

                    !!sym("node_index"),

                    !!sym("question_index"))









#' @importFrom magrittr %>%

#' @export

magrittr::`%>%`



#' @importFrom magrittr %<>%

#' @export

magrittr::`%<>%`



#' @importFrom magrittr %$%

#' @export

magrittr::`%$%`



#' @importFrom magrittr %T>%

#' @export

magrittr::`%T>%`





gini2 = function(response, prediction, abs = TRUE, ci = FALSE, n.boot = 1000){



    if(n_distinct(na.omit(response)) == 1) return(NA)

    if(n_distinct(na.omit(prediction)) == 1) return(NA)



    df = data_frame(

        response = response,

        prediction = prediction

    ) %>%

        drop_na



    AUC = if(ci){

        pROC::ci.auc(df$response, df$prediction, boot.n = n.boot) %>% as.numeric

    }else{

        glmnet::auc(df$response, df$prediction)

    }



    gini = 2 * AUC - 1

    if(abs) return(abs(gini))

    gini



}





score_transform = function(y, pdo = 20, good = 1, atscore = 200, inverse = FALSE){

    factor = pdo / log(2)

    offset = atscore - factor * log(good)

    if(inverse){

        1 - inv_logit((y - offset) / factor)

    }else{

        offset + factor * logit(1 - y)

    }

}



logit = stats::qlogis



inv_logit = stats::plogis



theme_creditinfo = function(base_size = 12, base_family = "Century Gothic", line_size = 0.5){

    theme_bw(base_size, base_family) +

        theme(

            line = element_line(colour = ci_black, size = line_size),

            rect = element_rect(colour = ci_black, size = line_size),

            text = element_text(colour = ci_black, size = base_size),

            axis.title.x = element_text(margin = margin(t = 1, unit = "lines")),

            axis.title.y = element_text(margin = margin(r = 1, unit = "lines")),

            axis.title.y.right = element_text(margin = margin(l = 1, unit = "lines")),

            panel.border = element_rect(colour = ci_black, size = line_size),

            panel.grid.major = element_line(colour = "grey85", size = line_size),

            panel.grid.minor = element_blank(),

            plot.margin = margin(5, 5, 5, 5, unit = "pt"),

            strip.background = element_rect(colour = ci_grey, fill = ci_grey, size = line_size),

            strip.text = element_text(color = "white", face = "plain", size = base_size)

        )

}







#' @rdname plot_badrate

#' @name plot_badrate

#' @title Plot bad rates

#' @description Plot the bad rate for a binary response variable (assuming bad=1, good=0)

#' against the values of a categorical or continuous predictor variable.

#'

#' \strong{\code{plot_badrate}} is a convenience wrapper which calls \code{plot_badrate_numeric} if

#' \code{x} is numeric and \code{plot_badrate_category} otherwise (integer predictors

#' are treated as categorical - to avoid this coerce them to double using \code{as.numeric}.)

#'

#' \strong{\code{plot_badrate_category}} uses \link[ggplot2]{geom_bar} to plot weighted bad rates. The

#' width of the bars is proportional to the weighted sample fraction. Confidence intervals are

#' calculated using \link[binom]{binom.confint}.

#'

#' \strong{\code{plot_badrate_numeric}} uses \link[ggplot2]{geom_smooth} to approximate the risk

#' relationship, with \code{method = "gam"}, \code{method.args = list(family="binomial")} and

#' \code{formula = y ~ s(x, k = k)}. The \code{k} parameter controls the degrees of freedom of

#' the smooth.

#'

#' @param x vector of predictor values (can be numeric or categorical)

#' @param y vector of binary response values

#' @param ... additional arguments to pass to \code{plot_badrate_numeric} or

#'   \code{plot_badrate_category}

#' @export

#' @examples

#' \dontrun{

#'

#' library(tidyverse)

#' library(CIdata)

#'

#' df = data_frame(

#'   x = rnorm(1000),

#'   y = as.integer(runif(100) > (1 - pnorm(abs(x))))

#' ) %>%

#'   mutate(x = x + 5) %>%

#'   mutate(x_cat = x %>% cut_width(0.5)) %>%

#'   mutate(z = if_else(as.integer(x_cat) < 8, "group1", "group2"))

#' df

#'

#' df %$% plot_badrate(x_cat, y)

#' df %$% plot_badrate(x_cat, y, level = 0.5)

#' df %$% plot_badrate(x_cat, y, fill = z)

#'

#' df %$% plot_badrate(x, y)

#' df %$% plot_badrate(x, y, level = 0.99)

#' df %$% plot_badrate(x, y, k = 5)

#' df %$% plot_badrate(x, y, log = TRUE)

#' }



plot_badrate = function(x, y, ...){



    if(is.numeric(x)){

        plot_badrate_numeric(x, y, ...)

    }else{

        plot_badrate_category(x, y, ...)

    }



}





#' @rdname plot_badrate

#' @name plot_badrate_category

#' @param w vector of positive numeric weights (optional)

#' @param fill vector of id values indicating group membership (optional)

#' @param ci if \code{TRUE} then confidence intervals will be plotted

#' @param level the confidence level for the confidence intervals

#' @param na_rm if \code{TRUE} then missing values are removed prior to plotting

#' @export

plot_badrate_category = function(x,

                                 y,

                                 w = NULL,

                                 fill = NULL,

                                 ci = TRUE,

                                 level = 0.95,

                                 na_rm = TRUE,

                                 ...){



    df = data_frame(

        x = x %>% as.factor,

        y = y,

        w = if(is.null(w)) 1 else w,

        fill = if(is.null(fill)) "" else fill %>% as.factor

    )

    if(na_rm) df %<>% drop_na



    # fill variable

    fill_map = df %>%

        group_by(.data$x) %>%

        summarise(fill = unique(.data$fill))

    if(nrow(fill_map) > length(unique(df$x))){

        stop("fill must be nested within x")

    }



    # weighted badrate

    df %<>%

        group_by(.data$x) %>%

        summarise(

            n = sum(.data$w),

            nbad = sum(.data$y * .data$w)

        ) %>%

        mutate(badrate = .data$nbad / .data$n)



    mean_badrate = sum(df$nbad) / sum(df$n)



    # df %>%

    #     group_by(x) %>%

    #     summarise(

    #         n = sum(!is.na(y)),

    #         nbad = sum(y, na.rm = TRUE)

    #     ) %>%

    #     mutate(badrate = nbad / n)

    #

    # mean_badrate = mean(df$y, na.rm = TRUE)



    if(ci){

        df %<>%

            mutate(

                lower = binom.confint(.data$nbad, .data$n, level, "exact")[, "lower"],

                upper = binom.confint(.data$nbad, .data$n, level, "exact")[, "upper"]

            )

    }



    df %<>%

        mutate(breaks = mosaic_x_breaks(.data$n, gap = 5)) %>%

        left_join(fill_map, "x")



    plot_obj = df %>%

        ggplot(aes_string("breaks", "badrate", width = "n"))



    if(is.null(fill)){

        plot_obj = plot_obj +

            geom_bar(stat = "identity", fill = ci_red)

    }else{

        plot_obj = plot_obj +

            geom_bar(aes(fill = fill), stat = "identity") +

            labs(fill = substitute(fill))

    }



    if(ci){

        plot_obj = plot_obj +

            geom_point() +

            geom_errorbar(aes_string(ymin = "lower", ymax = "upper"), size = 0.35)

    }



    plot_obj +

        geom_hline(yintercept = mean_badrate, lty = 2) +

        scale_x_continuous(breaks = df$breaks, labels = df$x, expand = c(0.02, 0)) +

        labs(x = substitute(x),

             y = str_c("Bad rate (", substitute(y), ")"))



}





#' @rdname plot_badrate

#' @name plot_badrate_numeric

#' @param log if \code{TRUE} then the log of the predictor variable will be plotted

#' @param k degrees of freedom of the smooth

#' @export

plot_badrate_numeric = function(x,

                                y,

                                ci = TRUE,

                                level = 0.95,

                                k = 3,

                                log = FALSE,

                                ...){



    df = data_frame(x = x, y = y) %>% drop_na

    mean_badrate = mean(df$y, na.rm = TRUE)

    if(log) df %<>% mutate(x = log(.data$x))



    df %>% ggplot(aes_string("x", "y")) +

        geom_smooth(

            se = ci,

            method = "gam",

            formula = formula(str_c("y ~ s(x, k = ", k, ")")),

            method.args = list(family = "binomial"),

            col = ci_red,

            level = level

        ) +

        geom_hline(yintercept = mean_badrate, lty = 2) +

        labs(x = paste(if(log) "log", substitute(x)),

             y = str_c("Bad rate (", substitute(y), ")"))



}







#' @title Plot a correlation matrix

#' @description Convenience function for plotting correlation matrices using

#'   \link[ggplot2]{geom_tile}.

#' @param x correlation matrix

#' @param type region of matrix to plot

#' @param truncate maximum number of characters to use when plotting variable names

#' @param zlim limits of correlation range

#' @param col vector of colours

#' @param values if \code{TRUE}, correlation values will added to each square

#' @param values_cex text size to use for values

#' @examples

#' \dontrun{

#'

#' library(CIdata)

#'

#' # a dummy correlation matrix

#' cor = matrix(runif(100, -1, 1), 10)

#' cor[upper.tri(cor)] = t(cor)[upper.tri(t(cor))]

#' diag(cor) = 1

#'

#' # example plots

#' cor %>% plot_cormat

#' cor %>% plot_cormat(type = "upper")

#' cor %>% plot_cormat(type = "full", col = heat.colors(10))

#' }

#' @export



plot_cormat = function(x,

                       type       = c("lower", "upper", "full"),

                       truncate   = 20,

                       col        = colorRampPalette(c("blue", "white", "red"))(10),

                       zlim       = c(-1,1),

                       values     = TRUE,

                       values_cex = 3

){

    if(!(inherits(x, "matrix") && nrow(x) == ncol(x)))

        stop("expecting a square matrix")

    type = match.arg(type)

    x[!is.finite(x)] = NA

    if(type == "lower") x[upper.tri(x)] = NA

    if(type == "upper") x[lower.tri(x)] = NA

    if(type != "full")  diag(x) = NA

    if(is.null(rownames(x))) rownames(x) = str_c("V", 1:nrow(x))

    if(is.null(colnames(x))) colnames(x) = str_c("V", 1:ncol(x))

    df = x %>% cormat_to_df(truncate = truncate)

    plot_cormat_(df, zlim = zlim, values = values, values_cex = values_cex)

}



# takes precomputed dataframe of correlations as input

# assumes columns in order of x, y, cor

plot_cormat_ = function(df,

                        col        = colorRampPalette(c("blue", "white", "red"))(10),

                        zlim       = c(-1,1),

                        values     = TRUE,

                        values_cex = 3

){

    if(values){

        df %<>%

            mutate(

                values = .data$cor %>%

                    round_chr(2) %>%

                    str_pad(5, "left", "+") %>%

                    str_replace("0\\.", "\\.")

            )

    }

    plot_obj = df %>%

        filter(!is.na(cor)) %>%

        ggplot(aes_string(x = 'V2', y = 'V1')) +

        geom_tile(aes_string(fill = 'cor')) +

        coord_fixed() +

        scale_fill_gradientn(colours = col, limits = zlim) +

        theme(

            axis.text.x  = element_text(angle = 90, vjust = 0.5, hjust = 1),

            axis.title.x = element_blank(),

            axis.title.y = element_blank(),

            legend.title = element_blank()

        )

    if(values){

        plot_obj = plot_obj +

            geom_text(aes_string(label = "values"), size = values_cex)

    }

    plot_obj

}



cormat_to_df = function(cormat, truncate = 20, rows = "V1", cols = "V2"){

    cormat %>%

        # truncate row/col names

        `rownames<-`(rownames(.) %>% str_trunc(truncate, "right", ".")) %>%

        `colnames<-`(colnames(.) %>% str_trunc(truncate, "right", ".")) %>%

        # convert to long format

        as.data.frame %>%

        mutate(V1 = rownames(.)) %>%

        as_data_frame %>%

        gather("V2", "cor", -one_of("V1")) %>%

        mutate_at(c("V1", "V2"), function(x) x %>% factor %>% fct_inorder) %>%

        mutate_at("V1", fct_rev) %>%

        filter(.data$V1 != .data$V2) %>%

        # filter(!is.nan(.data$cor)) %>%

        `colnames<-`(c(rows, cols, "cor"))

}







#' @title IV plot

#' @description Plot a bar chart of information values. This function uses

#'   \link[CImodelling]{characteristic_table} to compute the IV values and \link[ggplot2]{ggplot} +

#'   \link[ggplot2]{geom_bar} to make the plot.

#'

#' @param x data frame containing predictor variable(s) (numeric predictors will be ignored)

#' @param y vector of binary response values (1 = bad, 0 = good), or column name of response

#'   variable if \code{x} contains the response (if \code{NULL}, the first column of \code{x}

#'   is assumed to be the response)

#' @param top integer specifying how many IV values to plot

#' @param width width of the bars (passed to \link[ggplot2]{geom_bar})

#' @param values if \code{TRUE}, iv values will added as labels at the end of each bar

#' @param values_cex text size to use for values

#' @param ... additional arguments to pass to \link[CImodelling]{characteristic_table}

#'

#' @export

#' @examples

#' \dontrun{

#' library(tidyverse)

#' library(CIdata)

#' n = 100

#' x = data_frame(

#'   y = sample(0:1, n, prob = c(0.8, 0.2), replace = TRUE),

#'   x1 = sample(letters[1:5], n, replace = TRUE),

#'   x2 = sample(letters[1:5], n, replace = TRUE),

#'   x3 = sample(letters[1:5], n, replace = TRUE)

#' )

#' plot_iv(x)

#' plot_iv(x, top = 2)

#' }



plot_iv = function(x, y = NULL, top = NULL, width = 0.75, values = TRUE, values_cex = 3, ...){



    if(is.null(y)){

        y = x[[1]] %>% as.integer

        check_is_binary(y)

        x = x %>% select(-1)

    }

    ctable = CImodelling::characteristic_table(x, y, ...)

    ctable %>%

        plot_iv_(top = top, width = width, values = values, values_cex = values_cex)



}



plot_iv_ = function(ctable, top = NULL, width = 0.75, values = TRUE, values_cex = 3){



    df = ctable %>%

        select(.data$predictor,

               .data$iv) %>%

        distinct



    if(!is.null(top)){

        top %<>% min(nrow(df))

        df %<>%

            arrange(desc(.data$iv)) %>%

            top_n(top)

    }



    df %<>%

        arrange(.data$iv) %>%

        mutate(predictor = .data$predictor %>%

                   as.factor %>%

                   droplevels %>%

                   fct_inorder) %>%

        mutate(iv_cat = .data$iv %>%

                   cut(breaks = c(0, 0.02, 0.1, 0.3, 0.5, Inf), inlcude.lowest = TRUE) %>%

                   # `levels<-`(c("0-0.02", "0.02-0.1", "0.1-0.3", "0.3-0.5", "0.5+")) %>%

                   fct_rev) %>%

        mutate(label = .data$iv %>% round_chr(4))



    plot_obj = df %>%

        ggplot(aes_string("predictor", "iv")) +

        geom_bar(aes_string(fill = "iv_cat"), stat = "identity", width = width) +

        coord_flip() +

        scale_fill_manual(

            values = c(ci_red, ci_orange, ci_yellow, ci_apple, ci_pelorous),

            labels = levels(df$iv_cat),

            limits = levels(df$iv_cat)

        ) +

        labs(y = "Information value", fill = NULL) +

        guides(color = FALSE) +

        theme(

            axis.title.y = element_blank(),

            axis.text.y = element_text(hjust = 0),

            panel.grid.major.y = element_blank(),

            panel.grid.minor.x = element_line(colour = ci_lightgrey)

        )



    if(values){

        plot_obj = plot_obj +

            geom_text(aes_string(label = "label"), hjust = 1, col = grey(0.1),

                      size = values_cex)

    }



    plot_obj



}









#' @rdname extract_user_agent

#' @name extract_device_type

#' @title Extract information from a \code{userAgent} field

#' @description Extract information on the device an operating system from the quiz data

#'   \code{userAgent} field.

#' @param x a character vector

#' @export

#' @examples

#' \dontrun{

#'

#' library(tidyverse)

#' library(CIdata)

#'

#' quiz = get_quiz('a80fbe01-3288-4829-9c04-a3f49afbd059')

#' quiz$data$device = quiz$data$userAgent %>% extract_device_type

#' quiz$data$os = quiz$data$userAgent %>% extract_os_type

#' quiz$data %$% plot_mosaic(device, os) + labs(title = "LendingStream_July_Quiz_Scoring")

#'

#' quiz = get_quiz('a313ab3e-9018-42e2-afc4-d9938d19f530')

#' quiz$data$device = quiz$data$userAgent %>% extract_device_type

#' quiz$data$os = quiz$data$userAgent %>% extract_os_type

#' quiz$data %$% plot_mosaic(device, os) + labs(title = "Shopdirect Very Quiz")

#' }

extract_device_type = function(x){

   x %>%

        if_else(str_detect(., "iPhone|iPad|iOS"),           "Mobile/Tablet", .) %>%

        if_else(str_detect(., "Windows Phone|Windows RT"),  "Mobile/Tablet", .) %>%

        if_else(str_detect(., "Android|BlackBerry"),        "Mobile/Tablet", .) %>%

        if_else(str_detect(., "Opera Mini"),                "Mobile/Tablet", .) %>%

        if_else(str_detect(., "Mobile"),                    "Mobile/Tablet", .) %>%

        if_else(str_detect(., "Windows"),                   "Computer", .) %>%

        if_else(str_detect(., "Macintosh|Mac OS"),          "Computer", .) %>%

        if_else(str_detect(., "Ubuntu|Fedora"),             "Computer", .) %>%

        if_else(str_detect(., "Mobile/Tablet|Computer"), ., "Unknown") %>%

        if_else(. == "", NA_character_, .) %>%

        factor(levels = c("Mobile/Tablet", "Computer", "Unknown"))

}



#' @rdname extract_user_agent

#' @name extract_os_type

#' @export

extract_os_type = function(x){

    x %>%

        if_else(str_detect(., "Windows"), "Windows", .) %>%

        if_else(str_detect(., "iPhone|iPad|iOS|Mac OS X|Macintosh"), "Apple", .) %>%

        if_else(str_detect(., "Android"), "Android", .) %>%

        if_else(str_detect(., "Windows|Apple|Android"), ., "Other") %>%

        if_else(. == "", NA_character_, .) %>%

        factor(levels = c("Apple", "Android", "Windows", "Other"))

}





# How to install CIdata from bitbucket? {- #bitbucket}



~~~~

devtools::install_bitbucket(

    repo = "creditinfouk/CIdata",

    subdir = "CIdata",

    auth_user = "myname@creditinfo.co.uk",

    password = "PASSWORD",

    ref = "master"

)

~~~~





statement = "ALTER TABLE `option` RENAME COLUMN jpeg TO media_id"

DBI::dbExecute(conn, statement)





statement = "ALTER TABLE model DROP COLUMN demog_json"

DBI::dbExecute(conn, statement)





sudo R CMD javareconf





    delete = function(quiz_ids, table){

        DBI::dbExecute(connect_analyticsdb(), "SET FOREIGN_KEY_CHECKS=0")

        statement = str_c(

            "DELETE FROM `", table, "` ",

            "WHERE quiz_id IN ('", str_c(quiz_ids, collapse = "', '"), "')"

        )

        DBI::dbExecute(connect_analyticsdb(), statement)

        DBI::dbExecute(connect_analyticsdb(), "SET FOREIGN_KEY_CHECKS=1")

    }

    insert = function(updates, table){

        quiz_ids = updates$quiz_id %>% unique

        quiz_ids %>% delete(table)

        dplyr::db_insert_into(connect_analyticsdb(), table, updates)

    }





clean_text = function(x){

    x %>%

        str_replace_all(fixed("\x92"), "'") %>%

        str_replace_all(fixed("\x85"), "...") %>%

        str_replace_all(fixed("\xa3"), "£") %>%

        str_replace_all(fixed("("), " (") %>%

        str_replace_all(fixed("  ("), " (") %>%

        str_replace_all(fixed(" )"), ")") %>%

        str_c("?") %>%

        str_replace_all("\\?\\?$", "?") %>%

        str_replace_all("\\?\\)\\?$", "?)") %>%

        str_trim

}





kable_month = internal_month %>%

    knitr::kable(

        format = "html",

        align = str_c("lll", str_c(rep("r", n_months), collapse = "")),

        escape = TRUE

    ) %>%

    kableExtra::row_spec(

        row = rows_to_highlight,

        background = "#F7D878"

    )

htmltools::tagList(

    htmltools::HTML(css),

    htmltools::HTML(kable_month)

) %>%

    view_html



# >> combined -----



internal_report = htmltools::tagList(

    htmltools::HTML(css),

    shiny::h1(report_date %>% format("%d %B %Y")),

    shiny::h1("Internal report for enabled quizzes"),

    htmltools::HTML("<br>"),

    shiny::h2(str_c("Daily volume")),

    htmltools::HTML(kable_total),

    htmltools::HTML("<br>"),

    shiny::h2(str_c("Completed attempts last ", n_days, " days")),

    htmltools::HTML(kable_day),

    htmltools::HTML("<br>"),

    shiny::h2(str_c("Completed attempts last ", n_months, " months")),

    htmltools::HTML(kable_month),

    htmltools::HTML("<br>"),

    htmltools::HTML("<br>"),

    htmltools::HTML(str_c(

        "Test attempts include any of the following:",

        "<ul>",

        "    <li>explicit test attempts - i.e. where the PUID contains the word 'test'</li>",

        "    <li>QA or demo attempts</li>",

        "    <li>attempts made prior to the live date (if no live date then all attempts are considered to be test attempts)</li>",

        "    <li>attempts with missing/invalid/duplicated PUIDs</li>",

        "</ul>",

        collapse = "\n"

    )),

    htmltools::HTML("<br>")

)

internal_report %>% view_html

