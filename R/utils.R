# script: utils
# author: Serkan Korkmaz
# date: 2023-09-20
# objective: Generate a set of functions
# to ease the process of getting cryptoQuotes
# script start; ####
#' GET-requests
#'
#' @param url [character] of length 1. The baseurl
#' @param endpoint [character] of length 1. The API endpoint
#' @param query A named [list] of queries.
#' @param path A [list] of paths.
#'
#'
#' @example man/examples/scr_GET.R
#'
#' @family development tools
#' @keywords internal
#'
#'
#' @returns A [list] crated by [jsonlite::fromJSON()]
GET <- function(
  url,
  endpoint = NULL,
  query = NULL,
  path = NULL
) {
  # 1) initialize
  # curl handle
  handle <- curl::new_handle()

  # 2) construct
  # query string
  query_string <- paste(
    names(query),
    unlist(query),
    sep = "=",
    collapse = "&"
  )

  path_string <- paste(
    unlist(path),
    collapse = "/"
  )

  # 3) construct hte
  # full url
  url <- paste(
    paste0(
      paste(
        url,
        endpoint,
        sep = "/"
      ),
      path_string
    ),
    query_string,
    sep = if (!is.null(query)) '?' else ""
  )

  # 4) set URL
  # to handle
  # curl::handle_setopt(
  #   handle = handle,
  #   url = url
  # )

  # 5) store
  # response in memory
  # and catch connection
  # errors
  response <- curl::curl_fetch_memory(
    url = url,
    handle = handle
  )

  jsonlite::fromJSON(
    txt = rawToChar(
      x = response$content
    ),
    simplifyVector = TRUE,
    flatten = TRUE
  )
}


source_parameters <- function(
  source,
  futures,
  type,
  ticker,
  interval,
  from,
  to,
  ...
) {
  get(
    paste0(
      source,
      'Parameters'
    )
  )(
    futures = futures,
    type = type,
    ticker = ticker,
    interval = interval,
    from = from,
    to = to,
    ...
  )
}


# base-url;
baseUrl <- function(
  source = 'binance',
  futures,
  ...
) {
  # 1) construct function
  # based on source
  baseUrl <- get(paste0(source, 'Url'))(
    futures = futures,
    ...
  )

  # 2) return the baseUrl
  return(
    baseUrl
  )
}

# endpoint
endPoint <- function(
  source,
  type = 'ohlc',
  futures,
  ...
) {
  # 1) construct function
  # based on source
  endPoint <- get(paste0(source, 'Endpoint'))(
    futures = futures,
    type = type,
    ...
  )

  # 2) return the endpoint
  return(
    endPoint
  )
}


#' Fetch time-based API-endpoint responses
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' This function is a high-level wrapper around the development tools available
#' and should reduce the amount of coding.
#'
#' @inheritParams get_quote
#' @inheritParams available_exchanges
#' @param ... additional parameters passed down the endpoint
#'
#' @details
#' This function can only be used to fetch time-based objects,
#' and can therefore not be used to get, for example, [available_tickers()].
#'
#' @family development tools
#'
#' @keywords internal
#'
#' @returns
#'
#' It returns an [xts::xts]-object from the desired endpoint.
#'
#'
#' @author Serkan Korkmaz
fetch <- function(
  ticker,
  source,
  futures,
  interval,
  type,
  to,
  from,
  ...
) {
  # 0) define error-message
  # NOTE: The only point of failure
  # is misspelled tickers
  error_message <- c(
    "x" = sprintf("Couldn't find {.val %s} on {.val %s}.", ticker, source),
    "v" = paste(
      "Run",
      cli::code_highlight(
        code = sprintf(
          "available_tickers(source = '%s', futures = %s)",
          source,
          futures
        ),
        code_theme = 'Chaos'
      ),
      "to see available tickers."
    ),
    "i" = sprintf(
      fmt = "If the error persists please submit a %s.",
      cli::style_hyperlink(
        text = cli::col_br_red("bug report"),
        url = "https://github.com/serkor1/cryptoQuotes"
      )
    )
  )

  # This is a high-level fetch-function
  # to get all values regardless of the
  # type

  # 1) extract parameters
  # from source and type
  parameters <- source_parameters(
    type = type,
    source = source,
    futures = futures,
    ticker = ticker,
    interval = interval,
    from = from,
    to = to
  )

  # 2) GET request
  response <- flatten(
    GET(
      url = baseUrl(
        source = source,
        futures = futures
      ),
      endpoint = endPoint(
        source = source,
        type = type,
        futures = futures,
        ...
      ),
      query = parameters$query,
      path = parameters$path
    )
  )

  # 2.1) Check if response
  # is NULL
  assert(
    !is.null(response),
    error_message = error_message
  )

  # 2.1) Locate the
  # data
  idx <- vapply(
    X = response,
    FUN.VALUE = logical(1),
    FUN = inherits,
    what = c('array', 'matrix', 'data.frame')
  )

  # 2.2) extract data
  # from reponse:
  #
  # NOTE: if this fails
  # then it is likely
  # that we are dealing with
  # an error, or Kraken
  #
  # This could be done using do.call
  # maybe
  response <- tryCatch(
    expr = {
      switch(
        source,
        kraken = {
          do.call(
            data.frame,
            response
          )
        },
        mexc = {
          tryCatch(
            response[[which(idx)]],
            error = function(error) {
              do.call(
                data.frame,
                response[
                  grepl(
                    pattern = "data",
                    x = names(response),
                    ignore.case = TRUE
                  )
                ]
              )
            }
          )
        },
        response[[which(idx)]]
      )
    },
    error = function(error) {
      assert(
        FALSE,
        error_message = error_message
      )
    }
  )

  # 3) Extract source specific
  # response parameters
  parameters <- get(
    paste0(
      source,
      'Response'
    )
  )(
    type = type,
    futures = futures
  )

  # 3.1) wrap parameters
  # in tryCatch to check wether
  # the columns exists
  # column_list <- tryCatch(
  #   expr = {
  #     list(
  #       index = response[, parameters$index_location],
  #       core  = rbind(response[,parameters$colum_location])
  #     )
  #   },
  #   error = function(error) {
  #
  #     assert(
  #       FALSE,
  #       error_message = error_message
  #     )
  #
  #   }
  # )

  # column_list <- list(
  #   index = response[, parameters$index_location],
  #   core  = rbind(response[,parameters$colum_location])
  # )

  # 3.1.1) extract the values
  # from the list

  # core  <- vapply(
  #   X         = column_list$core,
  #   FUN       = as.numeric,
  #   FUN.VALUE = numeric(1)
  # )

  # 3.1.2) convert
  # all to as.numeric
  core <- zoo::as.zoo(
    apply(
      X = rbind(response[, parameters$colum_location]),
      MARGIN = 2,
      FUN = as.numeric
    )
  )



  # 3.1.3) convert dates
  # to positxct
  index <- get(
    paste0(
      source,
      'Dates'
    )
  )(
    futures = futures,
    dates = response[, parameters$index_location],
    is_response = TRUE,
    type = type
  )

  # 4) convert to xts
  # from data.frame
  # NOTE: This throws an error
  # for KRAKEN no idea why
  response <- xts::as.xts(
    x = core,
    order.by = index
  )
  # 4.1) set column
  # names
  colnames(response) <- parameters$colum_names

  response
}

# end of script; ####
