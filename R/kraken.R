# script: scr_kraken
# date: 2023-10-03
# author: Serkan Korkmaz, serkor1@duck.com
# objective: These functions
# script start;

# available intervals in kraken;
krakenIntervals <- function(interval, futures) {

  if (futures) {



    keys <- c("1m", "5m", "15m", "30m", "1h", "4h", "12h", "1d", "1w")

    indicator <- grepl(
      pattern = interval,
      x = keys
    )

    interval <- keys[indicator]
  } else {


    keys <- data.frame(
      minute = c(1,5,15,30,60,240,1440,10080,21600),
      label  = c("1m","5m","15m", "30m", "1h","4h", "1d", "1w", "2w")
    )

    indicator <- grepl(
      pattern = interval,
      x = keys$label
    )


    interval <- keys[indicator,]$minute


  }




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
  if (!is.null(from) & !is.null(to)) {

    getParams$from <- format(
      as.numeric(
        as.POSIXct(
          from,
          tz = 'UTC'
        )
      ),
      scientific = FALSE
    )



    getParams$to <- format(
      as.numeric(
        as.POSIXct(
          to,
          tz = 'UTC'
        )
      ), scientific = FALSE
    )

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
        from = from,
        to = to
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
        to   = to
      )
    )


  }


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
# script: scr_kraken
# date: 2023-10-03
# author: Serkan Korkmaz, serkor1@duck.com
# objective: These functions
# script start;

# available intervals in kraken;
krakenIntervals <- function(interval, futures) {

  if (futures) {



    keys <- c("1m", "5m", "15m", "30m", "1h", "4h", "12h", "1d", "1w")

    indicator <- grepl(
      pattern = interval,
      x = keys
    )

    interval <- keys[indicator]
  } else {


    keys <- data.frame(
      minute = c(1,5,15,30,60,240,1440,10080,21600),
      label  = c("1m","5m","15m", "30m", "1h","4h", "1d", "1w", "2w")
    )

    indicator <- grepl(
      pattern = interval,
      x = keys$label
    )


    interval <- keys[indicator,]$minute


  }




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
  if (!is.null(from) & !is.null(to)) {

    getParams$from <- format(
      as.numeric(
        as.POSIXct(
          from,
          tz = 'UTC'
        )
      ),
      scientific = FALSE
    )



    getParams$to <- format(
      as.numeric(
        as.POSIXct(
          to,
          tz = 'UTC'
        )
      ), scientific = FALSE
    )

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
        from = from,
        to = to
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
        to   = to
      )
    )


  }


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
    as.numeric(response[,1]),
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
