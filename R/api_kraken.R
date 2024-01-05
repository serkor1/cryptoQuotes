# script: api_kraken
# date: 2023-12-20
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create all necessary parameters
# for a proper API call
# script start;
# 1) URLs and Endpoint; ####
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
    type = 'ohlc',
    futures = TRUE
) {

  endPoint <- switch(
    EXPR = type,
    ohlc = {
      if (futures) 'api/charts/v1' else '0/public/OHLC'
    },
    ticker ={
      if (futures) '/derivatives/api/v3/instruments' else '0/public/AssetPairs'
    }
  )



  # 2) return endPoint url
  return(
    endPoint
  )

}

# 2) Available intervals; #####
krakenIntervals <- function(
    interval,
    futures,
    all = FALSE
) {
  if (futures) {
    # For futures, labels and values are the same
    allIntervals <- data.frame(
      labels = c("1m", "5m", "15m", "30m", "1h", "4h", "12h", "1d", "1w"),
      values = c("1m", "5m", "15m", "30m", "1h", "4h", "12h", "1d", "1w")
    )
  } else {
    # For non-futures, labels and values are different
    allIntervals <- data.frame(
      labels = c("1m", "5m", "15m", "30m", "1h", "4h", "1d", "1w", "2w"),
      values = c(1   ,5   ,15   ,30    ,60   ,240 , 1440,10080,21600)
    )
  }

  if (all) {

    return(allIntervals$labels)

  } else {
    # Locate and return the chosen interval value
    matchedInterval <- allIntervals$values[
      grepl(paste0('^', interval, '$'), allIntervals$labels, ignore.case = TRUE)
    ]

    return(matchedInterval)
  }
}

# 3) define response object and format; ####
krakenResponse <- function(
    type = 'ohlc',
    futures
) {

  response <- NULL





  # Define the basic structure for OHLC data
  ohlc_structure <- function(volume_loc = 6) {
    list(
      colum_names = c('Open', 'High', 'Low', 'Close', 'Volume'),
      colum_location = c(2:5, volume_loc),
      index_location = 1
    )
  }


  switch(
    EXPR = type,
    ohlc = {
      ohlc_structure(
        volume_loc = if (!futures) 7 else 6
      )
    },
    ticker = {

      # Non-OHLC data
      response_code_structure <- function(market) {

        switch (
          market,
          'futures' = list(
            code = rlang::expr(
              subset(
                response$instruments,
                response$instruments$tradeable == 'TRUE'
              )$symbol
            )
          ),
          'spot'    = list(
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
        )
      }

      return(
        response_code_structure(
          market = if (futures) 'futures' else 'spot'
        )
      )

    }
  )

}

# 4) Dates passed to and from endpoints; ####
krakenDates <- function(
    futures,
    dates,
    is_response = FALSE
) {

  if (!is_response) {
    dates <- convertDate(
      date = dates,
      is_response = FALSE,
      multiplier = 1,
      power = 1
    )

    if (!futures) {
      # Adjust for Spot market
      dates[1] <- dates[1] - 15 * 60
    }

    dates <- format(x = dates, scientific = FALSE)

    # Set names based on futures
    names(dates) <- if (futures) c('from', 'to') else c('since', 'to')

    return(dates)

  } else {
    # Processing response
    dates <- convertDate(
      date = as.numeric(dates),
      multiplier = ifelse(futures, yes = 1000, no = 1),
      power = -1,
      is_response = TRUE
    )

    return(dates)
  }
}


# 5) Parameters passed to endpoints; ####
krakenParameters <- function(
    futures = TRUE,
    ticker,
    interval,
    type = NULL,
    from = NULL,
    to = NULL
) {

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
    dates = c(
      from = from,
      to = to
    ),
    is_response = FALSE
  )


  # Set specific parameters for futures or non-futures
  if (futures) {
    params$symbol = params$ticker
    params$resolution = params$interval
    params$tick_type = 'trade'
    params$from = date_params[1]
    params$to = date_params[2]
    params$query = list(
      from = date_params[1],
      to =date_params[2]
    )
    params$path = list(
      tick_type = 'trade',
      symbol = params$symbol,
      resolution = params$resolution
    )
  } else {

    params$pair = params$ticker
    params$query = list(
      since = date_params[1],
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
