# script: api_kraken
# date: 2023-12-20
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create all necessary parameters
# for a proper API call
# script start;
# 1) URLs and Endpoint; ####
krakenUrl <- function(
    futures = TRUE,
    ...) {

  # 1) define baseURL
  # for each API
  baseUrl <- base::ifelse(
    test = futures,
    yes  = 'https://futures.kraken.com',
    no   = 'https://api.kraken.com'
  )

  # 2) return the
  # baseURL
  baseUrl

}

krakenEndpoint <- function(
    type = 'ohlc',
    futures = TRUE,
    ...) {

  endPoint <- switch(
    EXPR = type,
    ohlc = {
      if (futures) 'api/charts/v1/' else
        '0/public/OHLC/'
    },
    ticker ={
      if (futures) 'derivatives/api/v3/instruments/' else
        '0/public/AssetPairs/'
    },
    # Was lsratio
    lsratio = {
      'api/charts/v1/analytics/'
    },
    interest = {
      'api/charts/v1/analytics/'
    }
  )

  # 2) return endPoint url
  endPoint

}

# 2) Available intervals; #####
krakenIntervals <- function(
    type,
    futures,
    interval,
    all = FALSE,
    ...) {

  # 0) construct intervals
  all_intervals <- switch(
    EXPR = type,
    'ohlc' = {
      if (futures) {
        # For futures, labels and values are the same
        data.frame(
          labels = c("1m", "5m", "15m", "30m", "1h", "4h", "12h", "1d", "1w"),
          values = c("1m", "5m", "15m", "30m", "1h", "4h", "12h", "1d", "1w")
        )
      } else {
        # For non-futures, labels and values are different
        data.frame(
          labels = c("1m", "5m", "15m", "30m", "1h", "4h", "1d", "1w", "2w"),
          values = c(1   ,5   ,15   ,30    ,60   ,240 , 1440,10080,21600)
        )
      }
    },
    data.frame(
      labels = c("1m", "5m", "15m", "30m", "1h", "4h", "12h", "2d", "8d"),
      values = c(60, 300, 900, 1800, 3600, 14400, 43200, 86400, 604800)
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
krakenResponse <- function(
    type = 'ohlc',
    futures,
    ...) {

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
    ohlc = {
      ohlc_structure(
        volume_loc = if (!futures) 7 else 6
      )
    },
    ticker = {
      list(
        foo = function(response, futures) {

          if (futures) {

            subset(
              response$instruments,
              response$instruments$tradeable == 'TRUE'
            )$symbol

          } else {

            names(
              lapply(
                response$result,
                function(x) {
                  if (x$status == 'online'){
                    x$altname
                  }
                }
              )
            )
          }

        }
      )

    },

    lsratio = {
      list(
        colum_names     = c('long', 'short'),
        index_location = c(1),
        colum_location = c(4,5)
      )
    },

    interest = {
      list(
        colum_names     = c('open', 'high', 'low', "close"),
        index_location = c(1),
        colum_location = c(2,3,4,5)
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
    ...) {


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
        no  = 1
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
    ...) {

  # Set common parameters
  params <- list(
    ticker = ticker,
    interval = krakenIntervals(
      interval = interval,
      futures = futures,
      type    = type
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
        since    = date_params[1],
        to       =  date_params[2]
      )
      params$path <- list(
        symbol    = params$symbol,
        tick_type = "open-interest"
      )
    },
    ohlc = {
      # Set specific parameters for futures or non-futures
      if (futures) {
        params$symbol <- params$ticker
        params$resolution <- params$interval
        params$query <-  list(
          interval = params$interval,
          from     = date_params[1],
          to       = date_params[2]
        )
        params$path <- list(
          tick_type  = 'trade',
          symbol     = params$symbol,
          resolution = params$resolution
        )
      } else {

        params$pair <- params$ticker
        params$query <- list(
          since    = date_params[1],
          to       = date_params[2],
          pair     = params$pair,
          interval = params$interval
        )
        params$path <-  NULL
      }



    },
    lsratio = {
      params$symbol <- params$ticker
      params$resolution <- params$interval
      params$query <- list(
        interval = params$interval,
        since    = date_params[1],
        to       =  date_params[2]
      )
      params$path <-  list(
        symbol = params$symbol,
        tick_type = 'long-short-info'
      )
    }
  )

  # Common parameters for both futures and non-futures
  params$futures <-  futures
  params$source <-  'kraken'

  # Return the structured list
  params
}

# script end;
