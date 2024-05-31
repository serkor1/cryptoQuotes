\dontrun{
# script start;

# 1) check available
# exchanges for funding rates
cryptoQuotes::available_exchanges(
  type = "fundingrate"
  )

# 2) get BTC funding rate
# for the last 7 days
tail(
  BTC <- cryptoQuotes::get_fundingrate(
    ticker = "BTCUSDT",
    source = "binance",
    from   = Sys.Date() - 7
  )
)

# script end;
}
