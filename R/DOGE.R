#' USDT Denominated DOGECOIN (DOGECOINUSDT) 1-Minute Intervals
#'
#' @description
#' This dataset contains time-series data for the DOGECOIN cryptocurrency denominated in USDT (Tether),
#' captured in 1-minute intervals (OHLC-V format). The dataset consists of 61 rows and 5 columns and spans 2022-01-14 07:00:00 CET to 2022-01-14 08:00:00 CET.
#'
#' @format An [xts::xts()] object structured as follows:
#' \describe{
#'   \item{open}{[numeric] Opening price}
#'   \item{high}{[numeric] Highest price.}
#'   \item{low}{[numeric] Lowest price.}
#'   \item{close}{[numeric] Closing price.}
#'   \item{volume}{[numeric] Trading volume.}
#' }
#'
#' @examples
#' # Load the dataset
#' data("DOGE")
#'
#' # Plot candlestick charts to visualize price movements
#' chart(
#'   ticker = DOGE,
#'   main = kline(),
#'   sub = list(volume())
#' )
"DOGE"
