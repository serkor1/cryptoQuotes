\dontrun{
  # script start;

  # 1) get the fear and greed index
  # for the last 14 days
  FGIndex <- cryptoQuotes::get_fgindex(
    from = Sys.Date() - 14
  )

  # 2) get the BTC price
  # for the last 14 days
  BTC <- cryptoQuotes::get_quote(
    ticker  = "BTCUSDT",
    source  = "bybit",
    futures = FALSE,
    from    = Sys.Date() - 14
  )

  # 3) chart the daily BTC
  # along side the Fear and
  # Greed Index
  cryptoQuotes::chart(
    ticker = BTC,
    main   = kline(),
    sub    = list(
      fgi(
        FGIndex
      )
    )
  )

  # script end;
}

