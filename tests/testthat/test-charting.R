testthat::test_that("Charting with klines, SMA and MACD works as intended", {
  testthat::expect_no_error(
    {
      cryptoQuotes::chart(
        chart = {
          cryptoQuotes::kline(
            quote = cryptoQuotes::ATOMUSDT

          ) %>% cryptoQuotes::addMA(
            FUN = TTR::SMA,
            n = 10
          ) %>% cryptoQuotes::addMACD()
        }
      )

    }
  )
}
)


testthat::test_that("Charting with ohlc, SMA and MACD works as intended", {
  testthat::expect_no_error(
    {
      cryptoQuotes::chart(
        chart = {
          cryptoQuotes::ohlc(
            quote = cryptoQuotes::ATOMUSDT

          ) %>% cryptoQuotes::addMA(
            FUN = TTR::SMA,
            n = 10
          ) %>% cryptoQuotes::addMACD()
        }
      )

    }
  )
}
)
