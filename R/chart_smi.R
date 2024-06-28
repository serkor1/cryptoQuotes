# script: chart_smi
# author: Serkan Korkmaz, serkor1@duck.com
# date: 2024-05-29
# objective: The Stochastic Momentum Index - subchart
# script start;
#' @title
#' Chart the Stochastic Momentum Index (SMI)
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' A high-level [plotly::plot_ly()]- and [plotly::add_lines()]-function that
#' interacts with the [TTR::SMI()]-function.
#' The function adds a subchart with a [TTR::SMI()]-indicator.
#'
#' @usage smi(
#'  nFastK = 14,
#'  nFastD = 3,
#'  nSlowD = 3,
#'  maType,
#'  bounded = TRUE,
#'  smooth = 1,
#'  upper_limit = 40,
#'  lower_limit = -40,
#'  color = "#4682b4",
#'  ...
#' )
#'
#' @inheritParams TTR::SMI
#' @param upper_limit A [numeric]-vector of [length] 1. 40 by default.
#' Sets the upper limit of the [TTR::SMI].
#' @param lower_limit A [numeric]-vector of [length] 1. -40 by default.
#' Sets the lower limit of the [TTR::SMI].
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
smi <- function(
    nFastK = 14,
    nFastD = 3,
    nSlowD = 3,
    maType,
    bounded = TRUE,
    smooth = 1,
    upper_limit = 40,
    lower_limit = -40,
    color = "#4682b4",
    ...) {

  # check if function is called
  # outside of chart-function
  check_indicator_call()

  # 1) initialize structure
  # indicator
  structure(
    .Data = {

      # 0) construct arguments
      # via chart function
      args <- list(
        ...
      )

      # 1) calculate indicator
      # using indicator-function
      data <- indicator(
        x       = args$data,
        columns = c("high", "low", "close"),
        .f      = TTR::SMI,
        nFastK = nFastK,
        nFastD = nFastD,
        nSlowD = nSlowD,
        maType = maType,
        bounded = TRUE,
        smooth = smooth
      )

      p <- plotly::plot_ly(
        data = data,
        showlegend = FALSE,
        name = "Signal",
        x = ~index,
        y = ~signal,
        type = "scatter",
        mode = "lines",
        line = list(
          width = 0.9,
          dash  = "dot"

        )
      )

      layers <- list(
        list(
          type = "add_lines",
          params = list(
            name = "Index",
            data = data,
            showlegend = FALSE,
            x = ~index,
            y = ~smi,
            inherit = FALSE,
            line = list(
              width = 0.9
            )
          )
        ),
        list(
          type = "add_lines",
          params = list(
            name = "Index",
            data = data,
            showlegend = FALSE,
            x = ~index,
            y = ~lower_limit,
            inherit = FALSE,
            line = list(
              width = 0.9,
              color = as_rgb(hex_color = color, alpha = 1),
              dash  = "dot"
            )
          )
        ),
        list(
          type = "add_lines",
          params = list(
            name = "Index",
            data = data,
            showlegend = FALSE,
            x = ~index,
            y = ~upper_limit,
            inherit = FALSE,
            line = list(
              width = 0.9,
              color = as_rgb(hex_color = color, alpha = 1),
              dash  = "dot"
            )
          )
        ),
        list(
          type = "add_ribbons",
          params = list(
            data       = data,
            inherit = FALSE,
            showlegend = FALSE,
            x = ~index,
            ymin = ~lower_limit,
            ymax = ~upper_limit,
            fillcolor = as_rgb(alpha = 0.1, hex_color = color),
            line = list(
              color = 'transparent',
              dash  = "dot"
            )
          )

        )
      )

      p <- build(
        plot = p,
        layers = layers,
        annotations = list(
          list(
            text = paste0(
              "SMI(",paste(c(nFastK, nFastD, nSlowD), collapse = ', '), ")"
            ),
            x = 0,
            y = 1,
            font = list(
              size = 16 * args$scale
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
