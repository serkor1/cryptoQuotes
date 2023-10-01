testthat::test_that(
  desc = "getQuote returns a xts, or zoo, object.",
  code = {

    testthat::skip_on_ci()

    testthat::expect_s3_class(
      object = cryptoQuotes::getQuote(
        ticker = 'ATOMUSDT',
        interval = '15m'
      ),
      class = 'xts'
      )

    }
)
