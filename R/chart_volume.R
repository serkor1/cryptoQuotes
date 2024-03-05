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
volume <- function(internal = list()){

  structure(
    rlang::expr(
      {
        # 0) locate global
        # parameters to be passed
        # into the charting functions;

        # internal_args <- flatten(lapply(!!rlang::enquos(internal), rlang::eval_tidy))
        internal_args <- flatten(lapply(!!rlang::enexpr(internal), rlang::eval_tidy))

        ticker <- internal_args$ticker
        deficiency <- internal_args$deficiency



        candle_color <- movement_color(
          deficiency = deficiency
        )

        # 0.4) linewidth
        linewidth <- 0.90

        plot <- plotly::plot_ly(
          data = ticker,
          name = "Volume",
          x    = ~Index,
          y    = ~Volume,
          showlegend = FALSE,
          color = ~direction,
          type  = "bar",
          colors = c(
            candle_color$bearish,
            candle_color$bullish

          ),
          marker = list(
            line = list(
              color = "black",
              width = 0.5)
          )
        )
      }
    ),
    class = "subchart"
  )






}

# script end;
