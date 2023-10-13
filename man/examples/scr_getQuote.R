# 1) load perpetual
# futures from Binance
# with 15m intervals
perpAtom <- try(
  cryptoQuotes::getQuote(
    ticker  = 'ATOMUSDT',
    source = 'binance',
    interval = '15m',
    futures = TRUE
  )
)

# 2) chart the futures
# using the chart
# function
if (!inherits(perpAtom, 'try-error')){
  cryptoQuotes::chart(
    chart = cryptoQuotes::kline(perpAtom) %>%
      cryptoQuotes::addVolume()   %>%
        cryptoQuotes::addBBands(cols = c('Close'))
  )
}

# NOTE: Without the try
# the examples fails on
# Github Actions


# script end;
