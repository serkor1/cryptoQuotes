# testing quotes;
#
# The internal test data, is the last known validated
# data before any major overhauls to the functions.
# expect no errors; ####
#
# Why wouldn't you?
testthat::test_that(
  desc = 'Test that the LSR ratio is returned as expected',
  code = {

    # 1) we skip tests on github
    # as these fails automatically
    testthat::skip_on_ci(

    )

    # 1) get quote without errors
    # and store
    testthat::expect_no_error(
      LSR <- getLSRatio(
        ticker = "BTCUSDT",
        from = Sys.Date() - 29,
        to = Sys.Date()
      )
    )

    testthat::expect_equal(
      object = nrow(LSR),
      expected = 30
    )

    # 3) expect that the years
    # are between 2000 and current year
    year_range <- as.numeric(
      format(
        range(
          zoo::index(LSR)
        ),
        format = "%Y"
      )
    )


    # 3.1) The minium year
    # has to be greater than 2000
    testthat::expect_gte(
      min(year_range),
      expected = 2000
    )

    # 3.2) The maximum
    # year has to be less than the
    # current system year.
    testthat::expect_lte(
      min(year_range),
      expected = as.numeric(
        format(Sys.Date(), '%Y'))
    )


  }
)
