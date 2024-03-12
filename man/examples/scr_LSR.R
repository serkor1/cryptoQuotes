\dontrun{
  # Example on loading
  # long-short ratio
  # for the last days
  # on the 15 minute candle
  # wrapped in try to avoid
  # failure on Github

  # 1) long-short ratio
  # on BTCUSDT pair
  ls_ratio <- cryptoQuotes::get_lsratio(
    ticker = 'BTCUSDT',
    interval = '15m',
    from = Sys.Date() - 1,
    to   = Sys.Date()
  )

  # 2) BTCSDT in same period
  # as the long-short ratio;
  BTC <- cryptoQuotes::get_quote(
    ticker = 'BTCUSDT',
    futures = TRUE,
    interval = '15m',
    from = Sys.Date() - 1,
    to   = Sys.Date()
  )

  # 3) plot BTCUSDT-pair
  # with long-short ratio
  cryptoQuotes::chart(
    ticker = BTC,
    main   = cryptoQuotes::kline(),
    sub    = list(
      cryptoQuotes::lsr(ratio = ls_ratio),
      cryptoQuotes::volume()
    ),
    indicator = list(
      cryptoQuotes::bollinger_bands()
    )
  )
}



# end of scrtipt;
