#' @title
#' Get actively traded cryptocurrency pairs
#'
#' @description
#' `r lifecycle::badge("stable")`
#'
#' Get actively traded cryptocurrency pairs on the [available_exchanges()].
#'
#' @inheritParams get_quote
#'
#' @returns
#' A [character]-vector of actively traded cryptocurrency pairs on the exchange,
#' and the specified market.
#'
#' **Sample output**
#' ```{r output, echo = FALSE}
#' head(
#'    cryptoQuotes::available_tickers(
#'      source  = "bybit",
#'      futures = TRUE
#'    )
#' )
#' ```
#'
#' @details
#' The naming-conventions across, and within, [available_exchanges()] are not
#' necessarily the same. This function lists all actively traded tickers.
#'
#' @example man/examples/scr_availableTickers.R
#'
#' @family supported calls
#' @author Serkan Korkmaz
#' @export
available_tickers <- function(
    source  = 'binance',
    futures = TRUE) {

  # 0) Assert truthfulness
  # and validity of all inputs
  assert(
    "Argument {.arg source} has to be {.cls character} of length {1}" =
      (is.character(source) & length(source) == 1),
    "Argument {.arg futures} has to be {.cls logical} of length {1}" =
      (is.logical(futures) & length(futures) == 1)
  )

  assert(
    source %in% suppressMessages(
      available_exchanges(
        type = 'ohlc'
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
