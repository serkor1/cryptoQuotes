#' USDT Denominated Bitcoin (BTCUSDT) Weekly Intervals
#'
#' @description
#' This dataset contains time-series data for Bitcoin (BTC) denominated in USDT (Tether),
#' captured in weekly intervals (OHLC-V format). The dataset consists of 52 rows and 5 columns,
#' covering the period from January 1, 2023, to December 31, 2023.
#'
#' @format An [xts::xts()] object structured as follows:
#'
#' \item{index}{<[POSIXct]> The time-index}
#' \item{open}{<[numeric]> Opening price}
#' \item{high}{<[numeric]> Highest price}
#' \item{low}{<[numeric]> Lowest price}
#' \item{close}{<[numeric]> Closing price}
#' \item{volume}{<[numeric]> Trading volume}
#'
#' @examples
#' # Load the dataset
#' data("BTC")
#'
#' # candlestick charts
#' chart(
#'   ticker = BTC,
#'   main = kline(),
#'   sub = list(volume())
#' )
"BTC"
