# script: api_binance
# date: 2023-12-20
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create all necessary parameters
# for a proper API call
# script start;
# 1) URLs and Endpoint; ####
binanceUrl <- function(
  futures = TRUE,
  ...
) {
  if (futures) {
    'https://fapi.binance.com'
  } else {
    'https://data-api.binance.vision'
  }
}

binanceEndpoint <- function(
  type = 'ohlc',
  futures = TRUE,
  top = FALSE
) {
  switch(
    EXPR = type,
    ticker = {
      if (futures) {
        'fapi/v1/exchangeInfo'
      } else {
        'api/v3/exchangeInfo'
      }
    },
    lsratio = {
      if (top) {
        'futures/data/topLongShortAccountRatio'
      } else {
        'futures/data/globalLongShortAccountRatio'
      }
    },
    interest = {
      'futures/data/openInterestHist'
    },
    fundingrate = {
      'fapi/v1/fundingRate'
    },
    {
      if (futures) {
        'fapi/v1/klines'
      } else {
        'api/v3/klines'
      }
    }
  )
}

# 2) Available intervals; #####
binanceIntervals <- function(
  futures,
  interval,
  all = FALSE,
  type,
  ...
) {
  #  0) wrap all intercals
  #  in switch
  switch(
    EXPR = type,
    'ohlc' = {
      if (futures) {
        # the labels
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
          '3d',
          '1w',
          '1M'
        )

        # the actual values
        interval_actual <- c(
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
          '3d',
          '1w',
          '1M'
        )
      } else {
        interval_label <- c(
          '1s',
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
          '3d',
          '1w',
          '1M'
        )

        interval_actual <- c(
          '1s',
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
          '3d',
          '1w',
          '1M'
        )
      }
    },

    # default return value

    {
      interval_label = c(
        '5m',
        '15m',
        '30m',
        '1h',
        '2h',
        '4h',
        '6h',
        '12h',
        '1d'
      )

      interval_actual = c(
        '5m',
        '15m',
        '30m',
        '1h',
        '2h',
        '4h',
        '6h',
        '12h',
        '1d'
      )
    }
  )

  if (all) {
    return(interval_label)
  }

  interval_actual[
    interval_label %in% interval
  ]
}

# 3) define response object and format; ####
binanceResponse <- function(
  type = 'ohlc',
  futures,
  ...
) {
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
          futures = NULL
        ) {
          subset(
            x = response$symbols,
            grepl(
              pattern = 'trading',
              ignore.case = TRUE,
              x = response$symbols$status
            )
          )$symbol
        }
      )
    },

    fundingrate = {
      list(
        colum_names = "funding_rate",
        index_location = 2,
        colum_location = 3
      )
    },

    interest = {
      list(
        colum_names = "open_interest",
        index_location = 5,
        colum_location = 2
      )
    },

    lsratio = {
      list(
        colum_names = c('long', 'short'),
        index_location = 5,
        colum_location = c(2, 4)
      )
    },
    {
      list(
        colum_names = c(
          'open',
          'high',
          'low',
          'close',
          'volume'
        ),
        colum_location = 2:6,
        index_location = 1
      )
    }
  )
}

# 4) Dates passed to and from endpoints; ####
binanceDates <- function(
  futures,
  dates,
  is_response = FALSE,
  ...
) {
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
    dates <- format(
      convert_date(
        x = dates,
        multiplier = multiplier
      ),
      scientific = FALSE
    )

    names(dates) <- c('startTime', 'endTime')
  }

  dates
}

# 5) Parameters passed to endpoints; ####
binanceParameters <- function(
  futures = TRUE,
  type = 'ohlc',
  ticker,
  interval,
  from = NULL,
  to = NULL,
  ...
) {
  # Basic parameters common to both futures and non-futures
  params <- list(
    symbol = ticker,
    interval = binanceIntervals(
      interval = interval,
      futures = futures,
      type = type
    ),
    limit = if (futures) 1500 else 1000
  )

  # Add date parameters
  date_params <- binanceDates(
    futures = futures,
    dates = c(
      from = from,
      to = to
    ),
    is_response = FALSE
  )

  if (type %in% c('lsratio', 'interest', 'fundingrate')) {
    # 4.1) This is a standalone
    # parameter; was called interval
    # but is named period in the API calls
    names(params)[2] <- 'period'

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
  list(
    query = params,
    path = NULL,
    futures = futures,
    source = 'binance',
    ticker = ticker,
    interval = interval
  )
}

# script end; ####
