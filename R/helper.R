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





# script end;
