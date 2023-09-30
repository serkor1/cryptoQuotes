#' availableTickers
#'
#'
#' This function returns all available
#' pairs on the exchanges.
#'
#'
#' @param source a character vector of length 1. The source of the API
#' @param futures a logical value. Default TRUE.
#'
#'
#' @returns Returns a character vector
#' of length N equal to the tradable tickers
#'
#'
#' @export
availableTickers <- function(
    source  = 'binance',
    futures = TRUE
    ) {

  # this function returns
  # all available tickers
  # from the desired exchange and markets
  #
  # The function were mainly intended as a
  # helper function, but has now been exported as it
  # is useful for backtesting on various tickers
  # in bulk.

  # for binance;
  if (grepl(pattern = 'binance', x = source, ignore.case = TRUE)) {

    # generate endpoint
    # based on market
    if (futures) {

      endPoint <- '/fapi/v1/exchangeInfo'

    } else {

      endPoint <- '/api/v3/exchangeInfo'


    }


    # GET request
    # to the exchange
    response <- httr::GET(
      url   = baseUrl(
        source = source,
        futures = futures
      ),
      httr::timeout(5),
      # NOTE: Cant connect
      # to Binance with this
      # httr::use_proxy(
      #   url = '141.11.158.172',
      #   port = 8080
      #   ),
      path  = endPoint
    )

    # 2) parse response
    response <- jsonlite::fromJSON(
      txt = httr::content(
        x = response,
        as = 'text',
        encoding = 'UTF-8'
      )
    )

    # 3) subset using base R
    # to ensure vuture compatibility
    #
    # Subsetting by tradable tickers
    ticker <- subset(
      x =  response$symbols,
      grepl(pattern = 'trading', ignore.case = TRUE, x = get('status'))
    )$symbol

    # 4) extract ticker
    # variable from the data.grame and store
    # as vector
    # ticker <- ticker[[
    #   ifelse(futures, yes = 'pairs', no = 'symbol')
    #   ]]





  }



  return(
    ticker
  )




}


