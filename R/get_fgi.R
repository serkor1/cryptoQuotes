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
#'
#' `r lifecycle::badge("deprecated")`
#'
#' The fear and greed index is a market sentiment indicator that measures investor emotions to
#' gauge whether they are generally fearful (indicating potential selling pressure) or greedy (indicating potential buying enthusiasm)
#'
#' @inheritParams get_quote
#'
#' @example man/examples/scr_FGIndex.R
#'
#' @inherit get_quote details
#'
#' @family get-function
#'
#' @returns An [xts]-object containing,
#'
#' * fgi ([numeric]): The daily fear and greed index value
#'
#' @note
#'
#' The Fear and Greed Index goes from 0-100, and can be classified as follows,
#'
#' \itemize{
#'   \item 0-24, Extreme Fear
#'   \item 25-44, Fear
#'   \item 45-55, Neutral
#'   \item 56-75, Greed
#'   \item 76-100, Extreme Greed
#' }
#'
#' @author Serkan Korkmaz
#'
#' @export
get_fgindex <- function(
    from = NULL,
    to = NULL) {

  # NOTE: This function
  # is a standalone function that only
  # depends on few internal functions.
  #
  # Its otherwise selfcontained.

  # 1) check internet
  # connection
  check_internet_connection()

  assert(
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


  from <- coerce_date(from); to <- coerce_date(to)

  # 3) if no from and to
  # are passed; construct
  # forced date intervals
  if (is.null(from) || is.null(to)) {

    # to ensure consistency across
    # APIs if no date is set the output
    # is limited to 200 pips
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


  response <- GET(
    url = "https://api.alternative.me",
    endpoint = "fng",
    query =  query,
    path = "/"
  )$data


  assert(
    !is.null(response),
    error_message = sprintf(
      fmt = "Unexpected error. Try again or submit a %s",
      cli::style_hyperlink(
        text = cli::col_br_red("bug report"),
        url = "https://github.com/serkor1/cryptoQuotes"
      )
    )
  )

  # 6) dates are returned in UNIX
  # and doesnt need any numerical
  # operations.
  response$timestamp <- convert_date(
    x = as.numeric(response$timestamp),
    multiplier = 1
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

  response
}

# script end;
