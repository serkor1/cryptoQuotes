# script: helpers
# author: Serkan Korkmaz
# date: 2023-09-20
# objective: Generate a set of functions
# to ease the process of getting cryptoQuotes
# script start; ####



# base-url;
baseUrl <- function(
    source = 'binance',
    futures
) {
  # 1) construct function
  # based on source
  baseUrl <- get(paste0(source, 'Url'))(
    futures = futures
  )

  # 2) return the baseUrl
  return(
    baseUrl
  )
}


# endpoint
endPoint <- function(source,futures) {

  # 1) construct function
  # based on source
  endPoint <- get(paste0(source, 'Endpoint'))(
    futures = futures
  )

  # 2) return the baseUrl
  return(
    endPoint
  )

}


getParams <- function(
    source,
    futures,
    ticker,
    interval,
    from = NULL,
    to = NULL
) {

  getParams <- get(
    paste0(source, 'Params')
  )(
    futures  = futures,
    ticker   = ticker,
    interval = interval,
    from     = from,
    to       = to
  )

  return(
    getParams
  )

}



fetchQuote <- function(
    source,
    futures,
    interval,
    ticker,
    from = NULL,
    to = NULL
) {


  response <- get(
    paste0(source, 'Quote')
  )(
    futures = futures,
    interval = interval,
    ticker   = ticker,
    from      = from,
    to        = to
  )

  return(
    response
  )

}



formatQuote <- function(
    quoteList,
    ticker,
    interval,
    source,
    futures
) {


  # 1) extract the quote
  # and convert to zoo object
  quote <- zoo::as.zoo(
    quoteList$quote
  )

  # 2) generate index
  # of the quote
  zoo::index(quote) <- quoteList$index

  # 3) convert to xts
  # object
  quote <- xts::as.xts(
    quote
  )

  # 4) construct
  # attributes for further
  # functionality
  attributes(quote)$source <- source
  attributes(quote)$interval <- interval
  attributes(quote)$ticker <- ticker
  attributes(quote)$market <- ifelse(futures,'PERPETUAL', 'Spot')

  # 4) return quote;
  return(quote)

}




# end of script; ####
