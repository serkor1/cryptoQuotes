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
#'
#' @param ticker A character vector of length 1. Uppercase. See [availableTickers(source = 'binance')] for available tickers.
#' @param from An optional vector of length 1. Can be [Sys.Date()]-class, [Sys.time()]-class or [as.character()] in %Y-%m-%d format.
#' @param to An optional vector of length 1. Can be [Sys.Date()]-class, [Sys.time()]-class or [as.character()] in %Y-%m-%d format.
#'
#' @author Jonas Cuzulan Hirani
#'
#' @example man/examples/scr_LSR.R
#' @family sentiment
#' @returns A xts object with the share of long and short position, and the ratio of the two.
#' @export
getLSRatio <- function(
    ticker,
    interval = '1d',
    from     = NULL,
    to       = NULL
) {

  # 1) check internet
  # connection
  check_internet_connection()

  # 2) check if the passed
  # dates are valid
  # pass dates through
  # the validator but only
  # if either is not null
  if (!is.null(from) || !is.null(to)){
    valid_dates <- date_validator(
      from = from,
      to   = to
    )

    from <- valid_dates$from
    to   <- valid_dates$to
  }

  # 3) if no from and to
  # are passed; construct
  # forced date intervals
  if (is.null(from) || is.null(to)) {

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

  # 4) The from date are limited
  # by binance, and they are only providing
  # the LS ratios for the last 30 days.
  min_dates <- date_validator(
    from = Sys.Date() - 30,
    to   = Sys.time()
  )

  if (min_dates$from >= from) {

    message(
      c(
        'Only the data of the latest 30 days is available. Returning available data.'
      )
    )

  }

  from <- max(
    min_dates$from,
    from
  )

  to <- min(
    min_dates$to,
    to
  )


  # construct baseURL
  # and endPoint
  baseurl <- baseUrl(
    source  = 'binance',
    futures = TRUE
  )

  endpoint <- endPoint(
    source = 'binance',
    type   = 'lsratio'
  )

  # 4) perform request and
  # store;
  query <- source_parameters(
    ticker = ticker,
    source = 'binance',
    futures = TRUE,
    interval = interval,
    from     = from,
    to       = to
  )$query

  names(query)[2] <- 'period'
  query$limit <- 500

  response <- httr2::req_perform(
    req = httr2::req_url_query(
      httr2::request(
        paste0(
          baseurl, endpoint
        )
      ),
      !!!query
    )
  )

  # 5) the response is named
  # json list, and the data
  # of interst is stored
  # in data
  response <- httr2::resp_body_json(
    resp = response,
    simplifyVector = TRUE
  )


  # 6) prepare the data;
  # 6) dates are returned in UNIX
  # and doesnt need any numerical
  # operations.
  response$timestamp <- convertDate(
    date = as.numeric(response$timestamp),
    is_response = TRUE,
    multiplier = 1e3,
    power = -1
  )


  # 7) order response timestamp and
  # convert to xts
  response <- response[
    order(response$timestamp, decreasing = FALSE),
  ]


  response <- xts::as.xts(
    response[,c(2:4)],
    order.by = response$timestamp
  )


  colnames(response) <- c('Long', 'LSRatio', 'Short')
  response <- response[,c('Long', 'Short', 'LSRatio')]



  # return the
  # response
  return(
    response
  )

}




