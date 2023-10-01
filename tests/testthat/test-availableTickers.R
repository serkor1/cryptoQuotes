testthat::test_that(
  desc = "availablePairs returns a vector of characters, with lenght > 1",
  code = {


    testthat::skip_on_ci()


    # 1) Load the available
    # tickers
    tickers <- cryptoQuotes::availableTickers(
      source = 'binance',
      futures = TRUE
    )

    # 2) Check wether its
    # a character vector
    testthat::expect_type(
      object = tickers,
      type = 'character'
    )

    # Check that the vector
    # is greater than one
    testthat::expect_gt(
      object = length(tickers),
      expected = 1

    )

  }
)
