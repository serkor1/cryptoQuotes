# script: Bollinger Bands
# date: 2024-01-29
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create expressions to be evaluted in
# the charting function
# script start;

#' Add Bollinger Bands
#' to the chart
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' Bollinger Bands provide a visual representation of price volatility and are widely used by traders
#' and investors to assess potential price reversals and trade opportunities in various financial markets, including stocks, forex, and commodities.
#'
#'
#' @inheritParams TTR::BBands
#' @param internal An empty [list]. Used for internal purposes. Ignore.
#'
#' @example man/examples/scr_charting.R
#'
#'
#'
#' @returns Invisbly returns a plotly object.
#'
#' @family chart indicators
#'
#' @export
bollinger_bands <- function(
    n = 20,
    sd = 2,
    maType = "SMA",
    color  = '#F100F1',
    ...){


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
            line =list(
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
              color =color,
              dash ='dot',
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
        fillcolor = hex_to_rgb_string(alpha = 0.1, hex_color = color),
        line = list(
          color = "transparent"
        ),
        name = paste0("BB(", paste(c(n, sd, maType), collapse = ", "), ")")
      )


      plot <- build(
        plot = plot,
        layers = layers
      )

      plot



    },
    class = c(
      "indicator",
      "plotly",
      "htmlwidget"
    )
  )

}
# script end;
