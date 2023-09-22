# script: scr_getQuote
# date: 2023-09-22
# author: Serkan Korkmaz, serkor1@duck.com
# objective: demonstrate how to use
# the getQuote in conjunction with quantmod
# script start;

# gc
rm(list = ls()); invisible(gc())

# 1) load perpetual
# futures
perpAtom <- cryptoQuotes::getQuote(
  ticker  = 'ATOMUSDT',
  source = 'binance',
  interval = '15m',
  futures = TRUE
)

# 2) chart the series
# using chartSeries
quantmod::chartSeries(
  x = perpAtom
)

# 3) add Bollinger Bands
# to the chart
quantmod::addBBands()

# script end;
