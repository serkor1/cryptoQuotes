#' Fear and Greed Index Values (FGIndex) Daily Intervals
#'
#' @description
#' This dataset contains daily values of the Fear and Greed Index for the year 2023, which is used to measure the sentiments of investors in the market. The data spans from January 1, 2023, to December 31, 2023.
#'
#' @format An [xts::xts()] object structured as follows:
#' \describe{
#'   \item{FGI}{[numeric] Daily Fear and Greed Index value.}
#' }
#'
#' @details
#' The Fear and Greed Index goes from 0-100, and can be classified as follows,
#'
#' \describe{
#'   \item{0-24}{Extreme Fear}
#'   \item{25-44}{Fear}
#'   \item{45-55}{Neutral}
#'   \item{56-75}{Greed}
#'   \item{76-100}{Extreme Greed}
#' }
#'
#'
#' @examples
#' # Load the dataset
#' data("FGIndex")
#'
#' # Get a summary of index values
#' summary(FGIndex)
"FGIndex"
