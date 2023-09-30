# script: scr_getQuote
# date: 2023-09-22
# author: Serkan Korkmaz, serkor1@duck.com
# objective: demonstrate how to use
# the getQuote
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

# 2) head data;
head(perpAtom)


# script end;
