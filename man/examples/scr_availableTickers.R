\donttest{
  ## available tickers
  ## in Binance spot market
  head(
    cryptoQuotes::availableTickers(
      source = 'binance',
      futures = FALSE
    )
  )


  ## available tickers
  ## in Kraken futures market
  head(
    cryptoQuotes::availableTickers(
      source = 'kraken',
      futures = TRUE
    )
  )
}

