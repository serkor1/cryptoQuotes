# script: Open Interest
# date: 2024-03-01
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Write a function
# that fetches the open interest on Futures
# markets
# script start;

#' @title
#' Get the open interest on perpetual futures contracts
#'
#' @description
#' `r lifecycle::badge("stable")`
#'
#' Get the open interest on a cryptocurrency pair from the
#' [available_exchanges()] in any actively traded [available_tickers()]
#' on the FUTURES markets.
#'
#' @usage get_openinterest(
#'  ticker,
#'  interval = '1d',
#'  source   = 'binance',
#'  from     = NULL,
#'  to       = NULL
#' )
#'
#' @inheritParams get_quote
#'
#' @returns
#' An [xts]-object containing,
#'
#' \item{index}{<[POSIXct]> the time-index}
#' \item{open_interest}{<[numeric]> open perpetual contracts on both both sides}
#'
#' **Sample output**
#' ```{r output, echo = FALSE}
#' ## Open Interest
#' tail(
#'    cryptoQuotes:::control_data$openinterest
#' )
#' ```
#'
#' @inherit get_quote details
#'
#' @example man/examples/scr_getOpeninterest.R
#'
#' @family get-functions
#' @author Serkan Korkmaz
#' @export
get_openinterest <- function(
    ticker,
    interval = '1d',
    source   = 'binance',
    from     = NULL,
    to       = NULL) {

  # 0) check internet connection
  check_internet_connection()

  # 1) assert argument
  # inputs
  assert(
    "
    Argument {.arg ticker} is missing with no default
    " =  !missing(ticker) & is.character(ticker) & length(ticker) == 1,
    "
    Argument {.arg source} has to be {.cls character} of length {1}
    " = (is.character(source) & length(source) == 1),

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

  # 2) assert validity
  # of inputs
  assert(
    source %in% suppressMessages(
      available_exchanges(
        type = 'interest'
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
          code = "cryptoQuotes::available_exchanges(type = 'interest')",
          code_theme = "Chaos"
        ),
        "for supported exhanges"
      )
    )
  )

  assert(
    interval %in% suppressMessages(
      available_intervals(
        type = 'interest',
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
          code = "
          cryptoQuotes::available_intervals(type = 'interest', source = source)
          ",
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
      length   = 200
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
        tz = Sys.timezone()
      )
    )
  }

  output <- fetch(
    ticker = ticker,
    source = source,
    futures= TRUE,
    interval = interval,
    type   = "interest",
    to     = to,
    from   = from
  )

  if (source %in% 'kraken') {

    output <- output$high

    names(output)[1] <- "open_interest"

  }

  output

}


# script end;
