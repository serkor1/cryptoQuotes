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
          paste0("{.val ",c("ohlc", "lsratio", "fundingrate", "interest") ,"}"),
          collapse = ", "
        )
      )
    )
  )

  assert(
    source %in% suppressMessages(
      available_exchanges(
        type = type
      )
    ),
    error_message = c(
      "x" = sprintf(
        fmt = "Exchange {.val %s} is not supported.",
        source
      ),
      "i" = paste(
        "Run",
        cli::code_highlight(
          code = "cryptoQuotes::available_exchanges()",
          code_theme = "Chaos"
        ),
        "for supported exhanges"
      )
    )
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

