## code to prepare `BTC` dataset goes here

# 1) generate BTC
# with weekly candles
BTC <- cryptoQuotes::get_quote(
  ticker   = "BTCUSDT",
  source   = "bybit",
  futures  = FALSE,
  interval = "1w",
  from     = "2023-01-01",
  to       = "2023-12-31"
)

# 2) store data
# locally
usethis::use_data(
  BTC,
  overwrite = TRUE
  )

