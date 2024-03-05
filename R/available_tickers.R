#' Get available cryptocurrency pairs
#'
#' @description
#' `r lifecycle::badge("stable")`
#'
#' Get available cryptocurrency pairs
#'
#' @inheritParams get_quote
#'
#' @example man/examples/scr_availableTickers.R
#'
#' @returns
#'
#' A [character]-vector of actively traded cryptocurrency pairs on the exchange, and the specified market.
#'
#' @details
#'
#' The naming-conventions across, and within, [available_exchanges()] are not necessarily the same. This function lists
#' all actively traded tickers.
#'
#' @author Serkan Korkmaz
#'
#' @family supported calls
#'
#' @export
available_tickers <- function(
    source  = 'binance',
    futures = TRUE) {

  # 0) Assert truthfulness
  # and validity of all inputs
  assert(
    "Argument {.arg source} has to be {.cls character} of length {1}" = (is.character(source) & length(source) == 1),
    "Argument {.arg futures} has to be {.cls logical} of length {1}" = (is.logical(futures) & length(futures) == 1)
  )

  assert(
    source %in% suppressMessages(
      available_exchanges(
        type = 'ohlc'
      )
    )
  )

  # 1) make GET-request
  # to ticker-information
  response <- GET(
    url = baseUrl(
      source = source,
      futures = futures
    ),
    endpoint = endPoint(
      source = source,
      futures = futures,
      type = 'ticker'
    )
  )


  # 2) get source_response
  # objects
  source_response <- get(
    paste0(
      source, 'Response'
    )
  )(
    type = 'ticker',
    futures = futures
  )

  ticker <- sort(
    source_response$foo(
      response = response,
      futures  = futures
    )
  )

  ticker

}

# script end;
