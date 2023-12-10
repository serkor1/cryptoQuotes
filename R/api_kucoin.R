# script: scr_kucoin
# date: 2023-10-03
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;

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




# baseURL;
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



# tickers;
kucoinTickers <- function(
    futures = TRUE
) {

  # 1) extract endpoint
  # based on futres
  endPoint <- base::ifelse(
    test = futures,
    yes  = '/api/v1/contracts/active',
    no   = '/api/v1/market/allTickers'
  )

  # 2) GET response
  # using baseUrl
  # and internal endpoint
  # defined here
  response <- httr::GET(
    url = baseUrl(
      source = 'kucoin',
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

  # 4) depending on wether
  # its futures or not, the
  # JSON files are returned differently
  if (futures) {
    response <- subset(
      x = response$data,
      grepl(
        pattern = 'open',
        ignore.case = TRUE,
        x = response$data$status
      )
    )$symbol
  } else {
    response <- response$data$ticker$symbol
  }



  # 5) return the
  # vector
  return(
    response
  )

}


# endpoint
kucoinEndpoint <- function(
    futures = TRUE
) {

  # 1) construct endpoint url
  endPoint <- base::ifelse(
    test = futures,
    yes   =  '/api/v1/kline/query',
    no    = '/api/v1/market/candles'

  )

  # 2) return endPoint url
  return(
    endPoint
  )
}



# parameters;
kucoinParams <- function(
    futures = TRUE,
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
      symbol      = ticker,
      granularity = constructInterval(
        source = 'kucoin',
        futures = futures,
        interval = interval
      )
    )

    # 2) add startTime and endTime
    # on the parameter list if not
    # null
    #
    # NOT: Its all UTC, in a future
    # update this should be depending on
    # choice, and user system.
    if (!is.null(from) & !is.null(to)) {

      getParams$from <- format(
        as.numeric(
          as.POSIXct(
            from,
            tz = 'UTC',
            origin = "1970-01-01"
          )
        ) * 1e3,
        scientific = FALSE
      )



      getParams$to <-  format(
        as.numeric(
          as.POSIXct(
            to,
            tz = 'UTC',
            origin = "1970-01-01"
          )
        ) * 1e3,
        scientific = FALSE
      )

    }

  } else {

    getParams <- list(
      symbol = ticker,
      type = constructInterval(
        source = 'kucoin',
        futures = futures,
        interval = interval
      )
    )

    # 2) add startTime and endTime
    # on the parameter list if not
    # null
    #
    # NOT: Its all UTC, in a future
    # update this should be depending on
    # choice, and user system.
    if (!is.null(from) & !is.null(to)) {

      getParams$startAt <- as.numeric(format(
        as.numeric(
          as.POSIXct(
            from,
            tz = 'UTC'
          )
        ),
        scientific = FALSE
      ))



      getParams$endAt <- as.numeric(format(
        as.numeric(
          as.POSIXct(
            to,
            tz = 'UTC'
          )
        ) , scientific = FALSE
      ))

    }

  }



  # 3) return parameters
  return(
    getParams
  )

}





# get prices;
kucoinQuote <- function(
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
      source = 'kucoin',
      futures = futures
    ),
    # NOTE: Cant connect
    # to Binance with this
    # httr::use_proxy(
    #   url = '141.11.158.172',
    #   port = 8080
    #   ),
    path  = endPoint(
      source = 'kucoin',
      futures = futures
    ),
    query = getParams(
      source = 'kucoin',
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


  # # 2) parse response
  response <- jsonlite::fromJSON(
    txt = httr::content(
      x = response,
      as = 'text',
      encoding = 'UTF-8'
    )
  )$data

  # 3) format response
  # accordingly

  # 3.1) set column
  # names
  if (futures) {

    column_names <- c(
      'Open',
      'High',
      'Low',
      'Close',
      'Volume'
    )

  } else {

    column_names <- c(
      'Open',
      'Close',
      'High',
      'Low',
      'Volume'
    )

  }

  # 3.2) format
  # dates
  index <- as.POSIXct(
    as.numeric(response[,1])/ifelse(futures, yes = 1e3, no = 1),
    origin = '1970-01-01',
    tz = 'UTC'
  )

  if (!futures) {

    # The spot-market
    # is returned in reverse order
    # ie. latest data comes first
    #
    # this is not compatible with zoo
    # as of October 3rd, 2023

    # 1) reverse the
    # respinse as according to the
    # index
    response <- response[order(index, decreasing = FALSE),]

    # 2) reverse the index
    # as well.
    index <- sort(index, decreasing = FALSE)

  }

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
