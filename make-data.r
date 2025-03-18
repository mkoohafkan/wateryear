smithriver = dataRetrieval::readNWISdv(11532500,
                     parameterCd = "00060",
                     startDate = "2009-10-01",
                     endDate = "2022-09-30") |>
dplyr::select(date = Date, discharge = 4)

usethis::use_data(smithriver,overwrite = T)
