# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup;
rm(list = ls()); gc(); devtools::load_all()



get_quote(
  ticker = "BTC-USDT",
  source = "huobi",
  futures = TRUE,
  interval = "1h"
)

get_quote(
  ticker = "btcusdt",
  source = "huobi",
  futures = FALSE
)

# script end;
