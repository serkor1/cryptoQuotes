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

    # 0) skip if online;
    testthat::skip_if_offline()

    # 1) we skip tests on github
    # as these fails automatically
    testthat::skip_on_ci()


    # set dates
    from <- Sys.Date() - 29
    to   <- Sys.Date()


    # 1) get quote without errors
    # and store
    testthat::expect_no_error(
      LSR <- get_lsratio(
        ticker = "BTCUSDT",
        interval = "1d",
        from = from,
        to = to
      )
    )

    testthat::expect_equal(
      object = nrow(LSR),
      tolerance = 0,
      expected = min(
        29,length(
        seq(
          from = from,
          to   = to,
          by   = "1 day"
        )
      ))
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
