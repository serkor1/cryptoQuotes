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

  if (futures) {

    allIntervals <- data.frame(
      cbind(
        labels = c(
          '1m',
          '5m',
          '15m',
          '30m',
          '1h',
          '2h',
          '4h',
          '8h',
          '12h',
          '1d',
          '1w'
        ),
        values = c(
          1,
          5,
          15,
          30,
          60,
          120,
          240,
          480,
          720,
          1440,
          10080
        )
      )

    )


  } else {

    allIntervals <- data.frame(
      cbind(
        labels = c(
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
          '1w'
        ),
        values = c(
          '1min',
          '3min',
          '5min',
          '15min',
          '30min',
          '1hour',
          '2hour',
          '4hour',
          '6hour',
          '8hour',
          '12hour',
          '1day',
          '1week'
        )
      )

    )

  }

  # if all; then this function
  # has been called by availableIntervals
  # and will return all available intervals
  if (all) {

    interval <- allIntervals$labels

  } else {

    # 2) locate the interval
    # using grepl
    indicator <- grepl(
      pattern = paste0('^', interval),
      ignore.case = TRUE,
      x = allIntervals$labels
    )

    # 3) return interval
    interval <- allIntervals[indicator,]$values

  }

  return(
    interval
  )

}

# 2) kucoin response
# object and format;
kucoinResponse <- function(
    ohlc = TRUE,
    futures
) {

  # mock response
  # to avoid check error in
  # unevaluated expressions
  response <- NULL

  if (ohlc) {

    if (futures) {

      list(
        colum_names =  c(
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
        colum_names = c(
          'Open',
          'Close',
          'High',
          'Low',
          'Volume'
        ),
        colum_location = c(
          2:6
        ),
        index_location = c(
          1
        )
      )

    }

  } else {






    if (futures) {

      list(
        code = rlang::expr(
          subset(
            x = response$data,
            grepl(
              pattern = 'open',
              ignore.case = TRUE,
              x = response$data$status
            )
          )$symbol
        )
      )

    } else {

      list(
        code = rlang::expr(
          response$data$ticker$symbol
        )
      )

    }



















  }


}

# 3) Kucoin date formats
# to be sent to the API
kucoinDates <- function(
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
      no = 1
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

    if (!futures) {

      dates <- lapply(
        dates,
        as.numeric
      )

      names(dates) <- c(
        'startAt',
        'endAt'
      )

    } else {

      names(dates) <- c(
        'from',
        'to'
      )

    }

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
        no = 1
      ),
      power = -1,
      is_response = TRUE
    )

    return(
      dates
    )

  }

}

# 4) kucoin parameters
# to be passed to the relevant functions
kucoinParameters <- function(
    futures = TRUE,
    ticker,
    interval,
    from = NULL,
    to   = NULL
) {

  # Some parts are
  # paths and some are
  # queries
  getParams <- list(
    ticker   = ticker,
    interval = kucoinIntervals(
      interval = interval,
      futures  = futures
    )
  )

  # 3) correct parameter names
  # according to each api
  if (futures) {
    # 1) correct all the names
    # of the elements
    names(getParams) <- c(
      'symbol',
      'granularity'
    )

  } else {
    # 1) correct all the names
    # of the elements
    names(getParams) <- c(
      'symbol',
      'type'
    )
  }

  getParams <- c(
    getParams,
    kucoinDates(
      futures = futures,
      dates   = list(
        from = from,
        to   = to
      )
    )
  )

  return(
    list(
      query    = getParams,
      path     = NULL,
      futures  = futures,
      source   = 'kucoin',
      ticker   = ticker,
      interval = interval
    )

  )

}


# script end;
