\dontrun{
# script: scr_getQuote
# date: 2024-02-29
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Demonstrate the basic
# usage of the get_quote-function
# script start;


  # 1) Load BTC spot
  # from Kucoin with 30 minute
  # intervals
  BTC <- cryptoQuotes::get_quote(
    ticker   = 'BTCUSDT',
    source   = 'binance',
    interval = '30m',
    futures  = FALSE,
    from     = Sys.Date() - 1
  )

  # 2) chart the spot price
  # using the chart
  # function
  cryptoQuotes::chart(
    ticker = BTC,
    main   = cryptoQuotes::kline(),
    indicator = list(
      cryptoQuotes::volume(),
      cryptoQuotes::bollinger_bands()
    )
  )

# script end;
}
