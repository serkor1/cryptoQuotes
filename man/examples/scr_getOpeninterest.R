\dontrun{
  # script: Open Interest Example
  # date: 2024-03-03
  # author: Serkan Korkmaz, serkor1@duck.com
  # objective: Fetch
  # funding rate from one of the available
  # exchanges
  # script start;

  # 1) check available
  # exchanges for open interest
  available_exchanges(type = 'interest')

  # 2) get BTC funding rate
  # for the last 7 days
  tail(
    BTC <- get_openinterest(
      ticker = "BTCUSDT",
      source = "binance",
      from   = Sys.Date() - 7
    )
  )

  # script end;
}

