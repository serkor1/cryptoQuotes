# script: availableExchanges
# date: 2023-10-04
# author: Serkan Korkmaz, serkor1@duck.com
# objective: generate ta function that lists the available
# exchanges in library
# script start;

#' Get available exchanges
#'
#' This function returns all
#' available exchanges as a message in the console.
#' @example man/examples/scr_availableExchanges.R
#'
#' @returns NULL
#'
#' @export
availableExchanges <- function(){

  # 1) retun a message
  # with all the available
  # exchanges
  rlang::inform(
    message = c(
      'i' = c('Available exchanges'),
      'v' = paste(c('binance', 'kucoin', 'kraken', 'bitmart'), collapse = ', ')

    )
  )

}


# script end;
