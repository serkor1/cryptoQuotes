\dontrun{
  # script start;

  # available intervals
  # at kucoin futures market
  cryptoQuotes::available_intervals(
    source  = 'kucoin',
    futures = TRUE,
    type    = "ohlc"
  )

  # available intervals
  # at kraken spot market
  cryptoQuotes::available_intervals(
    source  = 'kraken',
    futures = FALSE,
    type    = "ohlc"
  )

  # script end;
}
