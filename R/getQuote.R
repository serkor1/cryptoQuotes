#' Get the Open, High, Low, Close and Volume data on a cryptocurrency pair
#'
#' @description
#'
#' `r lifecycle::badge("deprecated")`
#'
#' Get a quote on a cryptocurrency pair from the [available_exchanges()] in various [available_intervals()] for any actively traded [available_tickers()].
#'
#' @usage
#' ## get OHLC-V
#' getQuote(
#'  ticker,
#'  source   = 'binance',
#'  futures  = TRUE,
#'  interval = '1d',
#'  from     = NULL,
#'  to       = NULL
#' )
#'
#' @inherit get_quote
#' @family deprecated
#'
#' @export

getQuote <- function(
    ticker,
    source    = 'binance',
    futures   = TRUE,
    interval  = '1d',
    from      = NULL,
    to        = NULL) {
  # This function returns
  # the ticker with the desired intervals
  # and such
  lifecycle::deprecate_soft(
    when = '1.3.0',
    what = "getQuote()",
    with = "get_quote()"
  )
  # 0) check internet connection
  # before anything
  check_internet_connection()



  # 1) check all arguments
  # what are missing, and are
  # the classes correct?
  {{

    assert(
      "Argument {.arg ticker} is missing with no default" =  !missing(ticker) & is.character(ticker) & length(ticker) == 1,
      "Argument {.arg source} has to be {.cls character} of length {1}" = (is.character(source) & length(source) == 1),
      "Argument {.arg futures} has to be {.cls logical} of length {1}" = (is.logical(futures) & length(futures) == 1),
      "Argument {.arg interval} has to be {.cls character} of length {1}" = (is.character(interval) & length(interval) == 1),
      "Valid {.arg from} input is on the form {.val {paste(as.character(Sys.Date()))}} or {.val {as.character(
              format(
                Sys.time()
              )
            )}}" = (is.null(from) || (is.date(from) & length(from) == 1)),

      "Valid {.arg to} input is on the form {.val {paste(as.character(Sys.Date()))}} or {.val {as.character(
              format(
                Sys.time()
              )
            )}}" = (is.null(to) || (is.date(to) & length(to) == 1))




    )

  }}

  # recode the exchange
  # source to avoid errors
  # based on capitalization
  # and whitespace
  source <- tolower(
    trimws(source)
  )
  ticker <- toupper(
    trimws(ticker)
  )

  # 1) check wether
  # the chosen exchange
  # is supported by the library
  assert(
    source %in% suppressMessages(
      available_exchanges()
    ),
    error_message = c(
      "x" = sprintf(
        fmt = "Exchange {.val %s} is not supported.",
        source
      ),
      "i" = paste(
        "Run",
        cli::code_highlight(
          code = "cryptoQuotes::available_exchanges(type = 'ohlc')",
          code_theme = "Chaos"
        ),
        "for supported exhanges"
      )
    )
  )

  # 2) check wether the
  # interval is supported by
  # the exchange API
  assert(
    interval %in% suppressMessages(
      available_intervals(
        source  = source,
        futures = futures
      )
    ),
    error_message = c(
      "x" = sprintf(
        fmt = "Interval {.val %s} is not supported.",
        interval
      ),
      "i" = paste(
        "Run",
        cli::code_highlight(
          code = sprintf("cryptoQuotes::available_intervals(source = '%s', futures = '%s')", source, futures),
          code_theme = "Chaos"
        ),
        "for supported intervals"
      )
    )
  )

  # 3) if either of the
  # date variables are NULL
  # pass them into the default_dates
  # function to extract 100 pips.

  from <- coerce_date(from); to <- coerce_date(to)
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
  fetch(
    ticker = ticker,
    source = source,
    futures= futures,
    interval = interval,
    type   = "ohlc",
    to     = to,
    from   = from
  )


}

# script end;
