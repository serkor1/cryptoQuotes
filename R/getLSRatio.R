# script: Long-Short Ratioes
# date: 2024/01/05
# Author: Jonas Cuzulan Hirani
# objective: Extract the Long-Short Ratios
# from the exchanges
#' Get long-short ratios for tickers
#'
#' @description
#' The long-short ratio is a market sentiment indicator on expected price movement
#'
#' @param ticker A character vector of length 1. Uppercase. See [availableTickers()] for available tickers.
#' @param from An optional vector of length 1. Can be [Sys.Date()]-class, [Sys.time()]-class or [as.character()] in %Y-%m-%d format.
#' @param to An optional vector of length 1. Can be [Sys.Date()]-class, [Sys.time()]-class or [as.character()] in %Y-%m-%d format.
#' @param interval A character vector of length 1. See [availableIntervals()] for available intervals.
#'
#' @details
#' Note! This endpoint only supports intervals between 5 minutes and 1 day.
#'
#'
#' @author Jonas Cuzulan Hirani
#'
#' @example man/examples/scr_LSR.R
#' @family sentiment
#' @returns A xts object with the share of long and short position, and the ratio of the two. If no from and to are supplied
#' the 100 most recent pips are returned.
#'
#' @export
getLSRatio <- function(
    ticker,
    interval = '1d',
    from     = NULL,
    to       = NULL
) {

  # 1) check internet
  # connection and interval validity
  check_internet_connection()

  if (!(interval %in% available_interval_ls)){

    rlang::abort(
      message = c(
        "Chosen interval is not supported in Long-Short Ratios",
        "v" = paste(
          available_interval_ls,
          collapse = ', '
        )
      )
    )

  }

  # 2) construct dates
  # with API constraints;
  #
  # If no dates are specified
  # it will return the last
  # 100 available pips
  # closest to Sys.time()
  dates <- date_validator(
    from = if (is.null(from)){Sys.Date() - 30} else {max(Sys.Date() - 30, from)},
    to   = if (is.null(to)){Sys.time()} else {to}
  )

  # 3) construct
  # the baseUrl and endPoints
  # accordingly
  baseurl <- baseUrl(
    source  = 'binance',
    futures = TRUE
  )

  endpoint <- endPoint(
    source = 'binance',
    type   = 'lsratio'
  )

  # 4) make the API call;
  # using existing infrastructure
  response_ <- api_call(
    source = 'binance',
    type   = 'lsratio',
    parameters = source_parameters(
      source   = 'binance',
      futures  = TRUE,
      type     = 'lsratio',
      ticker   = ticker,
      interval = interval,
      from     = dates$from,
      to       = dates$to
    )
  )

  # 5.1) the response is named
  # json list, and the data
  # of interst is stored
  # in data
  response <- httr2::resp_body_json(
    resp = response_$response,
    simplifyVector = TRUE
  )

  # 6) prepare the data;
  response$timestamp <- convertDate(
    date = as.numeric(response$timestamp),
    is_response = TRUE,
    multiplier = 1e3,
    power = -1
  )

  # 6.1) convert
  # to xts;
  response <- try(
    xts::as.xts(
      apply(response[, c(2:4)], c(1,2), as.numeric),
      order.by = response$timestamp
    ),
    silent = TRUE
  )

  if (inherits(response, 'try-error')){

    check_for_errors(
      response = response_$response,
      source = 'binance',
      futures = TRUE,
      call = rlang::caller_env(n = 0)
    )

  }


  colnames(response) <- c('Long', 'LSRatio', 'Short')
  response <- response[, c('Long', 'Short', 'LSRatio')]



  # return the
  # response
  return(
    response
  )

}

