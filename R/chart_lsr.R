# script: Charting Long-Short Ratios
# date: 2024-01-30
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;


#' Chart the long-short ratio
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' A high-level [plotly::plot_ly()]-wrapper function. The function adds a subchart to the [chart] with `long-short ratio`.
#'
#' @param ratio A [xts::xts()]-object. See [get_lsratio()] for more details.
#' @inherit kline
#'
#' @example man/examples/scr_LSR.R
#'
#' @family chart indicators
#' @family sentiment indicators
#' @family subcharts
#'
#' @export
lsr <- function(
    ratio,
    ...) {

  call_stack <- as.character(
    lapply(sys.calls(), `[[`, 1)
  )

  assert(
    call_stack[1] != as.character(match.call()),
    error_message = c(
      "x" = "Error",
      "i" = paste(
        "Run",
        cli::code_highlight(
          code = "cryptoQuotes::chart(...)",
          code_theme = "Chaos"
        ),
        "to build charts."
      )
    )
  )

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
