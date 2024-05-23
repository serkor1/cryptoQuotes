#' USDT Denominated Bitcoin (BTCUSDT) Weekly Intervals
#'
#' @description
#' This dataset contains time-series data for Bitcoin (BTC)
#' denominated in USDT (Tether), captured in weekly intervals.
#' The data spans from January 1, 2023, to December 31, 2023.
#'
#' @format An [xts::xts()]-object with 52 rows and 5 columns,
#'
#' \describe{
#' \item{index}{<[POSIXct]> The time-index}
#' \item{open}{<[numeric]> Opening price}
#' \item{high}{<[numeric]> Highest price}
#' \item{low}{<[numeric]> Lowest price}
#' \item{close}{<[numeric]> Closing price}
#' \item{volume}{<[numeric]> Trading volume}
#' }
#'
#' @examples
#' # Load the dataset
#' data("BTC")
#'
#' # chart
#' chart(
#'   ticker = BTC,
#'   main = kline(),
#'   sub = list(volume())
#' )
"BTC"
