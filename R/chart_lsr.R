# script: Charting Long-Short Ratios
# date: 2024-01-30
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;
#' @title
#' Chart the long-short ratio
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' A high-level [plotly::plot_ly()]-wrapper function.
#' The function adds a subchart to the [chart] with `long-short ratio`.
#'
#' @param ratio A [xts::xts()]-object. See [get_lsratio()] for more details.
#' @inherit kline
#'
#' @example man/examples/scr_chartLSR.R
#'
#' @family chart indicators
#' @family sentiment indicators
#' @family subchart indicators
#' @author Serkan Korkmaz
#' @export
lsr <- function(
    ratio,
    ...) {

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

      # 1) unpack values
      # from chart
      data <- zoo::fortify.zoo(ratio, names = "index")
      color_deficiency <- args$deficiency


      # 1.1) define available
      # colors
      color_scale <- grDevices::hcl.colors(
        n = 30,
        palette = ifelse(color_deficiency, "Cividis", "RdYlGn"),
        rev = color_deficiency
      )

      data$color_scale <- normalize(
        x = data$ls_ratio,
        range = c(0,30),
        value = c(0,3)
        )

      data$color_scale <- color_scale[
        data$color_scale
      ]

      plotly::layout(
        plotly::plot_ly(
          showlegend = FALSE,
          name = "Long-Short Ratio",
          data = data,
          y = ~ls_ratio,
          x = ~index,
          type = 'scatter',
          mode = 'lines+markers',
          line = list(
            color = 'gray',
            dash = 'dash',
            shape = 'spline',
            smoothing = 1.5
          ),
          marker = list(
            size = 10,
            color = ~color_scale,
            line = list(
              color = 'black',
              width = 2
            )
          )
        ),
        annotations = list(
          text = "Long-Short Ratio",
          font = list(
            size = 16
          ),
          showarrow = FALSE,
          x = 0,
          y = 1,
          xref = "paper",
          yref = "paper"
        )
      )





    },
    class = c(
      "subchart",
      "plotly",
      "htmlwidget"
    )
  )





}


# script end;
