# script: scr_kraken
# date: 2023-10-03
# author: Serkan Korkmaz, serkor1@duck.com
# objective: These functions
# script start;

# available intervals in kraken;
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











  return(
    interval
  )

}



# baseURL;
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




# tickers;
krakenTickers <- function(
    futures = TRUE
) {

  # 1) extract endpoint
  # based on futres
  endPoint <- base::ifelse(
    test = futures,
    yes  = '/derivatives/api/v3/instruments',
    no   = '0/public/AssetPairs'
  )

  # 2) GET response
  # using baseUrl
  # and internal endpoint
  # defined here
  response <- httr::GET(
    url = baseUrl(
      source = 'kraken',
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

  if (futures) {

    response <- response$instruments

  } else {

    response <- response$result

  }

  # 4) subset by
  # currently tradable
  # tickers and extract
  # the symbols as a character
  # vector
  if (futures) {

   response <- subset(
     response,
     response$tradeable == 'TRUE'
   )$symbol

  } else {

    response <- names(lapply(
      response,
      function(x) {
        if (x$status == 'online'){
          x$altname
        }

      }
    ))

  }



  # 5) return the
  # vector
  return(
    response
  )

}


# endpoint
krakenEndpoint <- function(
    futures = TRUE
) {

  # 1) construct endpoint url
  endPoint <- base::ifelse(
    test = futures,
    yes  = 'api/charts/v1',
    no   = '0/public/OHLC'
  )

  # 2) return endPoint url
  return(
    endPoint
  )
}



# parameters;
krakenParams <- function(
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
      tick_type = 'trade',
      symbol         = ticker,
      resolution     = constructInterval(
        source = 'kraken',
        futures = futures,
        interval = interval
      )


    )

  } else {

    getParams <- list(
      pair = ticker,
      interval = constructInterval(
        source = 'kraken',
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
  if (!is.null(from)) {

    getParams$since <- format(
      as.numeric(
        as.POSIXct(
          from,
          tz = 'UTC'
        )
      ),
      scientific = FALSE
    )



    # getParams$to <- format(
    #   as.numeric(
    #     as.POSIXct(
    #       to,
    #       tz = 'UTC'
    #     )
    #   ), scientific = FALSE
    # )

  }

  # 3) return parameters
  return(
    getParams
  )

}


# get prices;
krakenQuote <- function(
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
  if (futures) {

    # NOTE: Kraken only returns
    # the specificed dates
    if (is.null(from) & is.null(to)) {

      # Determine todays data;
      # so if nothing is provided
      # return 1 months worth
      # of data
      today <- Sys.Date()


      from <- as.numeric(as.POSIXct(seq(today, length.out=2, by="-1 months")[2], tz = 'UTC'))
      to <- as.numeric(
        as.POSIXct(
          today,
          tz = 'UTC'
          )
      )



    }

    response <- httr::GET(
      url   = baseUrl(
        source = 'kraken',
        futures = TRUE
      ),
      # NOTE: Cant connect
      # to kraken with this
      # httr::use_proxy(
      #   url = '141.11.158.172',
      #   port = 8080
      #   ),
      path  = c(endPoint(
        source = 'kraken',
        futures = TRUE
      ),
      getParams(
        source = 'kraken',
        futures = TRUE,
        ticker = ticker,
        interval = interval,
        from = NULL,
        to   = NULL
      )
      ),
      query = list(
        from = as.numeric(
          as.POSIXct(
            from,
            tz = 'UTC'
          )
        ),
        to = as.numeric(
          as.POSIXct(
            to,
            tz = 'UTC'
          )
        )
      )
    )



  } else {

    response <- httr::GET(
      url   = baseUrl(
        source = 'kraken',
        futures = FALSE
      ),
      path  = endPoint(
        source = 'kraken',
        futures = FALSE
      ),
      query = getParams(
        source = 'kraken',
        futures = FALSE,
        ticker = ticker,
        interval = interval,
        from = from,
        to   = NULL
      )
    )


  }

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

  if (futures) {

    response <- response$candles

  } else {

    response <- response$result[[1]]


  }



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
    as.numeric(response[,1])/ifelse(futures, 1000, 1),
    origin = '1970-01-01',
    tz = 'UTC'
  )


  if (futures) {

    idx <- c(2:6)

  } else {

    idx <- c(2:5, 7)

  }



  # 3.3) extract needed
  # columns from the response
  response <- response[,idx]
  colnames(response) <- column_names

  # 3.4) convert all values
  # to numeric
  response <- apply(
    response,
    c(1,2),
    as.numeric
  )

  # If in the spot market
  # then Kraken returns 720 pips
  # which may be outside of the desired
  # range.
  if (!futures) {

    if (!is.null(from) & !is.null(to)) {



      indicator <- index <= as.POSIXct(
        x = to,
        tz = 'UTC',
        origin = '1970-01-01',
      )



      index <- index[indicator]
      response <- response[indicator,]


    }

  }


  return(
    list(
      index = index,
      quote = response
    )
  )

}

# # script end;
