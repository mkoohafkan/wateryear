# `wateryear`: Define and Extract Water Years from Dates

  <!-- badges: start -->
  ![CRAN Release](https://www.r-pkg.org/badges/version-last-release/wateryear)
  [![R-CMD-check](https://github.com/mkoohafkan/wateryear/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/mkoohafkan/wateryear/actions/workflows/R-CMD-check.yaml)
  <!-- badges: end -->

## Introduction

A *water year* is a hydrologic term describing a 12-month time period
over which precipitation, runoff, or flows are measured. The water year
is generally defined in such a way as to ensure that runoff and the
precipitation that generated it (e.g., rainfall or melting snow
accumulated in the previous season) are associated with the same
numeric year; in other words, the changeover from one water year to the
next is typically defined to be during hydrologically "uninteresting"
periods, i.e., periods of typically low or no precipitation. Therefore,
the water year start and end usually differs from the calendar year and
can vary regionally.

There are a variety of R packages for hydrologic analysis, and most of
them implement their own calculation of the water year. The goal of
this package is to provide a consistent set of functions for
defining the water year and associating calendar dates with water
years that current and future packages can depend on.


## Demonstration

The `wateryear` package provides a mechanism for defining the water
year for the current R session:

```r
library(wateryear)
# example: standard North America water year 
set_wateryear("10-01", "09-30", "%m-%d")
#> Water year set to: 10-01 - 09-30
```

Once the water year is set, the water year associated with a given
date can be determined via the `wateryear()` function:

```r
wateryear("2004-01-01")
#> [1] 2004

wateryear(as.Date("2007-09-01"))
#> [1] 2007

wateryear(as.POSIXct("2008-11-15 12:00:00"))
#> [1] 2009

wateryear(as.POSIXct("2009-09-30 23:59:59"))
#> [1] 2009

wateryear("2009-10-01 00:00:00")
#> [1] 2010
```

For routine use, the water year can be defined via the option
`wateryear.default` in a user's `.Rprofile`. The package will use this
option to set the water year in the `.onAttach()` call.

```r
# set this is .Rprofile
options(wateryear.default = list(start = "10-01", end = "09-30",
  fmt = "%m-%d"))
```

The package also provides convenience functions for defining a
"reference" water year. This concept is helpful for plotting or
computing summary statistics based on the month or day of the year.

```r
set_referenceyear(3001)
#> Reference year set to: 3001
```

You can then use the function `with_referenceyear()` to adjust dates
to the reference water year:

```r
with_referenceyear(as.Date(c("2011-10-15", "2012-02-13")))
#> [1] "3000-10-15" "3001-02-13"
```

For routine use, the reference year can be defined via the option
`wateryear.reference` in a user's `.Rprofile`. The package will use this
option to set the water year in the `.onAttach()` call.

```r
# set this is .Rprofile
options(wateryear.reference = 3001)
```
