# 1) load perpetual
# futures

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
    perpAtom
  )
}

# NOTE: Without the try
# the examples fails on
# Github Actions


# script end;
