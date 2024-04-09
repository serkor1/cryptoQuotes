# script: Long-Short Ratioes
# date: 2024/01/05
# Author: Jonas Cuzulan Hirani
# objective: Extract the Long-Short Ratios
# from the exchange

#' Get the long to short ratio of a cryptocurrency pair
#'
#' @description
#'
#' `r lifecycle::badge("stable")`
#'
#' Get the long-short ratio for any [available_tickers()] from the [available_exchanges()]
#'
#' @usage
#' ## long-short ratio
#' get_lsratio(
#'    ticker,
#'    interval = '1d',
#'    source   = 'binance',
#'    from     = NULL,
#'    to       = NULL,
#'    top      = FALSE
#' )
#'
#' @param ticker A [character] vector of [length] 1. See [available_tickers()] for available tickers.
#' @param interval A [character] vector of [length] 1. See [available_intervals()] for available intervals.
#' @param source A [character]-vector of [length] 1. See [available_exchanges()] for details.
#' @param from An optional vector of [length] 1. Can be [Sys.Date()]-class, [Sys.time()]-class or [as.character()] in %Y-%m-%d format.
#' @param to An optional vector of [length] 1. Can be [Sys.Date()]-class, [Sys.time()]-class or [as.character()] in %Y-%m-%d format.
#' @param top A [logical] vector. [FALSE] by default. If [TRUE] it returns the top traders Long-Short ratios.
#'
#' @inherit get_quote details
#'
#' @note
#'
#' ## Available exchanges
#'
#' See [available_exchanges()] with  for available exchanges.
#'
#' ## Limited return values
#'
#' Binance only supports data for the last 30 days. Use other exchanges if you need beyond that.
#'
#' @author Jonas Cuzulan Hirani
#'
#' @example man/examples/scr_LSR.R
#'
#' @family get-function
#'
#' @returns An [xts]-object containing,
#'
#' * long ([numeric]) - the share of longs
#' * short ([numeric]) - the share of shorts
#' * ls_ratio ([numeric]) - the ratio of longs to shorts
#'
#' @export
get_lsratio <- function(
    ticker,
    interval = '1d',
    source   = 'binance',
    from     = NULL,
    to       = NULL,
    top      = FALSE) {

  # 1) check internet
  # connection and interval validity
  check_internet_connection()

  # 1) check all arguments
  # what are missing, and are
  # the classes correct?
  {{

    assert(
      "Argument {.arg ticker} is missing with no default" =  !missing(ticker) & is.character(ticker) & length(ticker) == 1,
      "Argument {.arg source} has to be {.cls character} of length {1}" = (is.character(source) & length(source) == 1),
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
      available_exchanges(
        type = 'lsratio'
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
          code = "cryptoQuotes::available_exchanges(type = 'lsratio')",
          code_theme = "Chaos"
        ),
        "for supported exhanges"
      )
    )
  )

  assert(
    interval %in% suppressMessages(
      available_intervals(
        type = 'lsratio',
        source = source
      )
    ),
    error_message = c(
      "x" = sprintf(
        fmt = "Interval {.val %s} is not supported by {.val %s}.",
        interval,
        source
      ),
      "i" = paste(
        "Run",
        cli::code_highlight(
          code = "cryptoQuotes::available_intervals(type = 'interest', source = source)",
          code_theme = "Chaos"
        ),
        "for supported intervals"
      )
    )
  )

  # 2) construct dates
  # with API constraints;
  #
  # If no dates are specified
  # it will return the last
  # 100 available pips
  # closest to Sys.time()
  from <- coerce_date(from); to <- coerce_date(to)

  # 3) if either of the
  # date variables are NULL
  # pass them into the default_dates
  # function to extract 100 pips.
  if (is.null(from) | is.null(to)) {

    # to ensure consistency across
    # APIs if no date is set the output
    # is limited to 200 pips
    forced_dates <- default_dates(
      interval = interval,
      from     = from,
      to       = to,
      limit    = NULL
    )

    # generate from
    # to variables
    from <- forced_dates$from
    to   <- forced_dates$to

  }


  # NOTE: binance only supports
  # the last 30 days
  if (source %in% 'binance') {

    from <- max(
      from,
      as.POSIXct(
        coerce_date(
          Sys.Date() - 28
        ),
        tz = "UTC"
      )

    )

  }


  response <- fetch(
    ticker = ticker,
    source = source,
    futures= TRUE,
    interval = interval,
    type   = 'lsratio',
    to    = to,
    from  = from,
    top   = top
  )

  # Bybit has no to or from
  # parameter - so this have to be subsettet
  # manually
  if (source == "bybit") {

    response <- response[
      paste(c(from, to),collapse = "/")
      ]

  }

  # Calculate the long
  # short ratio as not
  # all APIs provides this by default
  response$ls_ratio <- response$long / response$short

  if (source == 'kraken') {

    response$long <- response$long/100
    response$short <- response$short/100

  }

  # return the
  # response
  response

}

