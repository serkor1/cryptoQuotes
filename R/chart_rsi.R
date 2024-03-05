# script: Relative Strength Index (RSI)
# indicator
# date: 2024-01-29
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create expressions to be evaluted in
# the charting function
# script start;
#' Add RSI indicators to your
#' chart
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' The RSI can be customized with different look-back periods to suit various trading strategies and timeframes.
#' It is a valuable tool for assessing the momentum and relative strength of an asset, helping traders make more informed decisions in financial markets.
#'
#' @inheritParams TTR::RSI
#' @param upper_limit A [numeric]-vector of length 1. 80 by default. Sets the upper limit of the [TTR::RSI].
#' @param lower_limit A [numeric]-vector of length 1. 20 by default. Sets the lower limit of the [TTR::RSI].
#' @param internal An empty [list]. Used for internal purposes. Ignore.
#'
#' @returns Invisbly returns a plotly object.
#'
#' @example man/examples/scr_charting.R
#'
#'
#' @family chart indicators
#' @family subcharts
#'
#' @export
rsi <- function(
    n = 14,
    maType = "SMA",
    upper_limit = 80,
    lower_limit = 20,
    internal = list(),
    ...){

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

        # 0.3) band color
        color <- '#F100F1'

        # 0.4) linewidth
        linewidth <- 0.90

        indicator <- toDF(
          TTR::RSI(
            price    = toQuote(ticker)[,"Close"],
            n        = !!n,
            maType   = !!maType,
            ...      = !!rlang::enquos(...)
          )
        )


        plotly::layout(p = plotly::add_ribbons(
          # RSI plot: upper lline
          plotly::add_lines(
            # Lower line
            p = plotly::add_lines(
              # RSI
              p = plotly::plot_ly(
                name = "RSI",
                data = indicator,
                mode = "lines",
                showlegend = TRUE,
                type = "scatter",
                x = ~Index,
                y = ~rsi,
                line = list(
                  color = color,
                  width = linewidth
                )
              ),
              showlegend = FALSE,
              name = "Upper Bound",
              x = ~Index,
              y = !!upper_limit,
              line = list(
                color = color,
                dash ='dot',
                width = linewidth
              )
            ),
            showlegend = FALSE,
            name = "Lower Bound",
            x = ~Index,
            y = !!lower_limit,
            line = list(
              color = color,
              dash ='dot',
              width = linewidth
            )
          ),
          showlegend = FALSE,
          data = ticker,
          x = ~Index,
          ymin = !!lower_limit,
          ymax = !!upper_limit,
          line = list(color = 'rgba(0,0,0,0)'), # Transparent lines
          fillcolor = "rgba(241,0,241,0.1)"
        ),
        yaxis = list(
          title = 'RSI',
          range = c(0, 100)
        )
        )



      }


    ),
    class = "subchart"
  )

}
# script end;
