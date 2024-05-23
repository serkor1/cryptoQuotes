# script: api_binance
# date: 2023-12-20
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create all necessary parameters
# for a proper API call
# script start;
# 1) URLs and Endpoint; ####
binanceUrl <- function(
    futures = TRUE,
    ...) {

  # 1) define baseURL
  # for each API
  baseUrl <- base::ifelse(
    test = futures,
    yes  = 'https://fapi.binance.com',
    no   = 'https://data-api.binance.vision'
  )

  # 2) return the
  # baseURL
  baseUrl

}

binanceEndpoint <- function(
    type    = 'ohlc',
    futures = TRUE,
    top     = FALSE) {

  endPoint <- switch(
    EXPR = type,
    ohlc = {
      if (futures) 'fapi/v1/klines' else
        'api/v3/klines'
    },
    ticker ={
      if (futures) 'fapi/v1/exchangeInfo' else
        'api/v3/exchangeInfo'
    },
    lsratio = {
      if (top) 'futures/data/topLongShortAccountRatio' else
        'futures/data/globalLongShortAccountRatio'
    },
    interest = {
      'futures/data/openInterestHist'
    },
    fundingrate = {
      'fapi/v1/fundingRate'
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
    all = FALSE,
    type,
    ...) {

  #  0) wrap all intercals
  #  in switch
  all_intervals <- switch(
    EXPR = type,
    'ohlc' = {
      data.frame(
        labels = c(
          '1s',
          '1m',
          '3m',
          '5m',
          '15m',
          '30m',
          '1h',
          '2h',
          '4h',
          '6h',
          '8h',
          '12h',
          '1d',
          '3d',
          '1w',
          '1M'
        ),
        values = c(
          '1s',
          '1m',
          '3m',
          '5m',
          '15m',
          '30m',
          '1h',
          '2h',
          '4h',
          '6h',
          '8h',
          '12h',
          '1d',
          '3d',
          '1w',
          '1M'
        )
      )
    },

    # default return value
    data.frame(
      labels = c('5m', '15m', '30m', '1h', '2h', '4h', '6h', '12h', '1d'),
      values = c('5m', '15m', '30m', '1h', '2h', '4h', '6h', '12h', '1d')
    )
  )

  if (all) {

    return(all_intervals$labels)

  } else {

    # Select the specified interval
    selectedInterval <- all_intervals$values[
      grepl(paste0('^', interval, '$'), all_intervals$values)
    ]

    return(selectedInterval)

  }
}

# 3) define response object and format; ####
binanceResponse <- function(
    type = 'ohlc',
    futures,
    ...) {

  # mock response
  # to avoid check error in
  # unevaluated expressions
  response <- NULL

  switch(
    EXPR = type,
    ohlc = {
      list(
        colum_names = c(
          'open',
          'high',
          'low',
          'close',
          'volume'
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
        foo = function(
    response,
    futures = NULL){
          subset(
            x = response$symbols,
            grepl(
              pattern = 'trading',
              ignore.case = TRUE,
              x = response$symbols$status
            )
          )$symbol
        }
      )
    },

    fundingrate = {
      list(
        colum_names     = "funding_rate",
        index_location = c(2),
        colum_location = c(3)
      )
    },

    interest = {
      list(
        colum_names     = c("open_interest"),
        index_location = c(4),
        colum_location = c(2)
      )
    },

    lsratio = {
      list(
        colum_names     = c('long', 'short'),
        index_location = c(5),
        colum_location = c(2,4)
      )
    }
  )

}

# 4) Dates passed to and from endpoints; ####
binanceDates <- function(
    futures,
    dates,
    is_response = FALSE,
    ...) {

  # 0) Set multiplier
  multiplier <- 1e3

  # 1) determine wether
  # its a response or request
  if (is_response) {

    dates <- convert_date(
      x = as.numeric(dates),
      multiplier = multiplier)

  } else {

    dates <- convert_date(
      x = dates,
      multiplier = multiplier)

    dates <- vapply(
      dates,
      format,
      scientific = FALSE,
      FUN.VALUE = character(1)
    )

    names(dates) <- c('startTime', 'endTime')



  }

  dates

}

# 5) Parameters passed to endpoints; ####
binanceParameters <- function(
    futures = TRUE,
    type   = 'ohlc',
    ticker,
    interval,
    from = NULL,
    to = NULL,
    ...) {

  # Basic parameters common to both futures and non-futures
  params <- list(
    symbol = ticker,
    interval = binanceIntervals(
      interval = interval,
      futures = futures,
      type     = type
    ),
    limit = if (futures) 1500 else 1000
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



  if (type %in% c('lsratio', 'interest', 'fundingrate')) {
    # 4.1) This is a standalone
    # parameter; was called interval
    # but is named period in the API calls
    names(params)[2] <- 'period'

    # 4.1) Return only
    # 100 such that this function
    # aligns with the remaining
    # functions which
    # also returns 100
    params$limit <- 500

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
