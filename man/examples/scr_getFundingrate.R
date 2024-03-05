\dontrun{
# script: Funding Rate example
# date: 2024-03-01
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Fetch
# funding rate from one of the available
# exchanges
# script start;

# 1) check available
# exchanges for funding rates
available_exchanges(type = "fundingrate")

# 2) get BTC funding rate
# for the last 7 days
tail(
  BTC <- get_fundingrate(
    ticker = "BTCUSDT",
    source = "binance",
    from   = Sys.Date() - 7
  )
)
# script end;
}
