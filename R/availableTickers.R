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


  ticker <- get(
    paste0(
      source,
      'Tickers'
    )
  )(futures = futures)

  return(
    ticker
  )




}


