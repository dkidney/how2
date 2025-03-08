
## packages

### importing packages
```r
usethis::use_package('dplyr')
usethis::use_package('tidyverse', type = "Suggests")
```

### importing functions
```r
usethis::use_import_from('magrittr', '%>%')
usethis::use_import_from('magrittr', '%<>%')
```

### versioning
```r
usethis::use_version() # interactive
usethis::use_version("minor")
usethis::use_dev_version()
```

### testing
```r
usethis::use_testthat(
usethis::use_test('asdf')
```

