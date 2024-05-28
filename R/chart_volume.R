# script:
# date: 2024-01-29
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;

#' @title
#' Chart the trading volume
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' A high-level [plotly::plot_ly()]-function.
#' The function adds a subchart with the trading `trading`.
#'
#' @inherit kline
#'
#' @example man/examples/scr_charting.R
#'
#' @family chart indicators
#' @family subchart indicators
#' @author Serkan Korkmaz
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

      data <- indicator(
        x = args$data
      )

      plot <- plotly::layout(
        plotly::plot_ly(
        data = data,
        name = "Volume",
        x    = ~index,
        y    = ~volume,
        showlegend = FALSE,
        color = ~ as.factor(candle),
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
