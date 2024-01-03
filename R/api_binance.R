# script: api_binance
# date: 2023-12-20
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;

# 0) Define base and endpoint
# URLs
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
    ohlc = TRUE,
    futures = TRUE
) {

  if (ohlc) {

    # 1) construct endpoint url
    endPoint <- base::ifelse(
      test = futures,
      yes = '/fapi/v1/klines',
      # yes  = '/fapi/v1/continuousKlines',
      no   = '/api/v3/klines'
    )

  } else {

    endPoint <- base::ifelse(
      test = futures,
      yes  = '/fapi/v1/exchangeInfo',
      no   = '/api/v3/exchangeInfo'
    )


  }

  # 2) return endPoint url
  return(
    endPoint
  )

}


# 1) Define Binance intervals
binanceIntervals <- function(futures, interval, all = FALSE) {

  # this funtion serves two purposes
  #
  # 1) listing all available
  # intervals
  #
  # 2) extracting chosen intervals
  # for the remainder of this script.
  #
  # This step is unnessary for some of
  # the REST APIs like binance, but it provides
  # a more streamlined programming structure

  allIntervals <- data.frame(
    cbind(
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
  )

  # if all; then this function
  # has been called by availableIntervals
  # and will return all available intervals

  if (all) {

    interval <- allIntervals$labels

  } else {

    # 1) locate the chosen interval
    # from the list
    indicator <- grepl(
      pattern = paste0('^', interval),
      ignore.case = FALSE,
      x = allIntervals$labels
    )

    # 2) extract the interval
    # from the list
    interval <- allIntervals[indicator,]$values
  }


  return(
    interval
  )

}


# 3) define binance response object
# and format
binanceResponse <- function(
    ohlc = TRUE,
    futures
) {

  # mock response
  # to avoid check error in
  # unevaluated expressions
  response <- NULL

  if (ohlc) {

    # NOTE: Binance
    # returns everything
    # from spot and futures market
    # in a similar manner

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

  } else {

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

}

# 4) Binance date formats
# to be sent, and recieved, from
# the API
binanceDates <- function(
    futures,
    dates,
    is_response = FALSE
) {



  # dates are supplied and its not
  # a reponse;
  if (!is_response) {

    # 1) set multiplier
    # according to spot/perpertual
    # markets
    multiplier <- ifelse(
      futures,
      yes = 1e3,
      no = 1e3
    )
    # 1) convert all
    # dates to numeric
    dates <- lapply(
      dates,
      convertDate,
      multiplier = multiplier,
      power = 1
    )

    # 1.1) add one day
    dates[[2]] <- dates[[2]] + 1*60*60*24

    # 2) convert all
    # dates according
    # to the API requirements
    dates <- lapply(
      dates,
      format,
      scientific = FALSE
    )

    names(dates) <- c(
      'startTime',
      'endTime'
    )

    return(
      dates
    )
  }

  # if its a response
  # the dates should be parsed back accordingly
  if (is_response) {

    # 1) convert back to
    # posit
    dates <- convertDate(
      date = as.numeric(dates),
      multiplier = ifelse(
        futures,
        yes = 1e3,
        no = 1e3
      ),
      power = -1,
      is_response = TRUE
    )

    return(
      dates
    )

  }
}


# 4) Binance parameters
binanceParameters <- function(futures = TRUE, ticker, interval, from = NULL, to = NULL) {
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
    dates = list(
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
      source = 'binance',
      ticker = ticker,
      interval = interval
    )
  )
}


# script end;
