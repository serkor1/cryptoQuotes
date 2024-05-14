# script: Charting the Fear and Greed Index
# date: 2024-01-30
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;

#' Chart the Fear and Greed Index
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' A high-level [plotly::plot_ly()]-wrapper function. The function adds a subchart with the `fear and greed`-index.
#'
#' @param index A [xts::xts()]-object. See [get_fgindex()] for more details.
#'
#' @example man/examples/scr_FGIndex.R
#'
#' @inherit kline
#' @inherit get_fgindex
#'
#' @family chart indicators
#' @family sentiment indicators
#' @family subchart indicators
#'
#' @export
fgi <- function(
    index,
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
      data <- zoo::fortify.zoo(index, names = "index")
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
        (1-30) * (data$fgi)/(100) + 30
      )

      data$color_scale <- rev(color_scale)[
        data$color_scale
      ]

      plotly::layout(
        plotly::plot_ly(
          showlegend = FALSE,
          name = "FGI",
          data = data,
          y = ~fgi,
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
          text = "Fear and Greed Index",
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
