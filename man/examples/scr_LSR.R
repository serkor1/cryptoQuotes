# Example on loading
# long-short ratio
# for the last 5 days
# on the 15 minute candle
# wrapped in try to avoid
# failure on Github
BTC_LSR <- try(
  getLSRatio(
    ticker = 'BTCUSDT',
    interval = '15m',
    from = Sys.Date() - 5,
    to   = Sys.Date()
  )
)

# head the data;
if (!inherits(x = BTC_LSR, what = 'try-error')) {

  head(
    BTC_LSR
  )

}
