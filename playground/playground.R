# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup;
rm(list = ls()); gc(); devtools::load_all()


# 1) SPY
# SPY <- quantmod::getSymbols(
#   "SPY",
#   auto.assign = FALSE
# )

chart(
  ticker = BTC,
  main   = kline(),
  indicator = list(
    bollinger_bands(color = "steelblue")
  ),
  sub = list(
    volume()
  )
)

# script end;

