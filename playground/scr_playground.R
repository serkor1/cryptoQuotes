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
  futures = FALSE,
  interval = '1h'
)



fromKucoin <- cryptoQuotes::getQuote(
  ticker = 'XBTUSDTM',
  source = 'kucoin',
  futures = TRUE,
  interval = '1h'
)



response <- cryptoQuotes:::getQuote(
  source = 'kucoin',
  ticker = 'BTC-USDT',
  futures = FALSE,
  interval = '1h'
)
#
#
# test <- cryptoQuotes:::kucoinQuote(
#   ticker = 'BTC-USDT',
#   futures = FALSE,
#   interval = '1h'
# )
#
#
# rev(test$quote)
#
#
# quote <- zoo::as.zoo(
#   test$quote[order(test$index, decreasing = FALSE),]
# )
#
#
# # 2) generate index
# # of the quote
# zoo::index(quote) <- sort(test$index, decreasing = FALSE)
#
# # 3) convert to xts
# # object
# quote <- xts::as.xts(
#   quote
# )
#
# # script end;
#
# 10/ifelse(
#   TRUE,
#   yes = 2,
#   no  = 1
# )
# 2023-10-03 14:00:00 27003.8 26895.8 27045.5 26887.8 147.733300
