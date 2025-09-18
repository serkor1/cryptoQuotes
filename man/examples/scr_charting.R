# script start;

# 1) charting weekly
# BTC using candlesticks
# and indicators
cryptoQuotes::chart(
  ticker = BTC,
  main = cryptoQuotes::kline(),
  sub = list(
    cryptoQuotes::volume(),
    cryptoQuotes::macd()
  ),
  indicator = list(
    cryptoQuotes::bollinger_bands(),
    cryptoQuotes::sma(),
    cryptoQuotes::alma()
  ),
  options = list(
    dark = TRUE,
    deficiency = FALSE
  )
)

# script end;
