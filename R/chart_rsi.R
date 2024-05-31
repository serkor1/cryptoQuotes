# script: Relative Strength Index (RSI)
# indicator
# date: 2024-01-29
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create expressions to be evaluted in
# the charting function
# script start;
#' @title
#' Chart the Relative Strength Index (RSI)
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' A high-level [plotly::plot_ly()]- and [plotly::add_lines()]-function that
#' interacts with the [TTR::RSI()]-function.
#' The function adds a subchart with a [TTR::RSI()]-indicator.
#'
#' @usage rsi(
#'  price       = "close",
#'  n           = 14,
#'  maType      = "SMA",
#'  upper_limit = 80,
#'  lower_limit = 20,
#'  color       = '#4682b4',
#'  ...
#' )
#'
#' @inheritParams TTR::RSI
#' @param upper_limit A [numeric]-vector of [length] 1. 80 by default.
#' Sets the upper limit of the [TTR::RSI].
#' @param lower_limit A [numeric]-vector of [length] 1. 20 by default.
#' Sets the lower limit of the [TTR::RSI].
#' @param color A [character]-vector of [length] 1. "#4682b4" by default.
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
rsi <- function(
    price       = "close",
    n           = 14,
    maType      = "SMA",
    upper_limit = 80,
    lower_limit = 20,
    color       = '#4682b4',
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

      # 1) calculate RSI
      # indicator
      data <- stats::na.omit(
        indicator(
          x = args$data,
          columns = price,
          .f = TTR::RSI,
          n = 14,
          maType = "SMA"
        )
      )

      # 1.1) chart arguments
      linewidth <- 0.90


      layers <- list(
        list(
          type = "add_lines",
          params = list(

            showlegend = FALSE,
            name = "Upper Bound",
            y = ~upper_limit,
            line = list(
              color = color,
              dash = 'dot',
              width = linewidth
            )
          )

        ),
        list(
          type = "add_lines",
          params = list(
            showlegend = FALSE,
            name = "Lower Bound",
            y = ~lower_limit,
            line = list(
              color = color,
              dash = 'dot',
              width = linewidth
            )
          )

        ),
        list(
          type = "add_ribbons",
          params = list(
            data       = data,
            showlegend = FALSE,
            ymin = ~lower_limit,
            ymax = ~upper_limit,
            fillcolor = as_rgb(alpha = 0.1, hex_color = color),
            line = list(
              color = 'transparent'
            ) # Transparent line
          )

        )
      )

      # Initialize the plot with RSI line
      p <- plot_ly(
        name = 'RSI',
        data = data,
        mode = "lines",
        showlegend = FALSE,
        type = "scatter",
        x = ~index,
        y = ~rsi,
        line = list(
          color = color,
          width = linewidth
        )
      )

      p <- build(
        plot   = p,
        layers = layers,
        annotations = list(
          list(
            text = paste0("RSI(", n, ")"),
            font = list(
              size = 16
            ),
            x = 0,
            y = 1,
            xref = 'paper',
            yref = 'paper',
            showarrow = FALSE
          )
        ),
        yaxis = list(
          title = NA,
          range = c(0, 100)
        )

      )


      # Display the plot
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
