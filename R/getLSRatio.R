# script: Long-Short Ratioes
# date: 2024/01/05
# Author: Jonas Cuzulan Hirani
# objective: Extract the Long-Short Ratios
# from the exchanges

#' Get the long to short ratio of a cryptocurrency pair
#'
#' @description
#'
#' `r lifecycle::badge("deprecated")`
#'
#' Get the long-short ratio for any [available_tickers()] from the [available_exchanges()]
#'
#' @inherit get_lsratio
#' @family deprecated
#'
#' @export
getLSRatio <- function(
    ticker,
    interval = '1d',
    source   = 'binance',
    from     = NULL,
    to       = NULL,
    top      = FALSE) {

  # 1) check internet
  # connection and interval validity
  lifecycle::deprecate_soft(
    when = '1.3.0',
    what = "getLSRatio()",
    with = "get_lsratio()"
  )
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





  # 2) construct dates
  # with API constraints;
  #
  # If no dates are specified
  # it will return the last
  # 100 available pips
  # closest to Sys.time()
  from <- coerce_date(
    if (is.null(from)) Sys.Date() - 28 else max(Sys.Date() - 28, from)
  )

  to <- coerce_date(
    if (is.null(to)) Sys.time() else to
  )



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

  # # Calculate the long
  # # short ratio as not
  # # all APIs provides this by default
  response$ls_ratio <- response$long / response$short

  if (source == 'kraken') {

    response$long <- response$long/100
    response$short <- response$short/100

  }



  # return the
  # response
  response

}

