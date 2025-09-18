# script start;

# 1) available exchanges
# on ohlc-v endpoint
cryptoQuotes::available_exchanges(
  type = "ohlc"
)

# 2) available exchanges
# on long-short ratios
cryptoQuotes::available_exchanges(
  type = "lsratio"
)

# script end;
