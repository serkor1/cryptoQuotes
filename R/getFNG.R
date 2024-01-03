# script: getFNG
# date: 2023-12-25
# author: Serkan Korkmaz, serkor1@duck.com
# objective: write a function
# that extract and aggregates the fear and greed
# index from alternative.met
# script start;

#' Get the daily Fear and Greed Index
#' for the cryptocurrency market
#'
#' @description
#' The fear and greed index is a market sentiment indicator that measures investor emotions to
#' gauge whether they are generally fearful (indicating potential selling pressure) or greedy (indicating potential buying enthusiasm)
#'
#' @param from An optional vector of length 1. Can be [Sys.Date()]-class, [Sys.time()]-class or [as.character()] in %Y-%m-%d format.
#' @param to An optional vector of length 1. Can be [Sys.Date()]-class, [Sys.time()]-class or [as.character()] in %Y-%m-%d format.
#'
#' @example man/examples/scr_FGIndex.R
#'
#' @details
#' The Fear and Greed Index goes from 0-100, and can be classifed as follows
#'
#' \itemize{
#'   \item 0-24, Extreme Fear
#'   \item 25-44, Fear
#'   \item 45-55, Neutral
#'   \item 56-75, Greed
#'   \item 76-100, Extreme Greed
#' }
#'
#' @family sentiment
#' @returns A xts object with the FGI daily score
#' @export

getFGIndex <- function(
    from = NULL,
    to = NULL
) {

  # NOTE: This function
  # is a standalone function that only
  # depends on few internal functions.
  #
  # Its otherwise selfcontained.

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
      interval = '1d',
      from     = from,
      to       = to
    )

    # generate from
    # to variables
    from <- forced_dates$from
    to   <- forced_dates$to

  }

  # 4) perform request and
  # store;
  query <- list(
  format = 'json',
  limit = '0'
  )

  response <- httr2::req_perform(
     req = httr2::req_url_query(
      httr2::request(
        'https://api.alternative.me/fng/'
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
  )$data

  # 6) dates are returned in UNIX
  # and doesnt need any numerical
  # operations.
  response$timestamp <- convertDate(
    date = as.numeric(response$timestamp),
    is_response = TRUE,
    power = -1
  )


  # 7) order response timestamp and
  # convert to xts
  response <- response[
    order(response$timestamp, decreasing = FALSE),
    ]

  response <- xts::as.xts(
    zoo::as.zoo(
      as.numeric(response$value)
      ),
    order.by = response$timestamp
    )

  # 8) set colnames
  # to FGI
  colnames(response) <- 'FGI'

  # 9) subset according
  # to from and to
  response <- stats::window(
    x = response,
    start = from,
    end   = to
  )

  return(
    response
  )
}

# script end;
