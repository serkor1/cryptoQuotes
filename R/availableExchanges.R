# script: availableExchanges
# date: 2023-10-04
# author: Serkan Korkmaz, serkor1@duck.com
# objective: generate ta function that lists the available
# exchanges in library
# script start;

#' availableExchanges
#'
#' This function returns all
#' available exchanges
#'
#' @export
availableExchanges <- function(){

  # 1) retun a message
  # with all the available
  # exchanges
  rlang::inform(
    message = c(
      'i' = c('Available exchanges'),
      'v' = paste(c('binance', 'kucoin', 'kraken'), collapse = ', ')

    )
  )

}


# script end;
