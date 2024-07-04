# script: api_huobi
# date: 2024-06-07
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create all necessary parameters
# for a proper API call
# script start;
# 1) URLs and Endpoint; ####
huobiUrl <- function(
    futures = TRUE,
    ...) {

  # 1) define baseURL
  # for each API
  if (futures)
    'https://api.hbdm.com'
  else
    'https://api.huobi.pro'

}

huobiEndpoint <- function(
    type    = 'ohlc',
    futures = TRUE,
    top     = FALSE) {

  switch(
    EXPR = type,
    ticker ={
      if (futures)
        "linear-swap-api/v1/swap_api_state"
      else
        "v2/settings/common/symbols"
    },
    {
      if (futures)
        'linear-swap-ex/market/history/kline'
      else
        'market/history/kline'
    }
  )
}

# 2) Available intervals; #####
huobiIntervals <- function(
    futures,
    interval,
    all = FALSE,
    type,
    ...) {

  # 0) define intervals
  # NOTE: These are common for
  # both endpoints

  interval_label <- c(
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

  interval_actual <-  c(
    "1min",
    "5min",
    "15min",
    "30min",
    "60min",
    "4hour",
    "1day",
    "1week",
    "1mon"
  )


  if (all) { return(interval_label) }

  interval_actual[
    interval_label %in% interval
  ]

}


# 3) define response object and format; ####
huobiResponse <- function(
    type = 'ohlc',
    futures,
    ...) {

  # mock response
  # to avoid check error in
  # unevaluated expressions
  response <- NULL

  switch(
    EXPR = type,
    ticker = {
      list(
        foo = function(
    response,
    futures = NULL){

          if (futures) {

            subset(
              response$data
            )$contract_code

          } else {

            subset(
              response$data,
              response$data$state == "online" & response$data$te == TRUE
            )$sc

          }

        }
      )
    },
    {

      list(
        colum_names = if (futures)
          c(
            'open',
            'close',
            'high',
            'low',
            'volume'
          )

        else {
          c(
            'open',
            'close',
            'low',
            'high',
            'volume'
          )
        },
        colum_location = if (futures) c(2:5,7) else c(2:6),
        index_location = c(
          1
        )

      )

    }

  )

}

# 4) Dates passed to and from endpoints; ####
huobiDates <- function(
    futures,
    dates,
    is_response = FALSE,
    ...) {

  # 0) Set multiplier
  multiplier <- 1

  # 1) determine wether
  # its a response or request
  if (is_response) {

    # NOTE: The API returns
    # in GMT+8 time and
    # convert_date assumes that its
    # UTC
    dates <- convert_date(
      x = as.numeric(dates),
      multiplier = multiplier)

  } else {

    dates <- format(
      convert_date(
        x = dates,
        multiplier = multiplier
      ),
      scientific = FALSE
    )

    names(dates) <- c('from', 'to')

  }

  dates

}

# 5) Parameters passed to endpoints; ####
huobiParameters <- function(
    futures = TRUE,
    type   = 'ohlc',
    ticker,
    interval,
    from = NULL,
    to = NULL,
    ...) {

  # Basic parameters common to both futures and non-futures
  params <- list(
    symbol = ticker,
    period = huobiIntervals(
      interval = interval,
      futures  = futures,
      type     = type
    ),
    size = 2000
  )

  if (futures) names(params)[1] <- "contract_code"

  # Add date parameters
  date_params <- huobiDates(
    futures = futures,
    dates = c(
      from = from,
      to = to
    ),
    is_response = FALSE
  )

  # Combine all parameters
  params <- c(params)

  # Return a structured list with additional common parameters
  return(
    list(
      query    = params,
      path     = NULL,
      futures  = futures,
      source   = 'huobi',
      ticker   = ticker,
      interval = interval
    )
  )
}

# script end; ####
