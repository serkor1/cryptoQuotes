# script: new_api_mexc
# date: 2023-12-18
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create all necessary parameters
# for a proper API call
# script start;
# 1) URLs and Endpoint; ####
mexcUrl <- function(
    futures = TRUE,
    ...) {

  # 1) define baseURL
  # for each API
  base::ifelse(
    test = futures,
    yes  = 'https://contract.mexc.com',
    no   = 'https://api.mexc.com'
  )

}

mexcEndpoint <- function(
    type = 'ohlc',
    futures = TRUE,
    ...) {

  switch(
    EXPR = type,
    ohlc = {
      if (futures)
        'api/v1/contract/kline/'
      else
        'api/v3/klines'
    },
    ticker ={
      if (futures)
        'api/v1/contract/detail'
      else
        'api/v3/exchangeInfo'
    },
    fundingrate = {
      'api/v1/contract/funding_rate/history'
    }
  )

}

# 2) Available intervals; #####
mexcIntervals <- function(
    interval,
    futures,
    all = FALSE,
    ...) {

  if (futures) {
    allIntervals <- data.frame(
      labels = c(
        '1m',
        '5m',
        '15m',
        '30m',
        '1h',
        '4h',
        '8h',
        '1d',
        '1w',
        "1M"
      ),
      values = c(
        "Min1",
        "Min5",
        "Min15",
        "Min30",
        "Min60",
        "Hour4",
        "Hour8",
        "Day1",
        "Week1",
        "Month1")
    )
  } else {
    allIntervals <- data.frame(
      labels = c(
        '1m',
        '5m',
        '15m',
        '30m',
        '1h',
        '4h',
        '1d',
        '1w',
        '1M'
      ),
      values = c(
        '1m',
        '5m',
        '15m',
        '30m',
        '1h',
        '4h',
        '1d',
        '1w',
        '1M'
      )
    )
  }

  if (all) {

    return(allIntervals$labels)

  } else {
    # Select the specified interval
    selectedInterval <- allIntervals$values[
      grepl(paste0('^', interval, '$'), allIntervals$labels, ignore.case = TRUE)
    ]

    return(selectedInterval)
  }
}

# 3) define response object and format; ####
mexcResponse <- function(
    type = 'ohlc',
    futures,
    ...) {

  # mock response
  # to avoid check error in
  # unevaluated expressions
  response <- NULL

  switch(
    EXPR = type,
    ohlc = {
      list(
        colum_names = if (futures)
          c('open', 'close', 'high', 'low', 'volume')
        else
          c('open', 'high', 'low', 'close', 'volume'),
        colum_location = c(2:6),
        index_location = 1
      )
    },
    ticker = {
      list(
        foo = function(response, futures) {
          if (futures) {
            response$data$symbol

          } else {
            subset(
              x = response$symbols,
              response$symbols$status == "ENABLED"
            )$symbol


          }
        }
      )
    },

    fundingrate = {
      list(
        colum_names    = "funding_rate",
        index_location = c(3),
        colum_location = c(2)
      )
    }
  )

}

# 4) Dates passed to and from endpoints; ####
mexcDates <- function(
    futures,
    dates,
    is_response = FALSE,
    type = "ohlc",
    ...) {
  # Set multiplier based on market
  # and type
  #
  # If fundingrate the multiplier
  # is 1e3
  multiplier <- 1e3 / if (futures) 1e3 else 1

  # Convert and format dates
  dates <- convert_date(
    x = if (is_response) as.numeric(dates) else dates,
    multiplier = multiplier
    )

  if (!is_response) {
    dates <- format(dates, scientific = FALSE)

    if (!futures) {
      # Adjust for mexc spot and set names
      dates <- as.numeric(dates)
      dates[2] <- dates[2] + 15 * 60
      names(dates) <- c('startTime', 'endTime')
    } else {
      # Set names for futures
      names(dates) <- c('start', 'end')
    }
  }

  dates
}



# 5) Parameters passed to endpoints; ####
mexcParameters <- function(
    futures = TRUE,
    ticker,
    type = NULL,
    interval,
    from = NULL,
    to = NULL,
    ...) {

  # Set initial parameters with interval and assign appropriate name
  params <- list(
    interval = mexcIntervals(
      interval = interval,
      futures = futures
    )
  )

  # Add date parameters
  params <- c(
    params,
    mexcDates(
      futures = futures,
      dates = c(from = from, to = to)
    )
  )

  # Handle type-specific parameters
  if (type == "fundingrate") {
    params$symbol <- ticker
    params$page_size <- 100
  } else {
    if (futures) {
      params$path <- list(ticker)
    } else {
      params$symbol <- ticker
      params$limit  <- 1000
    }
  }

  # Construct the final parameter list based on type
  params <- switch(
    EXPR = type,
    fundingrate = list(
      query = params,
      futures = futures,
      source = 'mexc',
      interval = interval
    ),
    ohlc = list(
      query = params,
      path = if (futures) list(ticker) else NULL,
      futures = futures,
      source = 'mexc',
      interval = interval
    ),
    # Default case to handle unexpected types
    list(
      query    = params,
      futures  = futures,
      source   = 'mexc',
      interval = interval
    )
  )

  # Return the final structured parameter list
  params
}
# script end;
