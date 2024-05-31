# script: availableExchanges
# date: 2023-10-04
# author: Serkan Korkmaz, serkor1@duck.com
# objective: generate ta function that lists the available
# exchanges in library
# script start;

#' @title
#' Get available exchanges
#'
#' @description
#' `r lifecycle::badge("stable")`
#'
#' Get a [vector] of all available exchanges passed into the `source`
#' argument of the get-functions.
#'
#' @usage
#' available_exchanges(
#'    type = "ohlc"
#' )
#'
#' @param type [character]-vector of [length] 1. One of,
#'  * \code{"ohlc"} - Available exchanges for Open, High, Low, Close and
#'  Volume market data. See the [get_quote()]-function.
#'  * \code{"lsratio"} - Available exchanges for Long-Short ratios.
#'  See the [get_lsratio()]-function.
#'  * \code{"fundingrate"} - Available exchanges for Funding rates.
#'  See the [get_fundingrate()]-function.
#'  * \code{"interest"} - Available exchanges for Open interest on perpetual
#'  contracts on both sides. See the [get_openinterest()]-function.
#'
#' @returns
#' An [invisible()] [character]-vector containing available exchanges
#'
#' @details
#' The endpoints supported by the [available_exchanges()] are not uniform,
#' so exchanges available for, say, [get_lsratio()] is not necessarily
#' the same as those available for [get_quote()]
#'
#' @example man/examples/scr_availableExchanges.R
#'
#' @family supported calls
#' @author Serkan Korkmaz
#' @export
available_exchanges <- function(
    type = "ohlc"){

  # 0) define available
  # exchanges
  assert(
    type %in% c("ohlc", "lsratio", "fundingrate", "interest"),
    error_message = c(
      "x" = sprintf(
        "{.arg type} {.val %s} is not available.",
        type
      ),
      "i" = sprintf(
        "Has to be one of %s",
        paste(
          paste0(
            "{.val ",
            c("ohlc", "lsratio", "fundingrate", "interest") ,"}"
          ),
          collapse = ", "
        )
      )
    )
  )

  exchanges <- sort(
    switch(
      type,
      ohlc        = c('binance', 'kucoin', 'kraken', 'bitmart', 'bybit'),
      fundingrate = c('binance', 'bybit', 'kucoin'),
      lsratio     = c('binance', 'bybit', 'kraken'),
      interest    = c('binance', 'bybit', 'kraken')
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
