# script: test is.date-indicator
# author: Serkan Korkmaz, serkor1@duck.com
# date: 2024-05-23
# objective: This function should verify
# that passed dates can be coerced to date before
# they are passed into the remaining function logic.
#
# It is used in assert in general.
#
# script start;

testthat::test_that("Test the is.date()-function", {
  # 0) define date-object
  # as character
  date_object <- "2014-12-29"

  # 1) determine class
  # or
  testthat::expect_true(
    object = cryptoQuotes:::is.date(
      x = date_object
    )
  )

  # 2) check if date can be coerced
  # to POSITXct
  testthat::expect_true(
    object = inherits(
      x = cryptoQuotes:::coerce_date(
        date_object
      ),
      what = c(
        "POSIXct",
        "POSIXt"
      )
    )
  )
})

# script end;
