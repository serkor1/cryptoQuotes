# script: api_bitmart
# date: 2023-12-20
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create all necessary parameters
# for a proper API call
# script start;
# 1) URLs and Endpoint; ####
bitmartUrl <- function(
    futures = TRUE
) {

  # 1) define baseURL
  # for each API
  baseUrl <- base::ifelse(
    test = futures,
    yes  = 'https://api-cloud.bitmart.com',
    no   = 'https://api-cloud.bitmart.com'
  )

  # 2) return the
  # baseURL
  return(
    baseUrl
  )

}

bitmartEndpoint <- function(
    type = 'ohlc',
    futures = TRUE
) {


  endPoint <- switch(
    EXPR = type,
    ohlc = {
      if (futures) '/contract/public/kline' else '/spot/quotation/v3/lite-klines'
    },
    ticker ={
      if (futures) '/contract/public/details' else '/spot/v1/symbols'
    }
  )


  # 2) return endPoint url
  return(
    endPoint
  )

}

# 2) Available intervals; #####
bitmartIntervals <- function(
    futures,
    interval,
    all = FALSE
) {

  # Define all intervals in a data frame
  allIntervals <- data.frame(
    labels = c('1m', '3m', '5m', '15m', '30m', '1h', '2h', '4h', '6h', '12h', '1d', '3d', '1w'),
    values = c(1, 3, 5, 15, 30, 60, 120, 240, 360, 720, 1440, 4320, 10080)
  )

  if (all) {

    return(allIntervals$labels)

  } else {
    # Locate and return the chosen interval value
    selectedInterval <- allIntervals$values[
      allIntervals$labels == interval
    ]

    return(selectedInterval)
  }
}

# 3) define response object and format; ####
bitmartResponse <- function(
    type = 'ohlc',
    futures
) {

  response <- NULL


  # mock response
  # to avoid check error in
  # unevaluated expressions
  response <- NULL

  switch(
    EXPR = type,
    ohlc = {
      list(
        colum_names = if (futures) c('Low', 'High', 'Open', 'Close', 'Volume') else c('Open', 'High', 'Low', 'Close', 'Volume'),
        colum_location = if (futures) 1:5 else c(2:5,7),
        index_location = if (futures) 6 else 1
      )
    },
    ticker = {
      list(
        code = switch (
          if (futures) 'futures' else 'spot',
          futures = rlang::expr(response$data$symbol$symbol),
          spot    = rlang::expr(response$data$symbols)
        )
      )
    }
  )


}

# 4) Dates passed to and from endpoints; ####
bitmartDates <- function(
    futures,
    dates,
    is_response = FALSE
) {
  if (!is_response) {
    # Convert dates to numeric and then format
    dates <- convertDate(
      date = dates,
      multiplier = 1,
      power = 1,
      is_response = FALSE
    )

    dates <- format(
      dates,
      scientific = FALSE
    )

    # Set names based on futures
    names(dates) <- if (futures) c('start_time', 'end_time') else c('after', 'before')

    return(dates)
  } else {
    # Processing response
    dates <- convertDate(
      date = as.numeric(dates),
      is_response = TRUE
    )
    return(dates)
  }
}

# 5) Parameters passed to endpoints; ####
bitmartParameters <- function(
    futures = TRUE,
    ticker,
    type = NULL,
    interval,
    from = NULL,
    to = NULL
) {

  # Basic parameters
  params <- list(
    symbol = ticker,
    step = bitmartIntervals(
      interval = interval,
      futures = futures
    )
  )

  # Add date parameters
  date_params <- bitmartDates(
    futures = futures,
    dates = c(
      from = from,
      to = to
    ),
    is_response = FALSE
  )

  # Combine all parameters
  params <- c(params, date_params)

  # Return a structured list with additional common parameters
  return(
    list(
      query = params,
      path = NULL,
      futures = futures,
      source = 'bitmart',
      ticker = ticker,
      interval = interval
    )
  )
}

# script end;
