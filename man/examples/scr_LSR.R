# Example on loading
# long-short ratio
# for the last days
# on the 15 minute candle
# wrapped in try to avoid
# failure on Github
BTC_LSR <- try(
  cryptoQuotes::getLSRatio(
    ticker = 'BTCUSDT',
    interval = '15m',
    from = Sys.Date() - 1,
    to   = Sys.Date()
  )
)


BTCUSDT <- try(
  cryptoQuotes::getQuote(
    ticker = 'BTCUSDT',
    futures = TRUE,
    interval = '15m',
    from = Sys.Date() - 1,
    to   = Sys.Date()
  )
)


# plot and head the data
if (!inherits(x = BTC_LSR, what = 'try-error')) {

  head(
    BTC_LSR
  )

  cryptoQuotes::chart(
    chart = cryptoQuotes::kline(
      BTCUSDT
    ) %>% cryptoQuotes::addLSRatio(
      LSR = BTC_LSR
    )
  )

}
