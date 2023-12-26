# 1) Load BTC spot
# from Kucoin with 30 minute
# intervals
BTC <- try(
  cryptoQuotes::getQuote(
    ticker   = 'BTC-USDT',
    source   = 'kucoin',
    interval = '30m',
    futures  = FALSE,
    from     = Sys.Date() - 1
  )
)

# 2) chart the spot price
# using the chart
# function
if (!inherits(BTC, 'try-error')){

  cryptoQuotes::chart(
    chart = cryptoQuotes::kline(BTC) %>%
      cryptoQuotes::addVolume() %>%
      cryptoQuotes::addBBands()
  )

}

# script end;
