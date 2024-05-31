\dontrun{
  # script start;

  LS_BTC <- cryptoQuotes::get_lsratio(
    ticker   = 'BTCUSDT',
    interval = '15m',
    from     = Sys.Date() - 1,
    to       = Sys.Date()
  )

  # end of scrtipt;
}

