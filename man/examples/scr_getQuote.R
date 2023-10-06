\donttest{
  # 1) load perpetual
  # futures

  perpAtom <- cryptoQuotes::getQuote(
    ticker  = 'ATOMUSDT',
    source = 'binance',
    interval = '15m',
    futures = TRUE
  )

  # 2) chart the futures
  cryptoQuotes::chart(
    perpAtom
  )

}



# script end;
