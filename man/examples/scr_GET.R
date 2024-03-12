# script: scr_GET
# date: 2024-02-28
# author: Serkan Korkmaz, serkor1@duck.com
# objective: An example on how to use the GET-function
# mostly for internal purposes
# script start;

\dontrun{
  exchange <- "bybit"
  futures  <- FALSE

  # 1) define baseUrl
  # and endoint
  base_url <- cryptoQuotes:::baseUrl(
    source = exchange,
    futures = futures
  )

  end_point <- cryptoQuotes:::endPoint(
    source  = "bybit",
    futures = futures,
    type = "ohlc"
  )


  # 2) define parameters
  # that are passed into
  # GET
  queries <- list(
    symbol   = "BTCUSDT",
    category = "spot",
    limit    = 100,
    interval = "D"
  )


  # 3) perform GET request
  GET(
    url      = base_url,
    endpoint = end_point,
    query    = queries
  )
}

# script end;
