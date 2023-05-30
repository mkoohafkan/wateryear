.wateryear_store <- function() {
  .def <- list()

  list(
    start = function() {
      .def$start
    },
    end = function() {
      .def$end
    },
    set = function(start, end) {
      .def$start <<- start
      .def$end <<- end
    },
    display = function(what = c("wateryear", "referenceyear")) {
      switch(what,
        "wateryear" = paste(format(c(.def$start, .def$end), "%m-%d"),
          collapse = " - "),
        "referenceyear" = format(.def$end, "%Y")
      )
    },
    reset = function() {
      .def <<- list()
    }
  )
}
.wateryear <- .wateryear_store()


#' Set Water Year
#'
#' Set the water year locale for the current session.
#'
#' @param start,end The water year start and end. Can be a `Date`
#'   object or a character string.
#' @param fmt The date format of the character string. See
#'   [strptime()] for more information on format specifications.
#' @param verbose If `TRUE`, produce a message echoing the water year
#'   setting.
#'
#' @details To set the water year automatically when attaching the
#'   package, specify the option `wateryear.default`:
#'
#'   `options(wateryear.default = list(start = "10-01", end = "09-30",
#'     fmt = "%m-%d"))`
#'
#' @importFrom lubridate as_date
#' @export
set_wateryear = function(start = "0000-10-01", end = "0001-09-30",
  fmt = "%Y-%m-%d", verbose = TRUE) {
  if (!inherits(start, "Date")) {
    start = suppressWarnings(as_date(start, format = fmt))
  }
  if (!inherits(end, "Date")) {
    end = suppressWarnings(as_date(end, format = fmt))
  }
  assert_wy_spec(start, end)
  .wateryear$set(start = start, end = end)
  if (verbose) {
    message(
      "Water year set to: ", .wateryear$display("wateryear"), "\n",
      "Reference year set to: ", .wateryear$display("referenceyear")
    )
  }
  invisible(TRUE)
}


#' Assert Water Year Specification
#'
#' Assert the validity of the water year specification.
#'
#' @inheritParams set_wateryear
#'
#' @importFrom lubridate leap_year
#' @keywords internal
assert_wy_spec = function(start, end) {
  if (!isFALSE(is.na(start))) {
    stop("Could not parse argument \"start\".")
  } else if (!isFALSE(is.na(end))) {
    stop("Could not parse argument \"end\".")
  }
  if (fixed_yday(start) == fixed_yday(end)) {
    stop("Water year start and end fall on same day of year: ",
      paste(strftime(c(start, end), "%m-%d"), collapse = " - "),
      call. = FALSE)
  }
  if (end - start - leap_year(end) < 364) {
    stop("Water year start is after end: ",
      paste(strftime(c(start, end), "%Y-%m-%d"), collapse = " - "),
      call. = FALSE)
  }
  if (end - start - leap_year(end) > 364) {
    stop("Water year start and end spans more than a full year: ",
      paste(strftime(c(start, end), "%Y-%m-%d"), collapse = " - "),
      call. = FALSE)
  }
  if (!leap_year(end)) {
    warning("Reference year is not a leap year: ", format(end, "%Y"),
      call. = FALSE)
  }
}


#' @rdname assert_wy_spec
#' @keywords internal
is_wateryear_set = function() {
  if (any(is.null(c(.wateryear$start(), .wateryear$end())))) {
    stop("Water year is not set.", call. = FALSE)
  }
}
