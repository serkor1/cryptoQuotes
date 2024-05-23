#' USDT Denominated ATOM (ATOMUSDT) 15-Minute Intervals
#'
#' @description
#' This dataset contains time-series data for the ATOM (ATOM)
#' denominated in USDT (Tether), captured in 15-minute intervals.
#' The data spans from December 30 to December 31, 2023.
#'
#' @format An [xts::xts()]-object with 97 rows and 5 columns,
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
#' data("ATOM")
#'
#' # chart
#' chart(
#'   ticker = ATOM,
#'   main = kline(),
#'   sub = list(volume())
#' )
"ATOM"




