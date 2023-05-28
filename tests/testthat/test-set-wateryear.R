test_that("set water year", {
  expect_message(expect_true(set_wateryear()),
    "Water year set to: 10-01 - 09-30")
  expect_true(set_wateryear(verbose = FALSE))

  expect_error(set_wateryear(start = "2021-05-01"))
  expect_error(set_wateryear(end = "2021-04-30"))
  expect_error(set_wateryear("foo", "bar"))
  expect_error(set_wateryear("2021-04-31", "2021-04-30"))
  expect_error(set_wateryear(NA, "2021-04-30"))
  expect_error(set_wateryear(NULL, "2021-04-30"))
  expect_error(set_wateryear("10-01", "10-01"))
  expect_error(set_wateryear("10-01", "09-29"))

  s1 = as.Date("2001-01-01")
  e1 = as.Date("2000-12-31")
  set_wateryear(s1, e1, verbose = FALSE)
  expect_identical(.wateryear$start(), s1)
  expect_identical(.wateryear$end(), e1)

  s2 = as.Date("2001-01-01")
  e2 = as.Date("2001-12-31")
  set_wateryear(s2, e2, verbose = FALSE)
  expect_identical(.wateryear$start(), s2)
  expect_identical(.wateryear$end(), e2)

  .wateryear$reset()
  expect_identical(.wateryear$start(), NULL)
  expect_identical(.wateryear$end(), NULL)

})
