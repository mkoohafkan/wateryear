#' Fixed Day of the Year
#'
#' Return the day of the year in the range \[1, 366\]. Day 60 is skipped
#' for non-leap years.
#'
#' @inheritParams lubridate::yday
#' @return A vector of days of year (numeric vector).
#'
#' @importFrom lubridate yday leap_year
#' @keywords internal
fixed_yday = function(x) {
  doy = yday(x)
  doy + (!leap_year(x) & (doy > 59L))
}


#' Water Year
#'
#' Get the water year of a calendar date.
#'
#' @param x A vector of dates or datetimes.
#' @return A numeric vector of water years.
#'
#' @importFrom lubridate year
#' @export
wateryear = function(x) {
  is_wateryear_set()

  start = fixed_yday(.wateryear$start())
  end = fixed_yday(.wateryear$end())
  # correct water year if it crosses new year
  if (start > end) {
    year(x) + (fixed_yday(x) >= start)
  } else {
    year(x)
  }
}
