# script: api_kraken
# date: 2023-12-20
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create all necessary parameters
# for a proper API call
# script start;
# 1) URLs and Endpoint; ####
krakenUrl <- function(
  futures = TRUE,
  ...
) {
  # 1) define baseURL
  # for each API
  if (futures) {
    'https://futures.kraken.com'
  } else {
    'https://api.kraken.com'
  }
}

krakenEndpoint <- function(
  type = 'ohlc',
  futures = TRUE,
  ...
) {
  switch(
    EXPR = type,
    ticker = {
      if (futures) {
        'derivatives/api/v3/tickers'
      } else {
        '0/public/AssetPairs/'
      }
    },
    # Was lsratio
    lsratio = {
      'api/charts/v1/analytics/'
    },
    interest = {
      'api/charts/v1/analytics/'
    },
    {
      if (futures) {
        'api/charts/v1/'
      } else {
        '0/public/OHLC/'
      }
    }
  )
}

# 2) Available intervals; #####
krakenIntervals <- function(
  type,
  futures,
  interval,
  all = FALSE,
  ...
) {
  # 0) construct intervals
  switch(
    EXPR = type,
    'ohlc' = {
      if (futures) {
        # For futures, labels and values are the same

        interval_label <- c(
          "1m",
          "5m",
          "15m",
          "30m",
          "1h",
          "4h",
          "12h",
          "1d",
          "1w"
        )
        interval_actual <- c(
          "1m",
          "5m",
          "15m",
          "30m",
          "1h",
          "4h",
          "12h",
          "1d",
          "1w"
        )
      } else {
        # For non-futures, labels and values are different

        interval_label <- c(
          "1m",
          "5m",
          "15m",
          "30m",
          "1h",
          "4h",
          "1d",
          "1w",
          "2w"
        )
        interval_actual <- c(1, 5, 15, 30, 60, 240, 1440, 10080, 21600)
      }
    }, # default values
    {
      interval_label <- c(
        "1m",
        "5m",
        "15m",
        "30m",
        "1h",
        "4h",
        "12h",
        "2d",
        "8d"
      )
      interval_actual <- c(
        60,
        300,
        900,
        1800,
        3600,
        14400,
        43200,
        86400,
        604800
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
krakenResponse <- function(
  type = 'ohlc',
  futures,
  ...
) {
  # Define the basic structure for OHLC data
  ohlc_structure <- function(volume_loc = 6) {
    list(
      colum_names = c('open', 'high', 'low', 'close', 'volume'),
      colum_location = c(2:5, volume_loc),
      index_location = 1
    )
  }

  switch(
    EXPR = type,
    ticker = {
      list(
        foo = function(response, futures) {
          if (futures) {
            response[["tickers"]]$symbol
          } else {
            unname(
              obj = sapply(
                response$result,
                function(x) {
                  x$altname
                },
                simplify = TRUE,
                USE.NAMES = FALSE
              ),
              force = TRUE
            )
          }
        }
      )
    },

    lsratio = {
      list(
        colum_names = c('long', 'short'),
        index_location = c(1),
        colum_location = c(4, 5)
      )
    },
    #
    # interest = {
    #   list(
    #     colum_names = c('open', 'high', 'low', "close"),
    #     index_location = c(1),
    #     colum_location = c(2, 3, 4, 5)
    #   )
    # },
    {
      ohlc_structure(
        volume_loc = if (futures) 6 else 7
      )
    }
  )
}

# 4) Dates passed to and from endpoints; ####
krakenDates <- function(
  futures,
  dates,
  type,
  is_response = FALSE,
  ...
) {
  if (is_response) {
    # Processing response
    dates <- convert_date(
      x = as.numeric(dates),
      multiplier = ifelse(
        futures,
        yes = if (type %in% c('lsratio', "interest")) 1 else 1000, # was 1000
        no = 1
      )
    )
  } else {
    dates <- convert_date(
      x = dates,
      multiplier = ifelse(
        type == "interest",
        yes = 1,
        no = 1
      )
    )

    if (!futures) {
      # Adjust for Spot market
      dates[1] <- dates[1] - 15 * 60
    }

    dates <- format(x = dates, scientific = FALSE)

    # Set names based on futures
    names(dates) <- if (futures) c('from', 'to') else c('since', 'to')
  }

  dates
}

# 5) Parameters passed to endpoints; ####
krakenParameters <- function(
  futures = TRUE,
  ticker,
  interval,
  type = NULL,
  from = NULL,
  to = NULL,
  ...
) {
  # Set common parameters
  params <- list(
    ticker = ticker,
    interval = krakenIntervals(
      interval = interval,
      futures = futures,
      type = type
    )
  )

  #long-short-ratio/
  # Add dates
  date_params <- krakenDates(
    futures = futures,
    dates = c(
      from = from,
      to = to
    ),
    type = type,
    is_response = FALSE
  )

  switch(
    type,
    interest = {
      params$symbol <- params$ticker
      params$resolution <- params$interval
      params$query <- list(
        interval = params$interval,
        since = date_params[1],
        to = date_params[2]
      )
      params$path <- list(
        symbol = params$symbol,
        tick_type = "open-interest"
      )
    },
    lsratio = {
      params$symbol <- params$ticker
      params$resolution <- params$interval
      params$query <- list(
        interval = params$interval,
        since = date_params[1],
        to = date_params[2]
      )
      params$path <- list(
        symbol = params$symbol,
        tick_type = 'long-short-info'
      )
    },
    {
      # Set specific parameters for futures or non-futures
      if (futures) {
        params$symbol <- params$ticker
        params$resolution <- params$interval
        params$query <- list(
          interval = params$interval,
          from = date_params[1],
          to = date_params[2]
        )
        params$path <- list(
          tick_type = 'mark',
          symbol = params$symbol,
          resolution = params$resolution
        )
      } else {
        params$pair <- params$ticker
        params$query <- list(
          since = date_params[1],
          to = date_params[2],
          pair = params$pair,
          interval = params$interval
        )
        params$path <- NULL
      }
    }
  )

  # Common parameters for both futures and non-futures
  params$futures <- futures
  params$source <- 'kraken'

  # Return the structured list
  params
}

# script end;
