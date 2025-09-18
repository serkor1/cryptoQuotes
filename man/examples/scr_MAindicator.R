# script start;

cryptoQuotes::chart(
  ticker = BTC,
  main = kline(),
  indicator = list(
    cryptoQuotes::ema(n = 7),
    cryptoQuotes::sma(n = 14),
    cryptoQuotes::wma(n = 21)
  )
)

# script end;
