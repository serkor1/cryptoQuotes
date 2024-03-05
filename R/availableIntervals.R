#' Get available intervals
#'
#' @description
#' `r lifecycle::badge("deprecated")`
#'
#' @inherit available_intervals
#' @family deprecated
#'
#' @export
availableIntervals <- function(
    source = 'binance',
    type   = 'ohlc',
    futures = TRUE) {

  lifecycle::deprecate_soft(
    when = '1.3.0',
    what = "availableIntervals()",
    with = "available_intervals()"
  )

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

