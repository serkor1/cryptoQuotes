# script: new_api_kucoin
# date: 2023-12-18
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create all necessary parameters
# for a proper API call
# script start;
# 1) URLs and Endpoint; ####
kucoinUrl <- function(
    futures = TRUE,
    ...) {

  # 1) define baseURL
  # for each API
  if (futures)
    'https://api-futures.kucoin.com'
  else
    'https://api.kucoin.com'

}

kucoinEndpoint <- function(
    type = 'ohlc',
    futures = TRUE,
    ...) {

  switch(
    EXPR = type,
    ticker ={
      if (futures)
        'api/v1/contracts/active'
      else
        'api/v1/market/allTickers'
    },
    fundingrate = {
      'api/v1/contract/funding-rates'
    },
    {
      if (futures)
        'api/v1/kline/query'
      else
        'api/v1/market/candles'
    }
  )

}

# 2) Available intervals; #####
kucoinIntervals <- function(
    interval,
    futures,
    all = FALSE,
    ...) {

  if (futures) {

      interval_label <- c(
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
      )
      interval_actual <-  c(1, 5, 15, 30, 60, 120, 240, 480, 720, 1440, 10080)

  } else {

      interval_label <- c(
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
      )

      interval_actual <- c(
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

  }

  if (all) { return(interval_label) }

  interval_actual[
    interval_label %in% interval
  ]
}

# 3) define response object and format; ####
kucoinResponse <- function(
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
    ticker = {
      list(
        foo = function(response, futures) {
          if (futures) {
            subset(x = response$data,
                   grepl(
                     pattern = 'open',
                     ignore.case = TRUE,
                     x = response$data$status
                   ))$symbol

          } else {
            response$data$ticker$symbol

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
    },
    {
      list(
        colum_names = if (futures)
          c('open', 'high', 'low', 'close', 'volume')
        else
          c('open', 'close', 'high', 'low', 'volume'),
        colum_location = 2:6,
        index_location = 1
      )
    }
  )

}

# 4) Dates passed to and from endpoints; ####
kucoinDates <- function(
    futures,
    dates,
    is_response = FALSE,
    ...) {

  # 0) set multiplier based
  # on market
  multiplier <- if (futures)
    1e3
  else
    1

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

    if (!futures) {
      # Adjust for Kucoin spot and set names
      dates <- as.numeric(dates)

      dates[2] <- dates[2] + 15 * 60
      names(dates) <- c('startAt', 'endAt')

    } else {
      # Set names for futures
      names(dates) <- c('from', 'to')
    }

    dates <- format(
      dates,
      scientific = FALSE
    )
  }

  dates

}

# 5) Parameters passed to endpoints; ####
kucoinParameters <- function(
    futures = TRUE,
    ticker,
    type = NULL,
    interval,
    from = NULL,
    to = NULL,
    ...
) {

  # Initial parameter setup
  params <- list(
    symbol = ticker,
    interval = kucoinIntervals(
      interval = interval,
      futures = futures
    )
  )
  # Assign appropriate names based on the futures flag
  interval_param_name <- if (futures)
    'granularity'
  else
    'type'

  names(params)[2] <- interval_param_name

  # Add date parameters
  date_params <- kucoinDates(
    futures = futures,
    dates = c(from = from, to = to)
  )

  # Combine all parameters
  params <- c(params, date_params)

  # Return structured list with additional parameters
  return(
    list(
      query    = params,
      path     = NULL,
      futures  = futures,
      source   = 'kucoin',
      ticker   = ticker,
      interval = interval
    )
  )
}

# script end;
