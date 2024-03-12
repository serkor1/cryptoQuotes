\dontrun{
  ## available tickers
  ## in Binance spot market
  head(
    cryptoQuotes::available_tickers(
      source = 'binance',
      futures = FALSE
    )
  )

  ## available tickers
  ## on Kraken futures market
  head(
    cryptoQuotes::available_tickers(
      source = 'kraken',
      futures = TRUE
    )
  )
}



