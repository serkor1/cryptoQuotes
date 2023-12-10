# script: scr_binance
# date: 2023-10-03
# author: Serkan Korkmaz, serkor1@duck.com
# objective: These functions
# script start;

# available intervals in binance;
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

    # 2) extract the interval
    # from the list
    interval <- allIntervals[indicator,]$values
  }


  return(
    interval
  )

}






# baseURL;
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




# tickers;
binanceTickers <- function(
    futures = TRUE
) {

  # 1) extract endpoint
  # based on futres
  endPoint <- base::ifelse(
    test = futures,
    yes  = '/fapi/v1/exchangeInfo',
    no   = '/api/v3/exchangeInfo'
  )

  # 2) GET response
  # using baseUrl
  # and internal endpoint
  # defined here
  response <- httr::GET(
    url = baseUrl(
      source = 'binance',
      futures = futures
    ),
    path = endPoint
  )


  # 3) parse response
  response <- jsonlite::fromJSON(
    txt = httr::content(
      x        = response,
      as       = 'text',
      encoding = 'UTF-8'
    )
  )

  # 4) subset by
  # currently tradable
  # tickers and extract
  # the symbols as a character
  # vector
  response <- subset(
    x = response$symbols,
    grepl(
      pattern = 'trading',
      ignore.case = TRUE,
      x = response$symbols$status
    )
  )$symbol


  # 5) return the
  # vector
  return(
    response
  )

}


# endpoint
binanceEndpoint <- function(
    futures = TRUE
) {

  # 1) construct endpoint url
  endPoint <- base::ifelse(
    test = futures,
    yes  = '/fapi/v1/continuousKlines',
    no   = '/api/v3/klines'
  )

  # 2) return endPoint url
  return(
    endPoint
  )
}



# parameters;
binanceParams <- function(
    futures,
    ticker,
    interval,
    from = NULL,
    to   = NULL
) {

  # 1) construct baseparametes
  # conditional on marketEndpoint
  # ie. wether its futures, or spotmarket
  if (futures) {

    getParams <- list(
      pair         = ticker,
      contractType = 'PERPETUAL',
      interval     = constructInterval(
        source = 'binance',
        futures = futures,
        interval = interval
      )
    )

  } else {

    getParams <- list(
      symbol = ticker,
      interval = constructInterval(
        source = 'binance',
        futures = futures,
        interval = interval
      )
    )

  }

  # 2) add startTime and endTime
  # on the parameter list if not
  # null
  #
  # NOT: Its all UTC, in a future
  # update this should be depending on
  # choice, and user system.
  if (!is.null(from) & !is.null(to)) {

    getParams$startTime <- format(
      as.numeric(
        as.POSIXct(
          from,
          tz = 'UTC'
        )
      ) * 1e3,
      scientific = FALSE
    )



    getParams$endTime <- format(
      as.numeric(
        as.POSIXct(
          to,
          tz = 'UTC'
        )
      ) * 1e3, scientific = FALSE
    )

  }

  # 3) return parameters
  return(
    getParams
  )

}


# get prices;
binanceQuote <- function(
    futures,
    interval,
    ticker,
    from = NULL,
    to   = NULL
) {

  # function information
  #
  #
  # This function fetches the
  # the data

  # 1) GET request
  response <- httr::GET(
    url   = baseUrl(
      source = 'binance',
      futures = futures
    ),
    # NOTE: Cant connect
    # to Binance with this
    # httr::use_proxy(
    #   url = '141.11.158.172',
    #   port = 8080
    #   ),
    path  = endPoint(
      source = 'binance',
      futures = futures
    ),
    query = getParams(
      source = 'binance',
      futures = futures,
      ticker = ticker,
      interval = interval,
      from = from,
      to   = to
    )
  )

  # 1.1) Check for error
  check_for_errors(
    response = response
  )

  # 2) parse response
  response <- jsonlite::fromJSON(
    txt = httr::content(
      x = response,
      as = 'text',
      encoding = 'UTF-8'
    )
  )

  # 3) format response
  # accordingly

  # 3.1) set column
  # names
  column_names <- c(
    'Open',
    'High',
    'Low',
    'Close',
    'Volume'
  )

  # 3.2) format
  # dates
  index <- as.POSIXct(
    as.numeric(response[,1])/1e3,
    origin = '1970-01-01',
    tz = 'UTC'
  )

  # 3.3) extract needed
  # columns from the response
  response <- response[,2:6]
  colnames(response) <- column_names

  # 3.4) convert all values
  # to numeric
  response <- apply(
    response,
    c(1,2),
    as.numeric
  )

  return(
    list(
      index = index,
      quote = response
    )
  )

}



# script end;

