# Example on loading
# long-short ratio
# for the last days
# on the 15 minute candle
# wrapped in try to avoid
# failure on Github

# 1) long-short ratio
# on BTCUSDT pair
BTC_LSR <- try(
  expr = cryptoQuotes::getLSRatio(
    ticker = 'BTCUSDT',
    interval = '15m',
    from = Sys.Date() - 1,
    to   = Sys.Date()
  ),
  silent = TRUE
)

# 2) BTCSDT in same period
# as the long-short ratio;
BTCUSDT <- try(
  cryptoQuotes::getQuote(
    ticker = 'BTCUSDT',
    futures = TRUE,
    interval = '15m',
    from = Sys.Date() - 1,
    to   = Sys.Date()
  )
)

if (!inherits(x = BTC_LSR, what = 'try-error') & !inherits(x = BTCUSDT, what = "try-error")) {

  # 3) head the data
  # and display contents
  head(
    BTC_LSR
  )

  # 4) plot BTCUSDT-pair
  # with long-short ratio
  cryptoQuotes::chart(
    chart = cryptoQuotes::kline(
      BTCUSDT
    ) %>% cryptoQuotes::addLSRatio(
      LSR = BTC_LSR
    )
  )

}

# end of scrtipt;
