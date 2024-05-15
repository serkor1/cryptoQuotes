# script start;

# Charting BTC using
# OHLC-bars as main
# chart
cryptoQuotes::chart(
  ticker = BTC,
  main   = cryptoQuotes::ohlc(),
  sub    = list(
    cryptoQuotes::volume()
  )
)

# script end;
