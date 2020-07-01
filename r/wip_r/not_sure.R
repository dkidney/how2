available.packages() %>%
  dplyr::as_data_frame() %>%
  tidyr::separate_rows(Imports, sep = ",[[:space:]]*") %>%
  # we really just
  tidyr::separate_rows(Depends, sep = ",[[:space:]]*") %>%
  # need these two
  tidyr::separate_rows(Suggests, sep = ",[[:space:]]*") %>%
  tidyr::separate_rows(Enhances, sep = ",[[:space:]]*") %>%
  dplyr::select(Package, Imports, Depends) %>%
  filter(grepl("rJava", Imports) | grepl("rJava", "Depends") | grepl("Suggests", Imports) | grepl("Enhances", "Depends")) %>%
  dplyr::distinct(Package) %>%
  dplyr::summarise(total_pkgs_using_rjava = n())
