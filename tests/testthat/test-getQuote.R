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
        interval = '1d',
        from = '2023-01-01',
        to   = '2023-01-11'
      ),
      expected = subset(
        ATOMUSDT,
        ATOMUSDT$exchange == 1 & ATOMUSDT$market == 1
      )[,1:5]
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
        interval = '1d',
        from = '2023-01-01',
        to   = '2023-01-11'
      ),
      expected = subset(
        ATOMUSDT,
        ATOMUSDT$exchange == 2 & ATOMUSDT$market == 1
      )[,1:5]
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
        interval = '1d',
        from = '2023-01-01',
        to   = '2023-01-11'
      ),
      expected = subset(
        ATOMUSDT,
        ATOMUSDT$exchange == 1 & ATOMUSDT$market == 0
      )[,1:5]
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
        interval = '1d',
        from = '2023-01-01',
        to   = '2023-01-11'
      ),
      expected = subset(
        ATOMUSDT,
        ATOMUSDT$exchange == 2 & ATOMUSDT$market == 0
      )[,1:5]
    )

  }
)
