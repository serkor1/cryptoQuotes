# script: Bollinger Bands
# date: 2024-01-29
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create expressions to be evaluted in
# the charting function
# script start;
#' @title
#' Add Bollinger Bands
#' to the chart
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' A high-level [plotly::add_lines()]-wrapper function that interacts
#' with the [TTR::BBands()]-function. The function adds bollinger bands
#' to the main [chart()].
#'
#' @usage bollinger_bands(
#'    n = 20,
#'    sd = 2,
#'    maType = "SMA",
#'    color  = '#4682b4',
#'    ...
#' )
#'
#' @inheritParams TTR::BBands
#' @param color A [character]-vector of [length] 1. "#4682b4" by default.
#'
#' @inherit kline
#'
#' @family chart indicators
#' @family main chart indicators
#' @author Serkan Korkmaz
#' @export
bollinger_bands <- function(
  n = 20,
  sd = 2,
  maType = "SMA",
  color = '#4682b4',
  ...
) {
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

      # # 1) unpack all elements
      # # of the args
      # data <- args$data

      # 0.4) linewidth
      linewidth <- 0.90

      # 1) calculate MACD
      # indicator
      data <- indicator(
        x = args$data,
        columns = c("high", "low", "close"),
        .f = TTR::BBands,
        n = n,
        sd = sd,
        maType = maType
      )

      layers <- list(
        # middle line
        list(
          type = "add_lines",
          params = list(
            showlegend = FALSE,
            legendgroup = 'bb',
            name = "Lower",
            inherit = FALSE,
            data = data,
            x = ~index,
            y = ~dn,
            line = list(
              color = color,
              width = linewidth
            )
          )
        ),

        list(
          type = "add_lines",
          params = list(
            showlegend = FALSE,
            legendgroup = 'bb',
            name = "Upper",
            inherit = FALSE,
            data = data,
            x = ~index,
            y = ~up,
            line = list(
              color = color,
              width = linewidth
            )
          )
        ),

        list(
          type = "add_lines",
          params = list(
            showlegend = FALSE,
            legendgroup = 'bb',
            name = paste(maType),
            inherit = FALSE,
            data = data,
            x = ~index,
            y = ~mavg,
            line = list(
              color = color,
              dash = 'dot',
              width = linewidth
            )
          )
        )
      )

      plot <- plotly::add_ribbons(
        showlegend = TRUE,
        legendgroup = 'bb',
        p = args$plot,
        inherit = FALSE,
        x = ~index,
        ymin = ~dn,
        ymax = ~up,
        data = data,
        fillcolor = as_rgb(alpha = 0.1, hex_color = color),
        line = list(
          color = "transparent"
        ),
        name = paste0("BB(", paste(c(n, sd, maType), collapse = ", "), ")")
      )

      plot <- build(
        plot = plot,
        layers = layers
      )

      invisible(
        plot
      )
    },
    class = c(
      "indicator",
      "plotly",
      "htmlwidget"
    )
  )
}
# script end;
