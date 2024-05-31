## code to prepare `ATOM` dataset goes here

# 1) generate ATOM
# with 15 minute candles
ATOM <- cryptoQuotes::get_quote(
  ticker   = "ATOMUSDT",
  source   = "bybit",
  futures  = FALSE,
  interval = "15m",
  from     = "2023-12-30",
  to       = "2023-12-31"
)


usethis::use_data(ATOM, overwrite = TRUE)
