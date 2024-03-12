# script: indicators;
# date: 2023-10-11
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Generate indictors
# that are compatible with
# plotly
# script start;


# addBBands <- function(
    #     chart,
#     cols = c('High', 'Low', 'Close'),
#     ...
# ) {
#
#
#   ## 1) convert the embedded
#   ## data.frame in the plot
#   ## to xts, zoo object
#   quote <- (
#     attributes(chart)$quote
#   )
#
#   ## 2) extract the main chart
#   ## and store it it as plot_
#   chart_ <- chart$main
#
#   ## 3) calculate the bollinger
#   ## bands using TTR and store
#   ## it as indicator.
#   indicator <- toDF(
#     TTR::BBands(
#       HLC = quote[
#         ,
#         which(
#           sapply(
#             colnames(quote),
#             grepl,
#             pattern = paste0(cols, collapse = '|'),
#             ignore.case = TRUE
#           )
#         )
#       ],
#       ...
#     )
#   )
#
#   ## 4) add the indicator
#   ## to main plot_
#   chart_ <- chart_ %>%
#     plotly::add_lines(
#       showlegend = FALSE,
#       data = indicator,
#       x = ~Index,
#       y = ~up,
# line = list(
#   color ='#F100F1'
# ),
#       inherit = FALSE,
#       name = "up",
#     ) %>%
#     plotly::add_lines(
#       data = indicator,
#       x = ~Index,
#       y = ~dn,
#       showlegend = FALSE,
# fill = 'tonexty',
# fillcolor = 'rgba(241,0,241,0.1)',
#       line = list(
#         color ='#F100F1'
#       ),
#       inherit = FALSE,
#       name = "dn"
#     ) %>%
#     plotly::add_lines(
#       showlegend = FALSE,
#       data = indicator,
#       x = ~Index,
#       y = ~mavg,
# line = list(
#   dash ='dot',
#   color = '#F100F1'
# ),
#       inherit = FALSE,
#       name = "MA"
#     )
#
#   ## 5) store plot_
#   ## in the plot list
#   ## in main
#   chart$main <- chart_
#
#   ## 6) pass the quote on
#   ## to the attributes of the
#   ## for further indicator plots
#   attributes(chart)$quote <- attributes(chart)$quote
#
#
#   ## 7) return
#   ## the plot invisibly
#   ## to force enduser
#   ## to use chart-function
#   return(
#     invisible(chart)
#   )
#
# }



#' #' Add various Moving Average indicators
#' #' to the chart
#' #'
#' #' @description
#' #'
#' #' `r lifecycle::badge("experimental")`
#' #'
#' #' Moving averages are versatile tools used by traders and analysts in various timeframes, from short-term intraday trading to long-term investing.
#' #' They help smooth out noise in price data and provide valuable information for decision-making in financial markets.
#' #'
#' #'
#' #'
#' #' @param chart a [kline()] or [ohlc()] chart
#' #' @param FUN A named function calculating MAs. Has to be explicitly called. See [TTR::SMA()] for more information.
#' #' @param ... See [TTR::SMA()]
#' #'
#' #' @details
#' #' The function supports all moving averages calculated
#' #' by the [TTR] library. See [TTR::SMA()] for more information.
#' #'
#' #'
#' #'
#' #' @example man/examples/scr_charting.R
#' #'
#' #' @returns Invisbly returns a plotly object.
#' #'
#' #' @family chart indicators
#' #' @export
#' addMA <- function(chart, FUN = TTR::SMA, ...) {
#'
#'   ## 0) extract
#'   ## call to paste into the function
#'   if (...length() == 0) {
#'
#'     arguments <- rlang::fn_fmls(
#'       fn = eval(FUN)
#'     )
#'
#'   } else {
#'
#'     arguments <- as.list(
#'       match.call()
#'     )
#'   }
#'
#'
#'   foo <- match.fun(
#'     FUN = FUN
#'   )
#'
#'
#'   quote <- attributes(chart)$quote
#'
#'   # 1) extract the main
#'   # chart from the plot
#'   chart_ <- chart$main
#'
#'   quote_ <- toDF(
#'     foo(
#'       quote[,'Close'],
#'       ...
#'     )
#'   )
#'
#'
#'
#'   colnames(quote_)[!grepl(colnames(quote_), pattern = 'Index', ignore.case =TRUE)] <- 'value'
#'
#'   chart_ <- chart_ %>% plotly::add_lines(
#'     data = quote_,
#'     name = paste0(
#'       gsub(pattern = '^[a-z]+::', replacement = '', ignore.case = TRUE, x = deparse(arguments$FUN)),
#'       '(',
#'       names(arguments[4]),
#'       '=',
#'       arguments[[4]],
#'       ')'
#'     ),
#'     x = ~Index,
#'     y = ~value,
#'     inherit = FALSE
#'   )
#'
#'
#'
#'
#'   chart$main <- chart_
#'   attributes(chart)$quote <- quote
#'
#'
#'   return(
#'     invisible(chart)
#'   )
#'
#'
#'
#'
#' }










# script end;
