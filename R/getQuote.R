#' getQuote
#'
#'
#' This function returns
#' a crypto quote
#'
#'
#' @param ticker A character vector of length 1. Has to be denominated in some currency
#' @param source A character vector of length 1, of the specific
#' @param interval A character vector of length 1, of desired intervals.
#'
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

  # 1) check if the chosen
  # interval is valid
  check_interval(
    interval = interval
  )

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
    )
  )


}
