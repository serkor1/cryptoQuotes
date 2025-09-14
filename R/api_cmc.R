# script: api_cmc
# date: 2025-05-02
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create all necessary parameters
# for a proper API call
# script start;

cmcUrl <- function(
  futures = TRUE,
  ...
) {
  "https://api.coinmarketcap.com/data-api"
}

cmcEndpoint <- function(
  type = "ohlc",
  futures = TRUE
) {
  switch(
    EXPR = type,
    ticker = {
      "v1/cryptocurrency/map?listing_status=inactive,untracked,active"
    },
    {
      "v3.1/cryptocurrency/historical"
    }
  )
}

cmcIntervals <- function(
  futures = FALSE,
  interval,
  all = FALSE,
  type = NULL,
  ...
) {
  interval_actual <- c(
    '5m',
    '10m',
    '15m',
    '45m',
    '1h',
    '2h',
    '3h',
    '6h',
    '12h',
    '1d',
    '2d',
    '3d',
    '7d',
    '14d',
    '15d',
    '30d'
    # ,
    # '60d',
    # '90d',
    # '365d'
  )

  interval_label <- c(
    '5m',
    '10m',
    '15m',
    '45m',
    '1h',
    '2h',
    '3h',
    '6h',
    '12h',
    '1d',
    '2d',
    '3d',
    '1w',
    '2w',
    '15d',
    '1M'
    # '2M',
    # '3M',
    # '1Y'
  )

  if (all) {
    return(interval_label)
  }

  interval_actual[
    interval_label %in% interval
  ]
}


cmcResponse <- function(
  type = 'ohlc',
  futures = TRUE,
  ...
) {
  switch(
    EXPR = type,
    ticker = {
      list(
        foo = function(response, futures = NULL) {
          # NOTE: It is returned in sorted order
          factor(
            x = response$data$symbol,
            levels = response$data$symbol,
            labels = response$data$symbol
          )
        }
      )
    },
    {
      list(
        colum_names = c('open', 'high', 'low', 'close', 'volume'),
        colum_location = c(6:10),
        index_location = 2
      )
    }
  )
}

cmcDates <- function(
  futures = TRUE,
  dates,
  is_response = FALSE,
  ...
) {
  # 0) Set multiplier
  multiplier <- 1e3

  # 1) determine wether
  # its a response or request
  if (is_response) {
    dates <- as.POSIXct(dates, format = "%Y-%m-%dT%H:%M:%OSZ", tz = "UTC")
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

cmcParameters <- function(
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
    id = as.integer(ticker),
    interval = cmcIntervals(
      interval = interval,
      futures = futures,
      type = type
    )
  )

  # Add date parameters
  date_params <- cmcDates(
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
    source = 'cmc',
    ticker = ticker,
    interval = interval
  )
}
