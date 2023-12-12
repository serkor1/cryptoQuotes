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
#'
#' @example man/examples/scr_availableExchanges.R
#'
#' @returns Invisbly returns a character vector.
#'
#' @export
availableExchanges <- function(){

  # 0) define available
  # exchanges
  exchanges <- c('binance', 'kucoin', 'kraken', 'bitmart')

  # 1) retun a message
  # with all the available
  # exchanges
  rlang::inform(
    message = c(
      'i' = c('Available exchanges'),
      'v' = paste(
        c('binance', 'kucoin', 'kraken', 'bitmart'),
        collapse = ', '
        )
    )
  )

  return(
    invisible(
      exchanges
    )
  )

}


# script end;
