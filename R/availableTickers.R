#' Get available cryptocurrency pairs
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' This function returns all available
#' cryptocurrewncy pairs on the [available_exchanges]
#'
#' @inherit available_tickers
#' @family deprecated
#'
#' @export
availableTickers <- function(
    source  = 'binance',
    futures = TRUE) {

  lifecycle::deprecate_soft(
    when = '1.3.0',
    what = "availableTickers()",
    with = "available_tickers()"
  )

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
