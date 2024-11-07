#' @title
#' Get available intervals
#'
#' @description
#' `r lifecycle::badge("stable")`
#'
#' Get available intervals for the [available_tickers()]
#' on the [available_exchanges()].
#'
#' @usage available_intervals(
#'    source = "binance",
#'    type   = "ohlc",
#'    futures = TRUE
#' )
#'
#' @inheritParams get_quote
#' @inheritParams available_exchanges
#'
#' @inherit available_exchanges
#'
#'
#' @returns
#'
#' An [invisible()] [character]-vector containing the  available intervals on
#' the exchange, market and endpoint.
#'
#' **Sample output**
#'
#' ```{r output, echo = FALSE}
#' head(
#'    cryptoQuotes::available_intervals(
#'      source = "bybit"
#'    )
#' )
#' ```
#' @example man/examples/scr_availableIntervals.R
#'
#' @family supported calls
#' @author Serkan Korkmaz
#' @export
available_intervals <- function(
    source = 'binance',
    type   = 'ohlc',
    futures = TRUE) {

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
          paste0("{.val ",
                 c("ohlc", "lsratio", "fundingrate", "interest")
                 ,"}"
          ),
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
    type     = type,
    futures  = futures,
    all      = TRUE,
    interval = NULL
  )

  # 1) return a message
  # with  available
  # intervals by exchange and market
  cli::cli_inform(
    message = c(
      'i' = paste0(
        'Available Intervals at ',
        "{.val {source}}",
        ifelse(futures, ' (futures):', no = ' (spot):')
      ),
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

