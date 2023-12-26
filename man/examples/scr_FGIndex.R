# script: Fear and Greed Index
# date: 2023-12-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Retrieve and Plot the
# index
# script start;

# 1) get the fear and greed index
# over time
FGI <- try(
  cryptoQuotes::getFGIndex()
)

# 2) get BTCUSDT-pair on
# daily
BTCUSDT <- try(
  cryptoQuotes::getQuote(
    ticker = 'BTCUSDT',
    interval = '1d',
    futures = FALSE
  )
)

# 3) chart the klines
# of BTCUSDT with
# the Fear and Greed Index
if (!inherits(BTCUSDT, 'try-error') & !inherits(FGI, 'try-error')) {

  cryptoQuotes::chart(
    chart = cryptoQuotes::kline(
      BTCUSDT
    ) %>% cryptoQuotes::addFGIndex(
      FGI = FGI
    ),
    slider = FALSE
  )

}

# script end;
