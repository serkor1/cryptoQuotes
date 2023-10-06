## available tickers
## in Binance spot market
head(
  try(
    cryptoQuotes::availableTickers(
      source = 'binance',
      futures = FALSE
    )
  )
)


## available tickers
## in Kraken futures market
head(
  try(
    cryptoQuotes::availableTickers(
      source = 'kraken',
      futures = TRUE
    )
  )
)


