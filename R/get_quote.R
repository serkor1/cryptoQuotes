#' @title
#' Get the Open, High, Low, Close and Volume data on a cryptocurrency pair
#'
#' @description
#' `r lifecycle::badge("stable")`
#'
#' Get a quote on a cryptocurrency pair from the [available_exchanges()] in
#' various [available_intervals()] for any
#' actively traded [available_tickers()].
#'
#' @usage get_quote(
#'  ticker,
#'  source   = 'binance',
#'  futures  = TRUE,
#'  interval = '1d',
#'  from     = NULL,
#'  to       = NULL
#' )
#'
#' @param ticker A [character]-vector of [length] 1.
#' See [available_tickers()] for available tickers.
#' @param source A [character]-vector of [length] 1. \code{binance} by default.
#' See [available_exchanges()] for available exchanges.
#' @param interval A [character]-vector of [length] 1. ```1d``` by default.
#' See [available_intervals()] for available intervals.
#' @param futures A [logical]-vector of [length] 1. [TRUE] by default.
#' Returns futures market if [TRUE], spot market otherwise.
#' @param from An optional [character]-, [date]- or
#' [POSIXct]-vector of [length] 1. [NULL] by default.
#' @param to An optional [character]-, [date]- or
#' [POSIXct]-vector of [length] 1. [NULL] by default.
#'
#' @returns An [xts]-object containing,
#'
#' \item{index}{<[POSIXct]> The time-index}
#' \item{open}{<[numeric]> Opening price}
#' \item{high}{<[numeric]> Highest price}
#' \item{low}{<[numeric]> Lowest price}
#' \item{close}{<[numeric]> Closing price}
#' \item{volume}{<[numeric]> Trading volume}
#'
#' **Sample output**
#' ```{r output, echo = FALSE}
#' ## Get daily quote
#' tail(
#'    cryptoQuotes:::control_data$quote
#' )
#' ```
#'
#' @details
#'
#' ## On time-zones and dates
#' Values passed to ``from`` or ``to`` must be coercible by [as.Date()],
#' or [as.POSIXct()], with a format of either ```"%Y-%m-%d"``` or
#' ```"%Y-%m-%d %H:%M:%S"```. By default all dates are passed and
#' returned with [Sys.timezone()].
#'
#' ## On returns
#' If only ``from`` is provided 200 pips are returned up to ``Sys.time()``.
#' If only ``to`` is provided 200 pips up to the specified date is returned.
#'
#' @example man/examples/scr_getQuote.R
#'
#' @family get-functions
#' @author Serkan Korkmaz
#' @export
get_quote <- function(
    ticker,
    source    = 'binance',
    futures   = TRUE,
    interval  = '1d',
    from      = NULL,
    to        = NULL) {
  # This function returns
  # the ticker with the desired intervals
  # and such

  # 0) check internet connection and passed
  # argumnents before anything
  check_internet_connection()

  # 1) check all arguments
  # what are missing, and are
  # the classes correct?
  {{

    assert(
      "
      Argument {.arg ticker} is missing with no default
      " =  !missing(ticker) & is.character(ticker) & length(ticker) == 1,

      "
      Argument {.arg source} has to be {.cls character} of length {1}
      " = (is.character(source) & length(source) == 1),

      "
      Argument {.arg futures} has to be {.cls logical} of length {1}
      " = (is.logical(futures) & length(futures) == 1),

      "
      Argument {.arg interval} has to be {.cls character} of length {1}
      " = (is.character(interval) & length(interval) == 1),

      "
      Valid {.arg from} input is on the form
      {.val {paste(as.character(Sys.Date()))}} or
      {.val {as.character(format(Sys.time()))}}
      " = (is.null(from) || (is.date(from) & length(from) == 1)),

      "Valid {.arg to} input is on the form
      {.val {paste(as.character(Sys.Date()))}} or
      {.val {as.character(format(Sys.time()))}}
      " = (is.null(to) || (is.date(to) & length(to) == 1))
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
        futures = futures,
        type    = 'ohlc'
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
          code = sprintf(
            "cryptoQuotes::available_intervals(
               source = '%s',
               type = 'ohlc,
               futures = '%s'
            )",
            source,
            futures
            ),
          code_theme = "Chaos"
        ),
        "for supported intervals"
      )
    )
  )

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
      limit    = switch(
        EXPR = source,
        'bitmart' = {
          if (futures) NULL else 200
        },
        NULL
      )
    )

    # generate from
    # to variables
    from <- forced_dates$from
    to   <- forced_dates$to

  }

  ohlc <- fetch(
    ticker = ticker,
    source = source,
    futures= futures,
    interval = interval,
    type   = "ohlc",
    to     = to,
    from   = from
  )[paste(c(from, to), collapse = "/")]

  # Kraken doesnt have a to
  # parameter on spot market
  if (source == "kraken") {

    ohlc <- ohlc[paste(c(from, to), collapse = "/")]

  }

  attributes(ohlc)$source <- paste0(
    to_title(source), if (futures) " (PERPETUALS)" else " (SPOT)"
  )

  ohlc
}

# script end;
