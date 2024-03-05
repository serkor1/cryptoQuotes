#' Get available intervals
#'
#' @description
#' `r lifecycle::badge("stable")`
#'
#' Get available intervals for the [available_tickers()] on the [available_exchanges()].
#'
#' @inheritParams get_quote
#' @inheritParams available_exchanges
#'
#' @inherit available_exchanges
#'
#' @example man/examples/scr_availableIntervals.R
#'
#' @returns
#'
#' An [invisible()] [character] vector containing the  available intervals on
#' the exchange, market and endpoint
#'
#' @author Serkan Korkmaz
#'
#' @family supported calls
#'
#' @export
available_intervals <- function(
    source = 'binance',
    type   = 'ohlc',
    futures = TRUE) {

  # 0) extract available
  # intervals
  all_intervals <- get(paste0(source, 'Intervals'))(
    type   = type,
    futures = futures,
    all = TRUE,
    interval = NULL
  )

  # 1) return a message
  # with  available
  # intervals by exchange and market
  cli::cli_inform(
    message = c(
      'i' = paste0('Available Intervals at ', "{.val {source}}", ifelse(futures, ' (futures):', no = ' (spot):')),
      'v' = paste(
        all_intervals,
        collapse = ', '
      )
    )
  )

  invisible(
    all_intervals
  )

}

