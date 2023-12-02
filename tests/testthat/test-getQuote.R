# testing quotes;
#
# The internal test data, is the last known validated
# data before any major overhauls to the functions.
#
# NOTE: kuCoin futures doesnt support
# calls that are more than a month old
# so these tests may fail because of this. So the tests has to
# updated once every month, or anytime the tests
# has to be run.
#
# TODO: the tests has to be revised so its more
# robust to API call limits.
testthat::test_that(
  desc = "getQuote returns a xts object from Binance futures, corresponding to the existing one.",
  code = {

    # 1) skip tests on github
    testthat::skip_on_ci()

    # 2) determine test parameter
    testthat::expect_equal(
      object = cryptoQuotes::getQuote(
        ticker = 'ATOMUSDT',
        source = 'binance',
        futures = TRUE,
        interval = '15m',
        from     = '2023-11-25',
        to       = '2023-11-28'
      ),
      expected = cryptoQuotes:::internalTest[[1]][[2]]
    )

    }
)


testthat::test_that(
  desc = "getQuote returns a xts object from Kucoin futures, corresponding to the existing one.",
  code = {

    # 1) skip tests on github
    testthat::skip_on_ci()

    # 2) determine test parameter
    testthat::expect_equal(
      object = cryptoQuotes::getQuote(
        ticker = 'ATOMUSDTM',
        source = 'kucoin',
        futures = TRUE,
        interval = '15m',
        from     = '2023-11-25',
        to       = '2023-11-28'
      ),
      expected = cryptoQuotes:::internalTest[[2]][[2]]
    )

  }
)



testthat::test_that(
  desc = "getQuote returns a xts object from Binance spot, corresponding to the existing one.",
  code = {

    # 1) skip tests on github
    testthat::skip_on_ci()

    # 2) determine test parameter
    testthat::expect_equal(
      object = cryptoQuotes::getQuote(
        ticker = 'ATOMUSDT',
        source = 'binance',
        futures = FALSE,
        interval = '15m',
        from     = '2023-11-25',
        to       = '2023-11-28'
      ),
      expected = cryptoQuotes:::internalTest[[1]][[1]]
    )

  }
)


testthat::test_that(
  desc = "getQuote returns a xts object from Kucoin spot, corresponding to the existing one.",
  code = {

    # 1) skip tests on github
    testthat::skip_on_ci()

    # 2) determine test parameter
    testthat::expect_equal(
      object = cryptoQuotes::getQuote(
        ticker = 'ATOM-USDT',
        source = 'kucoin',
        futures = FALSE,
        interval = '15m',
        from     = '2023-11-25',
        to       = '2023-11-28'
      ),
      expected = cryptoQuotes:::internalTest[[2]][[1]]
    )

  }
)
