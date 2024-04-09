# script: Charting Long-Short Ratios
# date: 2024-01-30
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;


#' Chart the long-short ratios
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' The [lsr()]-function adds a scatter plot as a subplot to the chart colored by ratio size.
#'
#' @details
#' The long-short ratio is a market sentiment indicator on expected price movement.
#'
#' @param ratio A [xts::xts()]-object with the column LSRatio. See [get_lsratio()] for more details.
#' @inherit kline
#'
#' @example man/examples/scr_LSR.R
#'
#' @family chart indicators
#' @family sentiment indicators
#' @family subcharts
#'
#'
#' @export
lsr <- function(
    ratio,
    ...) {

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
      color_scale <- grDevices::palette(
        grDevices::hcl.colors(
          n = 30,
          palette = "RdYlGn"
        )
      )

      if (color_deficiency) {
        color_scale <- rev(
          grDevices::palette(
            grDevices::hcl.colors(
              n = 30,
              palette = "Cividis"
            )
          )
        )
      }

      # 1.1.1) map the values
      # to  the color scale
      data$color_scale <- ceiling(
        30 * (data$ls_ratio)/(3)
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
            size = 18
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
