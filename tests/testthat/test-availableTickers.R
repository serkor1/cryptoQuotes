testthat::test_that(desc = "Test that available_tickers from binance returns a non-empty vector", code = {
  # 0) skip if online;
  testthat::skip_if_offline()

  testthat::skip_on_ci()

  logicals <- c(TRUE, FALSE)

  for (lgl in logicals) {
    # 1) Load the available
    # tickers
    tickers <- available_tickers(
      source = 'binance',
      futures = lgl
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
})


testthat::test_that(desc = "Test that available_tickers from kraken returns a non-empty vector", code = {
  # 0) skip if online;
  testthat::skip_if_offline()

  testthat::skip_on_ci()

  logicals <- c(TRUE, FALSE)

  for (lgl in logicals) {
    # 1) Load the available
    # tickers
    tickers <- available_tickers(
      source = 'kraken',
      futures = lgl
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
})


testthat::test_that(desc = "Test that available_tickers from bitmart returns a non-empty vector", code = {
  # 0) skip if online;
  testthat::skip_if_offline()

  testthat::skip_on_ci()

  logicals <- c(TRUE, FALSE)

  for (lgl in logicals) {
    # 1) Load the available
    # tickers
    tickers <- available_tickers(
      source = 'bitmart',
      futures = lgl
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
})


testthat::test_that(desc = "Test that available_tickers from kucoin returns a non-empty vector", code = {
  # 0) skip if online;
  testthat::skip_if_offline()

  testthat::skip_on_ci()

  logicals <- c(TRUE, FALSE)

  for (lgl in logicals) {
    # 1) Load the available
    # tickers
    tickers <- available_tickers(
      source = 'kucoin',
      futures = lgl
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
})
