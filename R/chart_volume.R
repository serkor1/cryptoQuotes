# script:
# date: 2024-01-29
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;

#' Add volume indicators
#' to the chart
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' Volume indicators are technical analysis tools used to analyze trading volume, which represents the number of shares or contracts traded in a financial market over a specific period of time.
#' These indicators provide valuable insights into the strength and significance of price movements.
#'
#' @param internal An empty [list]. Used for internal purposes. Ignore.
#'
#' @returns Invisbly returns a plotly object.
#'
#' @example man/examples/scr_charting.R
#'
#' @family chart indicators
#' @family subcharts
#'
#' @export
volume <- function(
    ...){


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

      # 0.4) linewidth
      linewidth <- 0.90

      plot <- plotly::layout(
        plotly::plot_ly(
        data = args$data,
        name = "Volume",
        x    = ~index,
        y    = ~volume,
        showlegend = FALSE,
        color = ~direction,
        type  = "bar",
        colors = c(
          args$candle_color$bearish,
          args$candle_color$bullish

        ),
        marker = list(
          line = list(
            color = "black",
            width = 0.5)
        )
      ),
      annotations = list(
        text = "Volume",
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
    class = c("subchart", "plotly", "htmlwidget")

  )


}

# script end;
