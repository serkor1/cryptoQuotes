# script: api_binance
# date: 2023-12-20
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create all necessary parameters
# for a proper API call
# script start;
# 1) URLs and Endpoint; ####
binanceUrl <- function(
    futures = TRUE
) {

  # 1) define baseURL
  # for each API
  baseUrl <- base::ifelse(
    test = futures,
    yes  = 'https://fapi.binance.com',
    no   = 'https://data-api.binance.vision'
  )

  # 2) return the
  # baseURL
  return(
    baseUrl
  )

}

binanceEndpoint <- function(
    type = 'ohlc',
    futures = TRUE,
    top = FALSE
) {

  endPoint <- switch(
    EXPR = type,
    ohlc = {
      if (futures) '/fapi/v1/klines' else '/api/v3/klines'
    },
    ticker ={
      if (futures) '/fapi/v1/exchangeInfo' else '/api/v3/exchangeInfo'
    },
    lsratio = {
      if (top) '/futures/data/topLongShortAccountRatio' else '/futures/data/globalLongShortAccountRatio'
    }
  )

  # 2) return endPoint url
  return(
    endPoint
  )

}

# 2) Available intervals; #####
binanceIntervals <- function(
    futures,
    interval,
    all = FALSE
) {
  # Define all intervals in a data frame
  allIntervals <- data.frame(
    labels = c('1s', '1m', '3m', '5m', '15m', '30m', '1h', '2h', '4h', '6h', '8h', '12h', '1d', '3d', '1w', '1M'),
    values = c('1s', '1m', '3m', '5m', '15m', '30m', '1h', '2h', '4h', '6h', '8h', '12h', '1d', '3d', '1w', '1M')
  )

  if (all) {
    return(allIntervals$labels)
  } else {
    # Select the specified interval
    selectedInterval <- allIntervals$values[
      grepl(paste0('^', interval, '$'), allIntervals$values)
    ]

    return(selectedInterval)
  }
}

# 3) define response object and format; ####
binanceResponse <- function(
    type = 'ohlc',
    futures
) {

  # mock response
  # to avoid check error in
  # unevaluated expressions
  response <- NULL

  switch(
    EXPR = type,
    ohlc = {
      list(
        colum_names = c(
          'Open',
          'High',
          'Low',
          'Close',
          'Volume'
        ),
        colum_location = c(
          2:6
        ),
        index_location = c(
          1
        )

      )
    },
    ticker = {
      list(
        code = rlang::expr(
          subset(
            x = response$symbols,
            grepl(
              pattern = 'trading',
              ignore.case = TRUE,
              x = response$symbols$status
            )
          )$symbol
        )
      )
    }
  )

}

# 4) Dates passed to and from endpoints; ####
binanceDates <- function(
    futures,
    dates,
    is_response = FALSE
) {

  multiplier <- 1e3

  if (!is_response) {
    # Convert dates to numeric and format
    dates <- convertDate(
      date = dates,
      multiplier = multiplier,
      power = 1
    )

    # Add one day to the second date
    dates[2] <- dates[2] + 1 * 60 * 60 * 24

    dates <- lapply(dates, format, scientific = FALSE)
    names(dates) <- c('startTime', 'endTime')

    return(dates)

  } else {
    # Processing response
    dates <- convertDate(
      date = as.numeric(dates),
      multiplier = multiplier,
      power = -1,
      is_response = TRUE
    )
    return(dates)
  }
}

# 5) Parameters passed to endpoints; ####
binanceParameters <- function(
    futures = TRUE,
    type   = 'ohlc',
    ticker,
    interval,
    from = NULL,
    to = NULL
) {

  # Basic parameters common to both futures and non-futures
  params <- list(
    symbol = ticker,
    interval = binanceIntervals(
      interval = interval,
      futures = futures
    )
  )

  # Add date parameters
  date_params <- binanceDates(
    futures = futures,
    dates = c(
      from = from,
      to = to
    ),
    is_response = FALSE
  )

  if (type == 'lsratio') {
    # 4.1) This is a standalone
    # parameter; was called interval
    # but is named period in the API calls
    names(params)[2] <- 'period'

    # 4.1) Return only
    # 100 such that this function
    # aligns with the remaining
    # functions which
    # also returns 100
    params$limit <- 100

  }

  # Combine all parameters
  params <- c(params, date_params)

  # Return a structured list with additional common parameters
  return(
    list(
      query = params,
      path = NULL,
      futures = futures,
      source = 'binance',
      ticker = ticker,
      interval = interval
    )
  )
}

# script end; ####
