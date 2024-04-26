\dontrun{
  # script start;

  # 1) check available
  # exchanges for open interest
  cryptoQuotes::available_exchanges(
    type = 'interest'
    )

  # 2) get BTC funding rate
  # for the last 7 days
  tail(
    BTC <- cryptoQuotes::get_openinterest(
      ticker = "BTCUSDT",
      source = "binance",
      from   = Sys.Date() - 7
    )
  )

  # script end;
}

