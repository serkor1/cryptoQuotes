# script: new_api_kucoin
# date: 2023-12-18
# author: Serkan Korkmaz, serkor1@duck.com
# objective: This api is
# for the httr2 for kucoin
# to test
# script start;

# 0) kucoin baseurls and endpoints
# endpoint
kucoinUrl <- function(
    futures = TRUE
) {

  # 1) define baseURL
  # for each API
  baseUrl <- base::ifelse(
    test = futures,
    yes  = 'https://api-futures.kucoin.com',
    no   = 'https://api.kucoin.com'
  )

  # 2) return the
  # baseURL
  return(
    baseUrl
  )

}

kucoinEndpoint <- function(
    ohlc = TRUE,
    futures = TRUE
) {

  if (ohlc) {

    # 1) construct endpoint url
    endPoint <- base::ifelse(
      test = futures,
      yes   =  '/api/v1/kline/query',
      no    = '/api/v1/market/candles'
    )

  } else {

    endPoint <- base::ifelse(
      test = futures,
      yes  = '/api/v1/contracts/active',
      no   = '/api/v1/market/allTickers'
    )


  }



  # 2) return endPoint url
  return(
    endPoint
  )
}


# 1) kucoin available intervals
# available intervals in binance;
kucoinIntervals <- function(interval, futures, all = FALSE) {
  if (futures) {
    allIntervals <- data.frame(
      labels = c('1m', '5m', '15m', '30m', '1h', '2h', '4h', '8h', '12h', '1d', '1w'),
      values = c(1, 5, 15, 30, 60, 120, 240, 480, 720, 1440, 10080)
    )
  } else {
    allIntervals <- data.frame(
      labels = c('1m', '3m', '5m', '15m', '30m', '1h', '2h', '4h', '6h', '8h', '12h', '1d', '1w'),
      values = c('1min', '3min', '5min', '15min', '30min', '1hour', '2hour', '4hour', '6hour', '8hour', '12hour', '1day', '1week')
    )
  }

  if (all) {
    return(allIntervals$labels)
  } else {
    # Select the specified interval
    selectedInterval <- allIntervals$values[grepl(paste0('^', interval, '$'), allIntervals$labels, ignore.case = TRUE)]
    return(selectedInterval)
  }
}


# 2) kucoin response
# object and format;
kucoinResponse <- function(ohlc = TRUE, futures) {

  response <- NULL

  if (ohlc) {
    # Common structure for OHLC data
    ohlc_structure <- list(
      colum_names = c('Open', 'High', 'Low', 'Close', 'Volume'),
      colum_location = 2:6,
      index_location = 1
    )

    return(ohlc_structure)
  } else {
    # Non-OHLC data
    non_ohlc_structure <- if (futures) {
      list(
        code = rlang::expr(
          subset(
            x = response$data,
            grepl(pattern = 'open', ignore.case = TRUE, x = response$data$status)
          )$symbol
        )
      )
    } else {
      list(
        code = rlang::expr(response$data$ticker$symbol)
      )
    }

    return(non_ohlc_structure)
  }
}


# 3) Kucoin date formats
# to be sent to the API
kucoinDates <- function(futures, dates, is_response = FALSE) {
  multiplier <- if (futures) 1e3 else 1

  if (!is_response) {
    # Convert dates and format

    dates <- convertDate(
      date = dates,
      multiplier = multiplier,
      power = 1,
      is_response = FALSE
    )

    dates <- format(
      dates,
      scientific = FALSE
    )


    if (!futures) {
      # Adjust for Kucoin spot and set names
      dates <- as.numeric(dates)
      dates[2] <- dates[2] + 15 * 60
      names(dates) <- c('startAt', 'endAt')
    } else {
      # Set names for futures
      names(dates) <- c('from', 'to')
    }

    return(dates)
  } else {
    # Processing response
    dates <- convertDate(
      date = as.numeric(dates),
      multiplier = multiplier,
      power = -1,
      is_response = TRUE)
    return(dates)
  }
}


# 4) kucoin parameters
# to be passed to the relevant functions
kucoinParameters <- function(
    futures = TRUE,
    ticker,
    interval,
    from = NULL,
    to = NULL
    ) {

  # Initial parameter setup
  params <- list(
    symbol = ticker,
    interval = kucoinIntervals(
      interval = interval,
      futures = futures
      )
  )
  # Assign appropriate names based on the futures flag
  interval_param_name <- if (futures) 'granularity' else 'type'
  names(params)[2] <- interval_param_name

  # Add date parameters
  date_params <- kucoinDates(futures = futures, dates = c(from = from, to = to))

  # Combine all parameters
  params <- c(params, date_params)

  # Return structured list with additional parameters
  return(
    list(
      query = params,
      path = NULL,
      futures = futures,
      source = 'kucoin',
      ticker = ticker,
      interval = interval
    )
  )
}

# script end;
