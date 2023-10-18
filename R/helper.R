# script: helpr
# date: 2023-09-22
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A class of helper
# function
# script start;



constructInterval <- function(source, futures, interval) {

  # 1) construct the interval
  interval <- get(
    paste0(source, 'Intervals')
  )(
    futures = futures,
    interval = interval
  )

  # 2) return the interval
  return(
    interval
  )

}



# check_interval <- function(
#     interval
# ) {
#
#   indicator <- grepl(
#     pattern = paste0(
#       collapse = '|',
#       available_intervals()
#     ),
#     x = interval
#   )
#
#   if (!indicator) {
#
#     rlang::abort(
#       message = paste0('Chosen interval: "', interval, '" is not available.'),
#       body = 'Use availableIntervals()-function to see a full list.',
#       call = NULL
#     )
#
#   }
#
#
# }




convert_date <- function(
  input
  ) {

  # Was:
  # format(
  #   as.numeric(
  #     as.POSIXct(to,tz = 'UTC'
  #     )
  #   ) * 1e3,
  #   cientific = FALSE
  # )

  as.POSIXct(
    as.numeric(input)/1e3,
    origin = '1970-01-01'
    )



}


# generate data;
# this data is for the purpose of presenting
# and error-testing
generate_data <- function(exchanges = c('binance', 'kucoin')) {

  markets <- c(
    'spot', 'futures'
  )

  # NOTE: Had do.call(rbind

  temp <- lapply(
    seq_along(exchanges),
    function(x) {

      if (x == 1) {

        # Binance
        ticker <- c('ATOMUSDT', 'ATOMUSDT')

      }

      if (x == 2) {

        ticker <- c('ATOM-USDT', 'ATOMUSDTM')

      }


      # for each exchange
      # we collect futures
      # and spot markets
      temp <- lapply(
        seq_along(markets),
        function(y) {

          Sys.sleep(2)

          # Collect data
          quote <- getQuote(
            ticker   = ticker[y],
            source   = exchanges[x],
            futures  = ifelse(markets[y] == 'futures', TRUE, FALSE),
            interval = '15m',
            from     = '2023-10-01',
            to       = '2023-10-02'
          )

          # quote$exchange <-  x
          # quote$market   <-  y - 1


          return(
            quote
          )


        }
      )

      names(temp) <- ticker

      return(temp)

    }
  )

  names(temp) <- exchanges


  return(
    temp
  )






}

# internalTest <- generate_data()
# usethis::use_data(
#   internalTest,
#   internal = TRUE,
#   overwrite = TRUE
#
# )


convertIndicator <- function(indicator) {

  # 1) convert indicator
  # list.wise
  indicator <- as.list(
    indicator
  )

  # 2) extract names
  # from the list
  indicator_names <- names(
    indicator
  )

  # 3) convert the
  # list to a long
  # data.frame
  indicator <- do.call(
    rbind,
    lapply(
      X = seq_along(indicator_names),
      FUN = function(i) {

        # 1) store the values
        # in a variable
        x <- indicator[[i]]

        # 2) set column name
        # to value
        colnames(x) <- 'value'

        # 3) convert to
        # data.frame
        x <- toDF(
          x
        )

        # 4) add label
        # to the data
        x$label <- indicator_names[i]

        return(
          x
        )

      }

    )
  )



  return(
    indicator
  )

}


toDF <- function(quote) {

  # this function converts
  # the quote to a data.frame
  # for the plotting and reshaping

  attr_list <- attributes(quote)$tickerInfo
  # 2) convert to
  # data.frame
  DF <- as.data.frame(
    zoo::coredata(quote),
    row.names = NULL
  )

  # 3) add the index;
  DF$Index <- zoo::index(
    quote
  )

  # 1) determine
  # wether the the day is closed
  # green
  try(
    DF$direction <- ifelse(
      test = DF$Close > DF$Open,
      yes  = 'Increasing',
      no   = 'Decreasing'
    )
  )

  attributes(DF)$tickerInfo <- attr_list

  return(
    DF
  )

}



toQuote <- function(DF) {

  quote <- xts::as.xts(DF[,c('Open','High', 'Low', 'Close', 'Volume', 'Index')])
  zoo::index(quote) <- as.POSIXct(DF$Index)

  attributes(quote)$tickerInfo <- attributes(DF)$tickerInfo
  return(
    quote
  )
}





# script end;
