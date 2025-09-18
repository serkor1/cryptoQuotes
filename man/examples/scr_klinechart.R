# script start;

# Charting BTC using
# candlesticks as main
# chart
cryptoQuotes::chart(
  ticker = BTC,
  main = cryptoQuotes::kline(),
  sub = list(
    cryptoQuotes::volume()
  )
)

# script end;
