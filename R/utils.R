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
    quoteList
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

  # 4) return quote;
  return(quote)





  # if (!inherits(x = quote, what = c('rawQuote'))) {
  #   rlang::abort(
  #     message = 'Has to be class "rawQuote"'
  #   )
  # }
  #
  # if (inherits(x = quote, what = c('binance'))) {
  #
  #   # 1) construct names
  #   column_names <- c(
  #     'Open',
  #     'High',
  #     'Low',
  #     'Close',
  #     'Volume'
  #   )
  #
  #
  #
  #
  #   # 3) the first element
  #   # is always the data
  #   # from Binance
  #   index <- as.POSIXct(
  #     as.numeric(quote[,1])/1e3,
  #     origin = '1970-01-01',
  #     tz = 'UTC'
  #   )
  #
  #
  #
  #   if (inherits(x = quote, what = c('futures'))) {
  #
  #     keep_cols <- c(
  #       2:6
  #     )
  #     #attr(index, "tzone") <- Sys.timezone()
  #
  #
  #
  #   }
  #
  #   if (inherits(x = quote, what = 'spot')) {
  #
  #
  #     keep_cols <- c(
  #       2:6
  #     )
  #
  #
  #   }
  #
  #
  #
  #
  #   quote <- quote[,keep_cols]
  #
  #
  #   colnames(quote) <- column_names[seq_along(keep_cols)]
  #
  #
  # }
  #
  # # 2) convert all
  # # quote elements to
  # # numeric
  # quote <- apply(
  #   quote,
  #   c(1,2),
  #   as.numeric
  # )
  #
  #



}




# end of script; ####
