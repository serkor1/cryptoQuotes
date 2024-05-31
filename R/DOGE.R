#' USDT Denominated DOGECOIN (DOGEUSDT) 1-Minute Intervals
#'
#' @description
#' This dataset contains time-series data for the DOGECOIN (DOGE)
#' denominated in USDT (Tether), captured in 1-minute intervals.
#' The data spans 2022-01-14 07:00:00 CET to 2022-01-14 08:00:00 CET.
#'
#' @format An [xts::xts()]-object  with 61 rows and 5 columns,
#'
#' \describe{
#'  \item{index}{<[POSIXct]> The time-index}
#'  \item{open}{<[numeric]> Opening price}
#'  \item{high}{<[numeric]> Highest price}
#'  \item{low}{<[numeric]> Lowest price}
#'  \item{close}{<[numeric]> Closing price}
#'  \item{volume}{<[numeric]> Trading volume}
#' }
#'
#' @examples
#' # Load the dataset
#' data("DOGE")
#'
#' # chart
#' chart(
#'   ticker = DOGE,
#'   main = kline(),
#'   sub = list(volume())
#' )
"DOGE"
