# script: api_bitmart
# date: 2023-12-20
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;

# 0) Define base and endpoint
# URLs
bitmartUrl <- function(
    futures = TRUE
) {

  # 1) define baseURL
  # for each API
  baseUrl <- base::ifelse(
    test = futures,
    yes  = 'https://api-cloud.bitmart.com',
    no   = 'https://api-cloud.bitmart.com'
  )

  # 2) return the
  # baseURL
  return(
    baseUrl
  )

}

bitmartEndpoint <- function(
    ohlc = TRUE,
    futures = TRUE
) {

  if (ohlc) {

    # 1) construct endpoint url
    endPoint <- base::ifelse(
      test = futures,
      yes  = '/contract/public/kline',
      no   = '/spot/quotation/v3/lite-klines'
    )

  } else {

    endPoint <- base::ifelse(
      test = futures,
      yes  = '/contract/public/details',
      no   = '/spot/v1/symbols'
    )


  }

  # 2) return endPoint url
  return(
    endPoint
  )

}


# 1) Define bitmart intervals
bitmartIntervals <- function(futures, interval, all = FALSE) {

  # this funtion serves two purposes
  #
  # 1) listing all available
  # intervals
  #
  # 2) extracting chosen intervals
  # for the remainder of this script.
  #
  # This step is unnessary for some of
  # the REST APIs like bitmart, but it provides
  # a more streamlined programming structure

  allIntervals <- data.frame(
    cbind(
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
        '3d',
        '1w'
      ),
      values = c(
        1,
        3,
        5,
        15,
        30,
        60,
        120,
        240,
        360, #
        720,
        1440,
        4320,
        10080
      )
    )
  )


  # if all; then this function
  # has been called by availableIntervals
  # and will return all available intervals


  if (all) {

    interval <- allIntervals$labels

  } else {

    # 1) locate the chosen interval
    # from the list
    indicator <- grepl(
      pattern = paste0('^', interval),
      ignore.case = FALSE,
      x = allIntervals$labels
    )

    # 2) extract the interval
    # from the list
    interval <- allIntervals[indicator,]$values
  }


  return(
    interval
  )

}

# 3) define binance response object
# and format
bitmartResponse <- function(
    ohlc = TRUE,
    futures
) {

  # mock response
  # to avoid check error in
  # unevaluated expressions
  response <- NULL

  if (ohlc) {

    # NOTE: Binance
    # returns everything
    # from spot and futures market
    # in a similar manner
    if (futures) {

      list(
        colum_names = c(
          'Low',
          'High',
          'Open',
          'Close',
          'Volume'
        ),
        colum_location = c(
          1:5
        ),
        index_location = c(
          6
        )

      )

    } else {

      list(
        colum_names = c(
          'Open',
          'High',
          'Low',
          'Close',
          'Volume'
        ),
        colum_location = c(
          2:5,7
        ),
        index_location = c(
          1
        )

      )

    }



  } else {

    if (futures) {



      list(
        code = rlang::expr(
          response$data$symbol$symbol
        )
      )

    } else {

      list(
        code = rlang::expr(
          response$data$symbols
        )
      )

    }
  }

}


# 4) bitmart date formats
# to be sent, and recieved, from
# the API
bitmartDates <- function(
    futures,
    dates,
    is_response = FALSE
) {






  if (!is_response) {

    # 1) set multiplier
    # according to spot/perpertual
    # markets
    multiplier <- ifelse(
      futures,
      yes = 1,
      no = 1
    )
    # 1) convert all
    # dates to numeric
    dates <- lapply(
      dates,
      convertDate,
      multiplier = multiplier,
      power = 1
    )

    # 1.1) add one day
    dates[[2]] <- dates[[2]]

    # 2) convert all
    # dates according
    # to the API requirements
    dates <- lapply(
      as.numeric(dates),
      format,
      scientific = FALSE
    )

    if (futures) {

      names(dates) <- c(
        'start_time',
        'end_time'
      )

    } else {

      names(dates) <- c(
        'after',
        'before'
      )
    }






    return(
      dates
    )
  }

  # if its a response
  # the dates should be parsed back accordingly
  if (is_response) {

    # 1) convert back to
    # posit
    dates <- convertDate(
      date = as.numeric(dates),
      is_response = TRUE
    )

    return(
      dates
    )

  }
}


# 4) bitmart parameters
bitmartParameters <- function(
    futures = TRUE,
    ticker,
    interval,
    from = NULL,
    to = NULL
    ) {

  # Basic parameters
  params <- list(
    symbol = ticker,
    step = bitmartIntervals(
      interval = interval,
      futures = futures
      )
  )

  # Add date parameters
  date_params <- bitmartDates(
    futures = futures,
    dates = list(
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


