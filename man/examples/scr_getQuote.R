\dontrun{
  # script start;

  # get quote on
  # BTCUSDT pair from
  # Binance in 30m
  # intervals from the
  # last 24 hours
  tail(
    BTC <- cryptoQuotes::get_quote(
      ticker   = 'BTCUSDT',
      source   = 'binance',
      interval = '30m',
      futures  = FALSE,
      from     = Sys.Date() - 1
    )
  )

  # script end;
}
