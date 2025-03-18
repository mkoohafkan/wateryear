#' Reference Water Year
#'
#' Get the reference water year.
#'
#' @return The reference water year (numeric).
#'
#' @importFrom lubridate year
#' @keywords internal
referenceyear = function() {
  is_wateryear_set()

  year(.wateryear$end())
}


#' To Reference Year
#'
#' Adjust dates or datetimes to the reference year. This is useful for
#'   plotting and summarizing data by day of year.
#'
#' @param x A vector of dates or datetimes.
#' @return The vector `x`, with the year overridden with the reference
#'   water year.
#'
#' @importFrom lubridate year `year<-`
#' @export
with_refyear = function(x) {
  is_wateryear_set()

  year(x) = year(x) + referenceyear() - wateryear(x)
  if (any(is.na(x))) {
    warning(sprintf("%d elements converted to NA", sum(is.na(x))))
  }
  x
}
