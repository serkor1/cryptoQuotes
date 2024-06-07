# script: new_api_crypto.com
# date: 2024-06-07
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create all necessary parameters
# for a proper API call
# script start;
# 1) URLs and Endpoint; ####
crypto.comUrl <- function(
    futures = TRUE,
    ...) {

  # 1) define baseURL
  # for each API
  baseURL <- 'https://api.crypto.com/exchange/v1/public'

  # 2) return the
  # baseURL
  baseURL

}

crypto.comEndpoint <- function(
    type = 'ohlc',
    futures = TRUE,
    ...) {

  endPoint <- switch(
    EXPR = type,
    ohlc = {
      'get-candlestick'
    },
    ticker ={
      'get-instruments'
    },
    fundingrate = {
      'get-valuations'
    }
  )

  # 2) return endPoint url
  endPoint
}

# 2) Available intervals; #####
crypto.comIntervals <- function(
    interval,
    futures,
    all = FALSE,
    ...) {

  allIntervals <- data.frame(
    labels = c(
      "1m",
      "5m",
      "15m",
      "30m",
      "1h",
      "2h",
      "4h",
      "12h",
      "1d",
      "1w",
      "2w",
      "1M"
    ),
    values = c(
      "M1",
      "M5",
      "M15",
      "M30",
      "H1",
      "H2",
      "H4",
      "H12",
      "1D",
      "7D",
      "14D",
      "1M"
    )


  )

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
crypto.comResponse <- function(
    type = 'ohlc',
    futures,
    ...) {

  response <- NULL

  # mock response
  # to avoid check error in
  # unevaluated expressions
  response <- NULL

  switch(
    EXPR = type,
    ohlc = {
      list(
        colum_names = c('open', 'high', 'low', 'close', 'volume'),
        colum_location = 1:5,
        index_location = 6
      )
    },
    ticker = {
      list(
        foo = function(response, futures) {

          subset(
            response$result$data,
            response$result$data$tradable == TRUE &
              response$result$data$inst_type %in% ifelse(
                futures,
                c("PERPETUAL_SWAP", "FUTURE"),
                "CCY_PAIR"

              )
          )$symbol
        }
      )
    },

    fundingrate = {
      list(
        colum_names    = "funding_rate",
        index_location = c(2),
        colum_location = c(1)
      )
    }
  )

}

# 4) Dates passed to and from endpoints; ####
crypto.comDates <- function(
    futures,
    dates,
    is_response = FALSE,
    ...) {

  # 0) set multiplier based
  # on market
  multiplier <- 1e3

  # 1) if its a response
  if (is_response) {

    dates <- convert_date(
      x = as.numeric(dates),
      multiplier = multiplier
    )


  } else {


    # Convert dates and format

    dates <- convert_date(
      x = dates,
      multiplier = multiplier
    )

    dates <- format(
      dates,
      scientific = FALSE
    )

    names(dates) <- c('start_ts', 'end_ts')

  }

  dates

}

# 5) Parameters passed to endpoints; ####
crypto.comParameters <- function(
    futures = TRUE,
    ticker,
    type = NULL,
    interval,
    from = NULL,
    to = NULL,
    ...) {

  # Initial parameter setup
  params <- list(
    instrument_name = ticker,
    timeframe = crypto.comIntervals(
      interval = interval,
      futures = futures
    ),
    count = 5000
  )

  if (type == "fundingrate"){
    params$valuation_type <- 'funding_hist'
  }

  # Add date parameters
  date_params <- crypto.comDates(
    futures = futures,
    dates = c(from = from, to = to)
  )

  # Combine all parameters
  params <- c(params, date_params)

  # Return structured list with additional parameters
  list(
    query    = params,
    path     = NULL,
    futures  = futures,
    source   = 'crypto.com',
    ticker   = ticker,
    interval = interval
  )
}

# script end;
