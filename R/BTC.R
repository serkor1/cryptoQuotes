#' USDT Denominated Bitcoin (BTCUSDT) Weekly Intervals
#'
#' @description
#' This dataset contains time-series data for Bitcoin (BTC) denominated in USDT (Tether),
#' captured in weekly intervals (OHLC-V format). The dataset consists of 52 rows and 5 columns,
#' covering the period from January 1, 2023, to December 31, 2023.
#'
#' @format An [xts::xts()] object structured as follows:
#' \describe{
#'   \item{open}{[numeric] Opening price of Bitcoin in USDT at the start of each week.}
#'   \item{high}{[numeric] Highest price of Bitcoin in USDT during the week.}
#'   \item{low}{[numeric] Lowest price of Bitcoin in USDT during the week.}
#'   \item{close}{[numeric] Closing price of Bitcoin in USDT at the end of each week.}
#'   \item{volume}{[numeric] Trading volume of Bitcoin for the week, measured in units of Bitcoin.}
#' }
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
