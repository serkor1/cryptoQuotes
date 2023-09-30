# script: helpers
# author: Serkan Korkmaz
# date: 2023-09-20
# objective: Generate a set of functions
# to ease the process of getting cryptoQuotes
# script start; ####

# base-url;
baseUrl <- function(
    source = 'binance',
    futures
) {
  # function information
  #
  # This function returns the baseUrl
  # of the API calls.
  if (grepl(pattern = 'binance', x = source, ignore.case = TRUE)) {

    if (futures) {

      baseUrl <- 'https://fapi.binance.com'

    } else {

      baseUrl <- 'https://data-api.binance.vision'

    }
  }


  if (grepl(pattern = 'kucoin', x = source, ignore.case = TRUE)) {

    if (futures) {

      baseUrl <- 'https://fapi.binance.com'

    } else {

      baseUrl <- 'https://api.kucoin.com'

    }
  }



  return(
    baseUrl
  )
}


# endpoint
endPoint <- function(futures) {

  # The choice should be
  # between

  if (futures) {

    endPoint <- '/fapi/v1/continuousKlines'

  } else {


    endPoint <- '/api/v3/klines'


  }

  return(
    endPoint
  )

}


getParams <- function(
    source,
    futures,
    ticker,
    interval,
    from = NULL,
    to = NULL
) {



  if (grepl(pattern = 'binance', x = source, ignore.case = TRUE)) {

    if (futures) {



      getParams <- list(
        pair = ticker,
        contractType = 'PERPETUAL',
        interval = interval
      )

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
          ) * 1e3,
          scientific = FALSE
        )


      }



    } else {

      getParams <- list(
        symbol = ticker,
        interval = interval
      )

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



        getParams$endTime   <- format(
          as.numeric(
            as.POSIXct(
              to,
              tz = 'UTC'
            )
          ) * 1e3, scientific = FALSE
        )


      }



    }

  }




  return(
    getParams
  )



}



fetchQuote <- function(
    source,
    futures,
    interval,
    ticker,
    from,
    to
) {

  # function information
  #
  #
  # This function fetches the
  # the data

  # 1) GET request
  response <- httr::GET(
    url   = baseUrl(
      source = source,
      futures = futures
      ),
    httr::timeout(10),
    # NOTE: Cant connect
    # to Binance with this
    # httr::use_proxy(
    #   url = '141.11.158.172',
    #   port = 8080
    #   ),
    path  = endPoint(futures = futures),
    query = getParams(
      source = source,
      futures = futures,
      ticker = ticker,
      interval = interval,
      from = from,
      to   = to
    )
  )

  # 2) parse response
  response <- jsonlite::fromJSON(
    txt = httr::content(
      x = response,
      as = 'text',
      encoding = 'UTF-8'
    )
  )


  class(response) <- c(
    class(response),
    'rawQuote',
    ifelse(futures, 'futures', 'spot'),
    source
  )


  return(
    response
  )

}






formatQuote <- function(
    quote
) {


  if (!inherits(x = quote, what = c('rawQuote'))) {
    rlang::abort(
      message = 'Has to be class "rawQuote"'
    )
  }

  if (inherits(x = quote, what = c('binance'))) {

    # 1) construct names
    column_names <- c(
      'Open',
      'High',
      'Low',
      'Close',
      'Volume'
    )




    # 3) the first element
    # is always the data
    # from Binance
    index <- as.POSIXct(
      as.numeric(quote[,1])/1e3,
      origin = '1970-01-01',
      tz = 'UTC'
    )



    if (inherits(x = quote, what = c('futures'))) {

      keep_cols <- c(
        2:6
      )
      #attr(index, "tzone") <- Sys.timezone()



    }

    if (inherits(x = quote, what = 'spot')) {


      keep_cols <- c(
        2:6
      )


    }




    quote <- quote[,keep_cols]


    colnames(quote) <- column_names[seq_along(keep_cols)]


  }

  # 2) convert all
  # quote elements to
  # numeric
  quote <- apply(
    quote,
    c(1,2),
    as.numeric
  )


  quote <- zoo::as.zoo(
    quote
  )

  zoo::index(quote) <- index

  quote <- xts::as.xts(
    quote
  )


  return(quote)


}




# end of script; ####
