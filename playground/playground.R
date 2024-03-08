# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup
rm(list = ls()); gc(); devtools::load_all()


get_lsratio(
  ticker = "BTCUSDT",
  source = "bybit",
  interval = "1h",
  from = Sys.Date()-5
)

# script end;

