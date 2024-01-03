# script: api_kraken
# date: 2023-12-20
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;

# 0) Define base and endpoint
# URLs
krakenUrl <- function(
    futures = TRUE
) {

  # 1) define baseURL
  # for each API
  baseUrl <- base::ifelse(
    test = futures,
    yes  = 'https://futures.kraken.com/',
    no   = 'https://api.kraken.com/'
  )

  # 2) return the
  # baseURL
  return(
    baseUrl
  )

}

krakenEndpoint <- function(
    ohlc = TRUE,
    futures = TRUE
) {

  if (ohlc) {

    # 1) construct endpoint url
    endPoint <- base::ifelse(
      test = futures,
      yes  = 'api/charts/v1',
      no   = '0/public/OHLC'
    )

  } else {

    endPoint <- base::ifelse(
      test = futures,
      yes  = '/derivatives/api/v3/instruments',
      no   = '0/public/AssetPairs'
    )


  }

  # 2) return endPoint url
  return(
    endPoint
  )

}


# 1) Define kraken intervals
krakenIntervals <- function(interval, futures, all = FALSE) {

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
        labels =  c("1m", "5m", "15m", "30m", "1h", "4h", "12h", "1d", "1w"),
        values =  c("1m", "5m", "15m", "30m", "1h", "4h", "12h", "1d", "1w")
      )

    )


  } else {

    allIntervals <- data.frame(
      cbind(
        labels = c("1m","5m","15m", "30m", "1h","4h", "1d", "1w", "2w"),
        values = c(1   ,5   ,15   ,30    ,60   ,240 , 1440,10080,21600)
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

    # if (sum(indicator) == 0) {
    #
    #   rlang::abort(
    #     message = c(
    #       paste0(interval, ' were not found.'),
    #       'v' = paste('Valid intervals:', paste(allIntervals$labels,collapse = ', '))
    #     ),
    #     # disable traceback, on this error.
    #     trace = rlang::trace_back(),
    #     call = rlang::caller_env(n = 6)
    #   )
    #
    # }

    # 3) return interval
    interval <- allIntervals[indicator,]$values

  }

  return(
    interval
  )
}


# 3) define kraken response object
# and format
krakenResponse <- function(
    ohlc = TRUE,
    futures
) {

  # mock response
  # to avoid check error in
  # unevaluated expressions
  response <- NULL

  if (ohlc) {

    # NOTE: kraken
    # returns everything
    # from spot and futures market
    # in a similar manner

    if (futures) {

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
        colum_names = c(
          'Open',
          'High',
          'Low',
          'Close',
          'Volume'
        ),
        colum_location = c(
          2:5,7
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
            response$instruments,
            response$instruments$tradeable == 'TRUE'
          )$symbol
        )
      )

    } else {

      list(
        code = rlang::expr(
          names(
            lapply(
              response$result,
              function(x) {
                if (x$status == 'online'){
                  x$altname
                }
              }
            )
          )
        )
      )

    }

  }

}

# 4) kraken date formats
# to be sent, and recieved, from
# the API
krakenDates <- function(
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
      yes = 1,
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
    dates[[2]] <- dates[[2]]

    if (!futures) {# Spot market for kraken
      # returns since + 1 indices
      dates[[1]] <- dates[[1]] - 15*60}
    # # 2) convert all
    # # dates according
    # # to the API requirements
    dates <- lapply(
      dates,
      format,
      scientific = FALSE
    )

    if (futures) {
      names(dates) <- c(
        'from',
        'to'
      )

    } else {



      names(dates) <- c(
        'since',
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
      multiplier = base::ifelse(
        futures,
        yes = 1000,
        no  = 1
      ),
      power = -1,
      is_response = TRUE
    )

    return(
      dates
    )

  }
}


# 4) kraken parameters
krakenParameters <- function(futures = TRUE, ticker, interval, from = NULL, to = NULL) {

  # Set common parameters
  params <- list(
    ticker = ticker,
    interval = krakenIntervals(
      interval = interval,
      futures = futures
    )
  )

  # Add dates
  date_params <- krakenDates(
    futures = futures,
    dates = list(
      from = from,
      to = to
    ),
    is_response = FALSE)


  # Set specific parameters for futures or non-futures
  if (futures) {
    params$symbol = params$ticker
    params$resolution = params$interval
    params$tick_type = 'trade'
    params$from = date_params$from
    params$to = date_params$to
    params$query = list(
      from = params$from,
      to = params$to
    )
    params$path = list(
      tick_type = 'trade',
      symbol = params$symbol,
      resolution = params$resolution
    )
  } else {
    params$pair = params$ticker
    params$since = date_params$since
    params$query = list(
      since = params$since,
      pair = params$pair,
      interval = params$interval
    )
    params$path = NULL
  }

  # Common parameters for both futures and non-futures
  params$futures = futures
  params$source = 'kraken'

  # Return the structured list
  return(params)
}

#  # script end;
