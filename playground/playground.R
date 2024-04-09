# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup;
rm(list = ls()); gc(); devtools::load_all()


# fgi_ <- get_fgindex()
# lsr_ <- get_lsratio("BTCUSDT")

chart(
  # ticker =  foo(
  #   tibble::as_tibble(BTC)
  # ),
  ticker = BTC,
  main = ohlc(),
  sub = list(
    volume()
  ),
  indicator = list(
    sma(n = 10),
    ema(n = 10),
    dema(n = 10),
    wma(n = 10),
    evwma(n = 10),
    zlema(n = 10),
    vwap(n = 10),
    hma(n = 10),
    alma(n = 10),
    bollinger_bands(
      n = 20
    )
  )
)
# script end;
