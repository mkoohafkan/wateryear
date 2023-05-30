test_that("Adjust to reference water year", {
  expect_warning(set_wateryear("3000-10-01", "3001-09-30",
    verbose = FALSE))

  t1951 = seq(as.Date("1951-01-01"), as.Date("1951-12-31"), length.out = 30)
  t2004 = seq(as.Date("2004-01-01"), as.Date("2004-12-31"), length.out = 30)


  v1 = c(rep("3001", 22), rep("3000", 8))
  v2 = c(rep("3001", 22), rep("3000", 8))

  expect_equal(wateryear(to_referenceyear(t1951)), rep(3001, 30))
  expect_equal(wateryear(to_referenceyear(t2004)), rep(3001, 30))

  expect_identical(format(to_referenceyear(t1951), "%Y"), v1)
  expect_identical(format(to_referenceyear(t2004), "%Y"), v2)

  expect_warning(set_wateryear("3001-01-01", "3001-12-31",
    verbose = FALSE))

  v3 = rep(3001, 30)
  v4 = rep(3001, 30)

  expect_equal(wateryear(to_referenceyear(t1951)), rep(3001, 30))
  expect_equal(wateryear(to_referenceyear(t2004)), rep(3001, 30))

  expect_identical(format(to_referenceyear(t1951), "%Y"),
    rep("3001", 30))
  expect_identical(format(to_referenceyear(t2004), "%Y"),
    rep("3001", 30))

})
