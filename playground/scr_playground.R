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


dailyAtomBinanceSpot <- getQuote(
  ticker = 'ATOMUSDT',
  source = 'binance',
  futures = FALSE,
  interval = '1d',
  from = '2023-01-01',
  to   = '2023-01-07'
)

dailyAtomBinanceSpot$market <- 1


dailyAtomBinanceFutures <- getQuote(
  ticker = 'ATOMUSDT',
  source = 'binance',
  futures = TRUE,
  interval = '1d',
  from = '2023-01-01',
  to   = '2023-01-07'
)

dailyAtomBinanceFutures$market <- 0



DT <- rbind(
  dailyAtomBinanceFutures,
  dailyAtomBinanceSpot
)

DT$exchange <- 1


dailyAtomKucoinFutures <- cryptoQuotes::getQuote(
  ticker = 'ATOMUSDTM',
  source = 'kucoin',
  futures = TRUE,
  interval = '1d',
  from = '2023-01-01',
  to   = '2023-01-07'
)

dailyAtomKucoinFutures$market <- 0


dailyAtomKucoinSpot <- cryptoQuotes:::getQuote(
  source = 'kucoin',
  ticker = 'ATOM-USDT',
  futures = FALSE,
  interval = '1d',
  from = '2023-01-01',
  to   = '2023-01-07'
)

dailyAtomKucoinSpot$market <- 1


DT_ <- rbind(
  dailyAtomKucoinFutures,
  dailyAtomKucoinSpot
)


DT_$exchange <- 2



ATOMUSDT <- rbind(
  DT_,
  DT
)


usethis::use_data(
  ATOMUSDT,
  overwrite = TRUE
)

