# script: api_bybit
# date: 2023-12-20
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create all necessary parameters
# for a proper API call
# script start;
# 1) URLs and Endpoint; ####
bybitUrl <- function(
    futures = TRUE,
    ...) {

  # 1) define baseURL
  # for each API
  baseUrl <- base::ifelse(
    test = futures,
    yes  = 'https://api.bybit.com',
    no   = 'https://api.bybit.com'
  )

  # 2) return the
  # baseURL
  baseUrl

}

bybitEndpoint <- function(
    type = 'ohlc',
    futures = TRUE,
    top = FALSE) {

  endPoint <- switch(
    EXPR = type,

    ohlc = {
      if (futures)
        'v5/market/kline'
      else
        'v5/market/kline'
    },

    ticker = {
      if (futures)
        'v5/market/instruments-info?category=linear'
      else
        'v5/market/instruments-info?category=spot'
    },

    lsratio = {
      if (top)
        'v5/market/account-ratio'
      else
        'v5/market/account-ratio'
    },

    fundingrate = {
      'v5/market/funding/history'
    },

    interest = {
      '/v5/market/open-interest'
    }
  )

  # 2) return endPoint url
  return(
    endPoint
  )

}

# 2) Available intervals; #####
bybitIntervals <- function(
    type,
    interval,
    futures = NULL,
    all = FALSE,
    ...) {

  # 0) Define intervals
  all_intervals <- switch(
    EXPR = type,

    'lsratio' = {
      data.frame(
        labels = c('5m', '15m', '30m', '1h', '4h', '1d'),
        values = c("5min", "15min", "30min", "1h", "4h", "1d")
      )
    },

    'interest' = {
      data.frame(
        labels = c('5m', '15m', '30m', '1h', '4h', '1d'),
        values = c("5min", "15min", "30min", "1h" , "4h", "1d")
      )
    },

    data.frame(
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
        '12h',
        '1d',
        '1M',
        '1w'
      ),
      values = c(
        "1" ,
        "3",
        "5",
        "15",
        "30",
        "60",
        "120",
        "240",
        "360",
        "720",
        "D",
        "M",
        "W"
      )
    )
  )



  # 2.1) if not ALL
  # then return interval
  # selected
  if (all) {

    # 2) return all
    # intervals
    interval <- all_intervals$labels



  } else {

    interval <- all_intervals$values[
      grepl(pattern = paste0('^', interval, '$'), x = all_intervals$labels)
    ]

  }

  interval

}


# 3) define response object and format; ####
bybitResponse <- function(
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
        colum_names = c(
          'open',
          'high',
          'low',
          'close',
          'volume'
        ),
        colum_location = c(
          2:6
        ),
        index_location = c(
          1
        )

      )
    },
    ticker = {
      list(
        foo = function(response, futures = NULL){
          subset(
            response$result$list,
            response$result$list$status == 'Trading'
          )$symbol
        }
      )
    },
    interest = {
      list(
        colum_names     = c('open_interest'),
        index_location = c(2),
        colum_location = c(1)
      )
    },

    fundingrate = {
      list(
        colum_names     = "funding_rate",
        index_location = c(3),
        colum_location = c(2)
      )
    },

    lsratio <- {
      list(
        colum_names     = c('long', 'short'),
        index_location = c(4),
        colum_location = c(2:3)
      )
    }


  )

}

# 4) Dates passed to and from endpoints; ####
bybitDates <- function(
    futures,
    dates,
    is_response = FALSE,
    ...) {


  # 0) Set multiplier
  multiplier <- 1e3

  # 1) determine wether
  # its a response or request
  if (is_response) {

    dates <- convert_date(
      x = as.numeric(dates),
      multiplier = multiplier
    )

  } else {

    dates <- convert_date(
      x = dates,
      multiplier = multiplier)

    dates <- vapply(
      dates,
      format,
      scientific = FALSE,
      FUN.VALUE = character(1)
    )



    names(dates) <-c('start', 'end')



  }

  dates

}

# 5) Parameters passed to endpoints; ####
bybitParameters <- function(
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
    category = if (futures) 'linear' else 'spot',
    interval = bybitIntervals(
      interval = interval,
      type    = type
    ),
    limit = 1000
  )

  # Add date parameters
  date_params <- bybitDates(
    futures = futures,
    dates = c(
      from = from,
      to = to
    ),
    is_response = FALSE
  )


  if (type == "fundingrate"){

    names(date_params) <- c("startTime", "endTime")

  }

  if (type == "interest") {

    names(params)[3] <- 'intervalTime'
    names(date_params) <- c("startTime", "endTime")
    params$limit <- 200
  }

  if (type == 'lsratio') {
    # 4.1) This is a standalone
    # parameter; was called interval
    # but is named period in the API calls
    names(params)[3] <- 'period'

    # 4.1) Return only
    # 100 such that this function
    # aligns with the remaining
    # functions which
    # also returns 100
    params$limit <- 500

  }

  # Combine all parameters
  params <- c(params, date_params)

  # Return a structured list with additional common parameters
  return(
    list(
      query = params,
      path = NULL,
      futures = futures,
      source = 'bybit',
      ticker = ticker,
      interval = interval
    )
  )
}

# script end; ####
