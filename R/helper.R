# script: helpr
# date: 2023-09-22
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A class of helper
# function
# script start;

# generate data;
# this data is for the purpose of presenting
# and error-testing
generate_data <- function(
    exchanges = c(
      'binance',
      'kucoin'
      # ,
      # 'kraken',
      # 'bitmart'
      )
    ) {

  markets <- c(
    'spot', 'futures'
  )

  # NOTE: Had do.call(rbind

  temp <- lapply(
    seq_along(exchanges),
    function(x) {

      # determine tickers:
      # First is SPOT, second is FUTURES
      if (x == 1) {

        # Binance
        ticker <- c('ATOMUSDT', 'ATOMUSDT')

      }

      if (x == 2) {

        ticker <- c('ATOM-USDT', 'ATOMUSDTM')

      }

      # if (x == 3) {
      #
      #   ticker <- c('ATOMUSDT', 'PF_ATOMUSD')
      #
      # }

      # if (x == 4) {
      #
      #   ticker <- c('ATOM_USDT', 'ATOMUSDT')
      #
      # }


      # for each exchange
      # we collect futures
      # and spot markets
      temp <- lapply(
        seq_along(markets),
        function(y) {

          message(
            paste(
              'ticker:', ticker[y], 'market:', markets[y], 'exchange:', exchanges[x])
          )
          Sys.sleep(2)



          # Collect data
          quote <- getQuote(
            ticker   = ticker[y],
            source   = exchanges[x],
            futures  = ifelse(markets[y] == 'futures', TRUE, FALSE),
            interval = '15m',
            from     = '2023-11-25',
            to       = '2023-11-28'
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
  if (all(c('Open', 'Close') %in% colnames(DF))) {

    DF$direction <- ifelse(
      test = DF$Close > DF$Open,
      yes  = 'Increasing',
      no   = 'Decreasing'
    )

  }


  attributes(DF)$tickerInfo <- attr_list

  return(
    DF
  )

}


toQuote <- function(DF) {

  quote <- xts::as.xts(
    DF[,c('Open','High', 'Low', 'Close', 'Volume', 'Index')]
    )

  zoo::index(quote) <- as.POSIXct(
    DF$Index
    )

  attributes(quote)$tickerInfo <- attributes(DF)$tickerInfo

  return(
    quote
  )
}


vline <- function(
    x = 0,
    col = 'steelblue'
) {

  list(
    type = "line",
    y0 = 0,
    y1 = 1,
    yref = "paper",
    x0 = x,
    x1 = x,
    line = list(
      color = col,
      dash="dot"
    )
  )

}




annotations <- function(
    x = 0,
    text = 'text'
) {

  list(
    x = x,
    y = 1,
    text = text,
    showarrow = FALSE,
    #xref = 'paper',
    yref = 'paper',
    xanchor = 'right',
    yanchor = 'auto',
    xshift = 0,
    textangle = -90,
    yshift = 0,
    font = list(
      size = 15,
      color = "black",
      angle = '90'
    )
  )


}



# check for http errors;
check_for_errors <- function(
    response,
    call = rlang::caller_env(n = 3)
) {

  # 1) check for error;
  #
  # If an error code is thrown
  # or the response includes
  # an empty list.
  #
  # Not all failed API calls returns
  # a propoer code.
  error_condition <- httr::http_error(response)

  # 1.1) convert content
  # and check its content if
  # the returns a list
  check_content <- jsonlite::fromJSON(
    txt = httr::content(
      response,
      encoding = 'UTF-8',
      as = 'text'
    )
  )

  if (inherits(check_content, 'list')) {

    no_data_returned <- all(
      sapply(
        X = jsonlite::fromJSON(
          txt = httr::content(
            response,
            encoding = 'UTF-8',
            as = 'text'
          )
        ),
        FUN = function(x) {
          (
            inherits(x = x, what = 'character') | !length(x)
          )


        }
      )
    )

    error_condition <- error_condition | no_data_returned

  }

  if (error_condition) {

    # 2) abort remaining
    # operations and paste
    # the error message
    error_message <- jsonlite::fromJSON(
      txt = httr::content(
        response,
        encoding = 'UTF-8',
        as = 'text'
      )
    )

    # 2.1) check for empty
    # content in the error messages
    # this is relevant for REST APIs like
    # KuCoin Futures.
    idx <- sapply(error_message, function(x){!length(x)})
    error_message[idx] <- 'No sensible error information.'

    # 2.2) extract a the error
    # message.
    #
    # NOTE: its not possible to
    # use, say, ['msg'] as the container
    # for each API varies. So this shotgun approach
    # is somewhat sensible
    rlang::abort(
      message = paste(
        error_message[[2]]
      ),
      call = call
    )


  }

}


# script end;
