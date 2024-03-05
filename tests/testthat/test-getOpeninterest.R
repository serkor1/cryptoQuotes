# script: test open interest
# date: 2024-03-01
# author: Serkan Korkmaz, serkor1@duck.com
# objective: These will be skipped
# on CRAN and Github
# script start;

testthat::test_that(
  desc = "Binance returns open interest correctly",
  code = {


    # 0) skip if offline;
    testthat::skip_if_offline()

    # 0) Skip tests on
    # github and CRAN
    testthat::skip_on_ci()

    # 1) run without any errors
    testthat::expect_no_error(
      return_value <- get_openinterest(
        ticker = "BTCUSDT",
        source = "binance",
        # Use yesterdays date
        # to avoid ambiguity
        # in non-realiszed values
        from     = Sys.Date() - 7,
        to       = Sys.Date() - 1
      )
    )

    # 3) expect that the years
    # are between 2000 and current year
    year_range <- as.numeric(
      format(
        range(
          zoo::index(return_value)
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



testthat::test_that(
  desc = "Bybit returns open interest correctly",
  code = {


    # 0) skip if offline;
    testthat::skip_if_offline()

    # 0) Skip tests on
    # github and CRAN
    testthat::skip_on_ci()

    # 1) run without any errors
    testthat::expect_no_error(
      return_value <- get_openinterest(
        ticker = "BTCUSDT",
        source = "bybit",
        # Use yesterdays date
        # to avoid ambiguity
        # in non-realiszed values
        from     = Sys.Date() - 7,
        to       = Sys.Date() - 1

      )
    )

    # 3) expect that the years
    # are between 2000 and current year
    year_range <- as.numeric(
      format(
        range(
          zoo::index(return_value)
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






# script end;


