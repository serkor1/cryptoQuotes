#' Get a quote on a cryptopair from one
#' of the supported exchanges
#'
#' @description
#'
#' Open, High, Low, Close, and Volume (OHLCV) quotes are essential pieces of
#' information used to analyze the price and trading activity of a financial asset over a specific time frame.
#'
#'
#'
#' @param ticker A character vector of length 1. Uppercase. See [availableTickers()] for available tickers.
#' @param source A character vector of length 1. See [availableExchanges()] for available exchanges.
#' @param interval A character vector of length 1. See [availableIntervals()] for available intervals.
#' @param futures A logical value. Returns futures market if [TRUE], spot market otherwise.
#' @param from An optional vector of length 1. Can be [Sys.Date()]-class, [Sys.time()]-class or [as.character()] in %Y-%m-%d format.
#' @param to An optional vector of length 1. Can be [Sys.Date()]-class, [Sys.time()]-class or [as.character()] in %Y-%m-%d format.
#'
#' @usage getQuote(
#'  ticker,
#'  source   = 'binance',
#'  futures  = TRUE,
#'  interval = '1d',
#'  from     = NULL,
#'  to       = NULL
#' )
#'
#' @example man/examples/scr_getQuote.R
#'
#' @returns an xts object with Open, High, Low, Close and Volume. If ```futures = TRUE``` the prices are last prices.
#'
#' @details
#'
#' If only ``from`` is provided 100 pips are returned up to ``Sys.time()``.
#'
#' If only ``to`` is provided 100 pips up to the specified date
#' is returned.
#'
#' If ``from`` and ``to`` are both [NULL] 100 pips returned up to ``Sys.time()``
#'
#'
#' @export

getQuote <- function(
    ticker,
    source    = 'binance',
    futures   = TRUE,
    interval  = '1d',
    from      = NULL,
    to        = NULL
) {
  # This function returns
  # the ticker with the desired intervals
  # and such

  # 0) check internet connection
  # before anything
  check_internet_connection()

  # pass dates through
  # the validator
  valid_dates <- date_validator(
    from = from,
    to   = to
  )

  from <- valid_dates$from
  to   <- valid_dates$to

  # recode the exchange
  # source to avoid errors
  # based on capitalization
  # and whitespace
  source <- tolower(
    trimws(source)
  )

  # 1) check wether
  # the chosen exchange
  # is supported by the library
  check_exchange_validity(
    source = source
  )

  # 2) check wether the
  # interval is supported by
  # the exchange API
  check_interval_validity(
    interval = interval,
    source   = source,
    futures  = futures
  )

  # 3) if either of the
  # date variables are NULL
  # pass them into the default_dates
  # function to extract 100 pips.
  if (is.null(from) | is.null(to)) {

    # to ensure consistency across
    # APIs if no date is set the output
    # is limited to 100 pips
    forced_dates <- default_dates(
      interval = interval,
      from     = from,
      to       = to
    )

    # generate from
    # to variables
    from <- forced_dates$from
    to   <- forced_dates$to


  }

  # 3) fetch and format
  # the quote and return
  quote_response(
    response = api_call(
      source   = source,
      type     = 'ohlc',
      parameters = source_parameters(
        type    = 'ohlc',
        source  = source,
        futures = futures,
        ticker  = ticker,
        interval= interval,
        from    = from,
        to      = to
      )
    )
  )

}

# script end;
