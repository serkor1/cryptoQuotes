# script: Funding Rate
# date: 2024-03-01
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Write a function
# to get the funding rate from
# exchanges that supports it
# script start;
#' @title
#' Get the funding rate on futures contracts
#'
#' @description
#' `r lifecycle::badge("stable")`
#'
#' Get the funding rate on a cryptocurrency pair from
#' the [available_exchanges()] in any actively
#' traded [available_tickers()] on the futures markets.
#'
#' @usage get_fundingrate(
#'  ticker,
#'  source   = 'binance',
#'  from     = NULL,
#'  to       = NULL
#' )
#'
#' @inheritParams get_quote
#'
#' @returns An <[\link[xts]{xts}]>-object containing,
#'
#' \item{index}{<[POSIXct]> the time-index}
#' \item{funding_rate}{<[numeric]> the current funding rate}
#'
#' **Sample output**
#' ```{r output, echo = FALSE}
#' ## funding rate
#' tail(
#'    cryptoQuotes:::control_data$fundingrate
#' )
#' ```
#'
#' @example man/examples/scr_getFundingrate.R
#'
#' @family get-functions
#' @author Serkan Korkmaz
#' @export
get_fundingrate <- function(
    ticker,
    source = "binance",
    from = NULL,
    to   = NULL){

  # 0) check internet connection
  check_internet_connection()

  # 1) assert argument
  # values
  assert(
    "
    Argument {.arg ticker} is missing with no default
    " =  !missing(ticker) & is.character(ticker) & length(ticker) == 1,

    "
    Argument {.arg source} has to be {.cls character} of length {1}
    " = (is.character(source) & length(source) == 1),

    "
    Valid {.arg from} input is on the form
    {.val {paste(as.character(Sys.Date()))}} or
    {.val {as.character(format(Sys.time()))}}
    " = (is.null(from) || (is.date(from) & length(from) == 1)),

    "
    Valid {.arg to} input is on the form
    {.val {paste(as.character(Sys.Date()))}} or
    {.val {as.character(format(Sys.time()))}}
    " = (is.null(to) || (is.date(to) & length(to) == 1))
  )

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
      # NOTE to self:
      # it seems that all exchanges uses
      # 8 hours.
      interval = "8h",
      from     = from,
      to       = to,
      length   = 101
    )

    # generate from
    # to variables
    from <- forced_dates$from
    to   <- forced_dates$to

  }

  stats::window(
    x = fetch(
      ticker   = ticker,
      source   = source,
      futures  = TRUE,
      interval = '1d',
      type     = "fundingrate",
      to       = to,
      from     = from
    ),
    start = from,
    end   = to
  )

}

# script end;
