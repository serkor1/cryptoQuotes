# script: api_bitmart
# date: 2023-12-20
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create all necessary parameters
# for a proper API call
# script start;
# 1) URLs and Endpoint; ####
bitmartUrl <- function(
  futures = TRUE,
  ...
) {
  # 1) define baseURL
  # for each API
  if (futures) {
    'https://api-cloud-v2.bitmart.com'
  } else {
    'https://api-cloud.bitmart.com'
  }
}

bitmartEndpoint <- function(
  type = 'ohlc',
  futures = TRUE,
  ...
) {
  if (type == "ohlc") {
    if (futures) {
      'contract/public/kline'
    } else {
      'spot/quotation/v3/lite-klines'
    }
  } else {
    if (futures) {
      'contract/public/details'
    } else {
      'spot/v1/symbols'
    }
  }
}

# 2) Available intervals; #####
bitmartIntervals <- function(
  futures,
  interval,
  all = FALSE,
  ...
) {
  # Define all intervals in a data frame
  if (futures) {
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
      '12h',
      '1d',
      '3d',
      '1w'
    )

    interval_actual <- c(
      1,
      3,
      5,
      15,
      30,
      60,
      120,
      240,
      360,
      720,
      1440,
      4320,
      10080
    )
  } else {
    interval_label <- c(
      '1m',
      # '3m',
      '5m',
      '15m',
      '30m',
      '1h',
      '2h',
      '4h',
      # '6h',
      # '12h',
      '1d',
      # '3d',
      '1w'
    )

    interval_actual <- c(
      1,
      # 3,
      5,
      15,
      30,
      60,
      120,
      240,
      # 360,
      # 720,
      1440,
      # 4320,
      10080
    )
  }

  if (all) {
    return(interval_label)
  }

  interval_actual[
    interval_label %in% interval
  ]
}

# 3) define response object and format; ####
bitmartResponse <- function(
  type = 'ohlc',
  futures,
  ...
) {
  # mock response
  # to avoid check error in
  # unevaluated expressions
  response <- NULL

  if (type == "ohlc") {
    if (futures) {
      list(
        colum_names = c('low', 'high', 'open', 'close', 'volume'),
        colum_location = 1:5,
        index_location = 6
      )
    } else {
      list(
        colum_names = c('open', 'high', 'low', 'close', 'volume'),
        colum_location = c(2:5, 7),
        index_location = 1
      )

    }
  } else {
    list(
      foo = function(response, futures) {
        if (futures) {
          response$data$symbol$symbol
        } else {
          response$data$symbols
        }
      }
    )
  }
}

# 4) Dates passed to and from endpoints; ####
bitmartDates <- function(
  futures,
  dates,
  is_response = FALSE,
  ...
) {
  if (is_response) {
    dates <- convert_date(
      x = as.numeric(dates),
      multiplier = 1
    )
  } else {
    dates <- format(
      convert_date(
        x = dates,
        multiplier = 1
      ),
      scientific = FALSE
    )

    names(dates) <- if (futures) {
      c('start_time', 'end_time')
    } else {
      c('after', 'before')
    }
  }

  dates
}

# 5) Parameters passed to endpoints; ####
bitmartParameters <- function(
  futures = TRUE,
  ticker,
  type = NULL,
  interval,
  from = NULL,
  to = NULL,
  ...
) {
  # Basic parameters
  params <- list(
    symbol = ticker,
    step = bitmartIntervals(
      interval = interval,
      futures = futures
    ),
    limit = 200
  )

  # Add date parameters
  date_params <- bitmartDates(
    futures = futures,
    dates = c(
      from = from,
      to = to
    ),
    is_response = FALSE
  )

  # Combine all parameters
  params <- c(params, date_params)

  # Return a structured list with additional common parameters
  return(
    list(
      query = params,
      path = NULL,
      futures = futures,
      source = 'bitmart',
      ticker = ticker,
      interval = interval
    )
  )
}

# script end;
