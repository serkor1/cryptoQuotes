# script: Moving Average Convergence Divergence (MACD)
# indicators
# date: 2024-01-29
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create expressions to be evaluted in
# the charting function
# script start;

#' @title
#' Chart the Moving Average Convergence Divergence (MACD) indicator
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' A high-level [plotly::plot_ly()]- and [plotly::add_lines()]-function that
#' interacts with the [TTR::MACD()]-function. The function adds subchart with a
#' [TTR::MACD()]-indicator.
#'
#' @usage macd(
#'  nFast   = 12,
#'  nSlow   = 26,
#'  nSig    = 9,
#'  maType  = "SMA",
#'  percent = TRUE,
#'  ...
#' )
#'
#' @inheritParams TTR::MACD
#' @param ... For internal use. Please ignore.
#'
#' @inherit kline
#'
#' @example man/examples/scr_charting.R
#'
#' @family chart indicators
#' @family subchart indicators
#' @family momentum indicators
#' @author Serkan Korkmaz
#' @export
macd <- function(
    nFast   = 12,
    nSlow   = 26,
    nSig    = 9,
    maType  = "SMA",
    percent = TRUE,
    ...){

  # check if the indicator is called
  # from the chart-function
  #
  # stops the function if not
  check_indicator_call()

  structure(
    .Data = {


      # 0) construct arguments
      # via chart function
      args <- list(
        ...
      )

      # 1) unpack all elements
      # of the args
      #data <- args$data


      # 0.4) linewidth
      linewidth <- 0.90

      # 1) calculate MACD
      # indicator
      data <- indicator(
        x = args$data,
        columns = "close",
        .f = TTR::MACD,
        nFast    = nFast,
        nSlow    = nSlow,
        nSig     = nSig,
        maType   = maType,
        percent  = percent

      )


      data$direction <- as.logical(
        data$signal >= data$macd
      )

      # 2) create plot
      # without using pipes;
      p <- plotly::plot_ly(
        data       = data,
        showlegend = FALSE,
        name       = 'MACD',
        x          = ~ index,
        y          = ~ (macd - signal),
        color      = ~ direction,
        colors     = c(
          # The first color always
          # applies to the true condition
          args$candle_color$bullish,
          args$candle_color$bearish),
        type       = 'bar',
        marker     = list(line = list(
          color = "black",
          width = 0.5
        ))
      )

      layers <- list(
        list(
          type = "add_lines",
          params = list(
            name = "MACD: Signal",
            data = data,
            showlegend = FALSE,
            x = ~ index,
            y = ~ signal,
            inherit = FALSE,
            line = list(width = linewidth)
          )

        ),
        list(
          type = "add_lines",
          params = list(
            name = "MACD: MACD",
            data = data,
            showlegend = FALSE,
            x = ~ index,
            y = ~ macd,
            inherit = FALSE,
            line = list(width = linewidth)
          )

        )
      )

      p <- build(
        plot = p,
        layers = layers,
        annotations = list(
          list(
            text = paste0(
              "MACD(",paste(c(nFast, nSlow,nSig), collapse = ', '), ")"
              ),
            x = 0,
            y = 1,
            font = list(
              size = 16  * args$scale
            ),
            xref = 'paper',
            yref = 'paper',
            showarrow = FALSE
          )
        ),
        yaxis = list(
          title = NA
        )
      )


      p




    },
    class = c(
      "subchart",
      "plotly",
      "htmlwidget"
      )
  )

}

# script end;
