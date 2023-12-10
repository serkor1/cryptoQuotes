#' Get a quote on a cryptopair from one
#' of the major exchanges
#'
#' This function returns a crypto quote from
#' one of the available exchanges. The function supports
#' futues and spot markets
#'
#' @param ticker A character vector of length 1. Uppercase.
#' @param source A character vector of length 1. See [availableExchanges()] for a full list of available exchanges.
#' @param interval A character vector of length 1. See [availableIntervals()] for a full list.
#' @param futures A logical value. TRUE by default. If FALSE, the function will return spot prices.
#' @param from A character vector of length 1. Given in %Y-%m-%d format.
#' @param to A character vector of length 1. Given in %Y-%m-%d format.
#'
#' @example man/examples/scr_getQuote.R
#'
#' @returns an xts object with Open, High, Low, Close and Volume.
#'
#' @export

getQuote <- function(
    ticker,
    source = 'binance',
    futures = TRUE,
    interval,
    from = NULL,
    to = NULL
) {
  # This function returns
  # the ticker with the desired intervals
  # and such

  # 0) check internet connection
  # before anything
  if (!curl::has_internet()) {

    rlang::abort(
      message = 'You are currently not connected to the internet. Try again later.',

      # disable traceback, on this error.
      trace = rlang::trace_back()
    )

  }

  # 1) check if chosen exchange
  # is supported
  if (!(tolower(trimws(source)) %in% suppressMessages(availableExchanges()))) {

    rlang::abort(
      message = c(
        paste(source, 'is not supported.'),
        'i' = paste(
          paste(
            suppressMessages(
              availableExchanges()
            ),
            collapse = ', '
          ),
          'is supported'
        )
      )
    )

  }




  # 2) fetch and format
  # the quote and return
  formatQuote(
    fetchQuote(
      source = source,
      futures = futures,
      interval = interval,
      ticker = ticker,
      from = from,
      to   = to
    ),
    source = source,
    futures = futures,
    interval = interval,
    ticker = ticker
  )


}



