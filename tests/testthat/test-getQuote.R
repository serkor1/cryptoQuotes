# testing quotes;
#
# The internal test data, is the last known validated
# data before any major overhauls to the functions.
# expect no errors; ####
#
# Why wouldn't you?
testthat::test_that(
  desc = "getQuote returning GET requests from Binance Spot market",
  code = {

    # 1) skip tests on github
    testthat::skip_on_ci()

    testthat::expect_no_error(
      object = cryptoQuotes::getQuote(
        ticker = 'ATOMUSDT',
        source = 'binance',
        futures = FALSE,
        interval = '15m'
      )
    )
  }
)

testthat::test_that(
  desc = "getQuote returning GET requests from Binance Futures market",
  code = {

    # 1) skip tests on github
    testthat::skip_on_ci()

    testthat::expect_no_error(
      object = cryptoQuotes::getQuote(
        ticker = 'ATOMUSDT',
        source = 'binance',
        futures = TRUE,
        interval = '15m'
      )
    )

  }
)


testthat::test_that(
  desc = "getQuote returning GET requests from KuCoin Futures market",
  code = {

    # 1) skip tests on github
    testthat::skip_on_ci()

    # 2) determine test parameter
    testthat::expect_no_error(
      object = cryptoQuotes::getQuote(
        ticker = 'ATOMUSDTM',
        source = 'kucoin',
        futures = TRUE,
        interval = '15m'
      )
    )

  }
)




testthat::test_that(
  desc = "getQuote returning GET requests from KuCoin Spot market",
  code = {

    # 1) skip tests on github
    testthat::skip_on_ci()

    # 2) determine test parameter
    testthat::expect_no_error(
      object = cryptoQuotes::getQuote(
        ticker = 'ATOM-USDT',
        source = 'kucoin',
        futures = FALSE,
        interval = '15m'
      )
    )

  }
)

# expect errors; ####
# Test forced errors to check wether
# error messages are correctly displayed
testthat::test_that(
  desc = "getQuote failing GET requests from Binance Spot market",
  code = {


    testthat::expect_error(
      object = cryptoQuotes::getQuote(
        ticker = 'FAKETICKER',
        source = 'binance',
        futures = FALSE,
        interval = '15m'
      )
    )
  }
)

testthat::test_that(
  desc = "getQuote failing GET requests from Binance Futures market",
  code = {

    testthat::expect_error(
      object = cryptoQuotes::getQuote(
        ticker = 'FAKETICKER',
        source = 'binance',
        futures = TRUE,
        interval = '15m'
      )
    )

  }
)


testthat::test_that(
  desc = "getQuote failing GET requests from KuCoin Futures market",
  code = {

    # 2) determine test parameter
    testthat::expect_error(
      object = cryptoQuotes::getQuote(
        ticker = 'FAKETICKER',
        source = 'kucoin',
        futures = TRUE,
        interval = '15m'
      )
    )

  }
)




testthat::test_that(
  desc = "getQuote failing GET requests from KuCoin Spot market",
  code = {

    # 2) determine test parameter
    testthat::expect_error(
      object = cryptoQuotes::getQuote(
        ticker = 'FAKETICKER',
        source = 'kucoin',
        futures = FALSE,
        interval = '15m'
      )
    )

  }
)
