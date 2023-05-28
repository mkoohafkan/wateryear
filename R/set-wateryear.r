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
    display = function() {
      paste(format(c(.def$start, .def$end), "%m-%d"),
        collapse = " - ")
    },
    reset = function() {
      .def$start <<- NULL
      .def$end <<- NULL
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
#' @importFrom lubridate as_date
#' @export
set_wateryear = function(start = "10-01", end = "09-30", fmt = "%m-%d",
verbose = TRUE) {
  if (!inherits(start, "Date")) {
    start = suppressWarnings(as_date(start, format = fmt))
  }
  if (!inherits(end, "Date")) {
    end = suppressWarnings(as_date(end, format = fmt))
  }
  assert_wy_spec(start, end)
  .wateryear$set(start = start, end = end)
  if (verbose) {
    message("Water year set to: ", .wateryear$display())
  }
  invisible(TRUE)
}


#' Assert Water Year Specification
#'
#' Assert the validity of the water year specification.
#'
#' @inheritParams set_wateryear
#'
#' @keywords internal
assert_wy_spec = function(start, end) {
  if (!isFALSE(is.na(start))) {
    stop("Could not parse argument \"start\".")
  } else if (!isFALSE(is.na(end))) {
    stop("Could not parse argument \"end\".")
  }
  fixed_start = fixed_yday(start)
  fixed_end =  fixed_yday(end)
  if (fixed_start == fixed_end) {
    stop("Water year start and end fall on same day of year: ",
      paste(strftime(c(start, end), "%m-%d"), collapse = " - "))
  }
  if (fixed_start > fixed_end) {
    fixed_end = fixed_end + 366
  }
  if (fixed_end - fixed_start < 365) {
    stop("Water year start and end do not span full year: ",
      paste(strftime(c(start, end), "%m-%d"), collapse = " - "))
  }
}


#' @rdname assert_wy_spec
#' @keywords internal
is_wateryear_set = function() {
  if (any(is.null(c(.wateryear$start(), .wateryear$end())))) {
    stop("Water year is not set.", call. = FALSE)
  }
}
