test_that("Water year caculation", {
  t1951 = seq(as.Date("1951-01-01"), as.Date("1951-12-31"), length.out = 30)
  t2004 = seq(as.Date("2004-01-01"), as.Date("2004-12-31"), length.out = 30)

  set_wateryear("10-01", "09-30", "%m-%d", verbose = FALSE)

  v1 = c(rep(1951, 22), rep(1952, 8))
  v2 = c(rep(2004, 22), rep(2005, 8))

  expect_identical(wateryear(t1951), v1)
  expect_identical(wateryear(t2004), v2)

  set_wateryear("01-01", "12-31", "%m-%d", verbose = FALSE)

  v3 = rep(1951, 30)
  v4 = rep(2004, 30)

  expect_identical(wateryear(t1951), v3)
  expect_identical(wateryear(t2004), v4)

  expect_identical(wateryear(as.Date("2008-02-29")), 2008)
  expect_identical(wateryear(NA), NA_real_)
  suppressWarnings(expect_warning(expect_identical(wateryear(NULL),
    numeric(0))))

  expect_identical(wateryear(as.Date("0000-01-01")), 0)

  expect_identical(wateryear(as.Date("3005-01-01")), 3005)

})
