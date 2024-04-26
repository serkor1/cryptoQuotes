\dontrun{
  # script start;

  exchange <- "bybit"
  futures  <- FALSE

  # 1) define baseurl
  base_url <- cryptoQuotes:::baseUrl(
    source  = exchange,
    futures = futures
  )

  # 2) define endpoint
  end_point <- cryptoQuotes:::endPoint(
    source  = "bybit",
    futures = futures,
    type    = "ohlc"
  )

  # 2) define actual
  # parameters based on
  # API docs
  queries <- list(
    symbol   = "BTCUSDT",
    category = "spot",
    limit    = 100,
    interval = "D"
  )

  # 3) perform GET request
  cryptoQuotes:::GET(
    url      = base_url,
    endpoint = end_point,
    query    = queries
  )

  # script end;
}
