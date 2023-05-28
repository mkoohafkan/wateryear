#' @importFrom lubridate year
.referenceyear_store <- function() {
  .refdate <- NULL

  list(
    get = function() {
      year(.refdate)
    },
    set = function(refdate) {
      .refdate  <<- refdate
    },
    display = function() {
      format(.refdate, "%Y")
    },
    reset = function() {
      .refdate <<- NULL
    }
  )
}
.referenceyear = .referenceyear_store()


#' Set Reference Water Year
#'
#' Set the reference water year for the current session.
#'
#' @param reference_year The reference water year.
#' @param verbose If `TRUE`, produce a message echoing the reference
#'   water year setting.
#'
#' @details To set the reference year automatically when attaching the
#'   package, specify the option `wateryear.referenceyear`:
#'
#'   `options(wateryear.referenceyear = 3001)`
#'
#' @seealso [set_wateryear()] [with_referenceyear()]
#' @importFrom lubridate make_date
#' @export
set_referenceyear = function(reference_year, verbose = TRUE) {
  ref_date = suppressWarnings(make_date(reference_year))
  if (!isFALSE(is.na(ref_date))) {
    stop("Could not parse argument \"reference_year\".")
  }
  .referenceyear$set(ref_date)
  if (verbose) {
    message("Reference year set to: ", .referenceyear$display())
  }
  invisible(TRUE)
}


#' With Reference Year
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
with_referenceyear = function(x) {
  is_wateryear_set()
  is_referenceyear_set()

  year(x) = year(x) + .referenceyear$get() - wateryear(x)
  x
}


#' @keywords internal
is_referenceyear_set = function() {
  if (!isTRUE(is.finite(suppressWarnings(.referenceyear$get())))) {
    stop("Reference year is not set.", call. = FALSE)
  }
}
