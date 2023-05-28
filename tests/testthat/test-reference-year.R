test_that("Set reference water year", {
  expect_message(expect_true(set_referenceyear(3001)),
    "Reference water year set to: 3001")
  expect_true(set_referenceyear(3001, verbose = FALSE))

  expect_error(set_referenceyear())
  expect_error(set_referenceyear(NULL))
  expect_error(set_referenceyear(NA))
  expect_error(set_referenceyear(""))
  expect_error(set_referenceyear("NA"))
  expect_error(set_referenceyear("foo"))
  expect_error(set_referenceyear(Inf))
  expect_true(set_referenceyear(4000, FALSE))
  expect_equal(.referenceyear$get(), 4000)
  expect_true(set_referenceyear(-4000, FALSE))
  expect_equal(.referenceyear$get(), -4000)
  expect_true(set_referenceyear(0, FALSE))
  expect_equal(.referenceyear$get(), 0)
  expect_true(set_referenceyear(50000, FALSE))
  expect_equal(.referenceyear$get(), 50000)
  expect_true(set_referenceyear(40.5, FALSE))
  expect_equal(.referenceyear$get(), 40)
  expect_true(set_referenceyear(as.Date("2001-01-01"), FALSE))
  expect_equal(.referenceyear$get(), 2001)

})

test_that("Adjust to reference water year", {
  set_wateryear("10-01", "09-30", "%m-%d", verbose = FALSE)
  set_referenceyear(3001L, verbose = FALSE)

  t1951 = seq(as.Date("1951-01-01"), as.Date("1951-12-31"), length.out = 30)
  t2004 = seq(as.Date("2004-01-01"), as.Date("2004-12-31"), length.out = 30)


  v1 = c(rep("3001", 22), rep("3000", 8))
  v2 = c(rep("3001", 22), rep("3000", 8))

  expect_identical(wateryear(with_referenceyear(t1951)), rep(3001, 30))
  expect_identical(wateryear(with_referenceyear(t2004)), rep(3001, 30))

  expect_identical(format(with_referenceyear(t1951), "%Y"), v1)
  expect_identical(format(with_referenceyear(t2004), "%Y"), v2)

  set_wateryear("01-01", "12-31", "%m-%d", verbose = FALSE)

  v3 = rep(3001, 30)
  v4 = rep(3001, 30)

  expect_identical(wateryear(with_referenceyear(t1951)), rep(3001, 30))
  expect_identical(wateryear(with_referenceyear(t2004)), rep(3001, 30))

  expect_identical(format(with_referenceyear(t1951), "%Y"),
    rep("3001", 30))
  expect_identical(format(with_referenceyear(t2004), "%Y"),
    rep("3001", 30))

})
