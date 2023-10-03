# script: scr_playgground
# date: 2023-10-03
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Generate a playground
# for the functionality of the library
# script start;

# gc
rm(list = ls()); invisible(gc())

# library;
library(cryptoQuotes)



fromBinance <- getQuote(
  ticker = 'BTCUSDT',
  source = 'binance',
  futures = TRUE,
  interval = '1h'
)



fromKucoin <- cryptoQuotes::getQuote(
  ticker = 'XBTUSDTM',
  source = 'kucoin',
  futures = TRUE,
  interval = '1h'
)







# script end;
