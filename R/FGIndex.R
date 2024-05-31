#' Fear and Greed Index (FGI) values for the
#' cryptocurrency market in daily intervals
#'
#' @description
#' This dataset contains daily values of the Fear and Greed Index for the year
#' 2023, which is used to measure the sentiments of investors in the market.
#' The data spans from January 1, 2023, to December 31, 2023.
#'
#' @format An [xts::xts()]-object with 364 rows and 1 columns,
#'
#' \describe{
#'  \item{index}{<[POSIXct]> The time-index}
#'  \item{fgi}{<[numeric]< The daily fear and greed index value}
#' }
#' @details
#' The Fear and Greed Index goes from 0-100, and can be classified as follows,
#'
#' \itemize{
#'   \item 0-24, Extreme Fear
#'   \item 25-44, Fear
#'   \item 45-55, Neutral
#'   \item 56-75, Greed
#'   \item 76-100, Extreme Greed
#' }
#'
#' @examples
#' # Load the dataset
#' data("FGIndex")
#'
#' # Get a summary of index values
#' summary(FGIndex)
"FGIndex"
