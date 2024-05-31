# script start;

# Charting BTC using
# line charts with closing price
# as main chart
cryptoQuotes::chart(
  ticker = BTC,
  main   = cryptoQuotes::pline(),
  sub    = list(
    cryptoQuotes::volume()
  )
)

# script end;
