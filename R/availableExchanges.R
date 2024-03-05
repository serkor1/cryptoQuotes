# script: availableExchanges
# date: 2023-10-04
# author: Serkan Korkmaz, serkor1@duck.com
# objective: generate ta function that lists the available
# exchanges in library
# script start;

#' Get available exchanges
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' Get a vector of all available exchanges passed into the source
#' argument of the get-functions.
#'
#' @inherit available_exchanges
#' @family deprecated
#'
#' @export
availableExchanges <- function(
    type = "ohlc"){

  lifecycle::deprecate_soft(
    when = '1.3.0',
    what = "availableExchanges()",
    with = "available_exchanges()"
  )
  # 0) define available
  # exchanges
  assert(
    type %in% c("ohlc", "lsratio", "fundingrate", "interest"),
    error_message = c(
      "x" = "Unsupported type",
      "i" = "Has to be one of XXX"
    )
  )

  exchanges <- sort(
    switch(
      type,
      ohlc        = c('binance', 'kucoin', 'kraken', 'bitmart', 'bybit'),
      fundingrate = c('binance', 'bybit', 'kucoin'),
      lsratio     = c('binance', 'bybit', 'kraken'),
      interest    = c('binance', 'bybit')
    )
  )

  # 1) retun a message
  # with all the available
  # exchanges
  cli::cli_inform(
    message = c(
      'i' = cli::style_underline('Available Exchanges:'),
      'v' = paste(
        exchanges,
        collapse = ', '
      )
    )
  )

  invisible(
    exchanges
  )

}


# script end;
