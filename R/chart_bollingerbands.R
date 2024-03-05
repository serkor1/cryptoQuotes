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
    internal = list(),
    ...){

  structure(
    rlang::expr(
      {


        # 0) locate global
        # parameters to be passed
        # into the charting functions;

        # internal_args <- flatten(lapply(!!rlang::enquos(internal), rlang::eval_tidy))
        internal_args <- flatten(
          lapply(!!rlang::enexpr(internal), rlang::eval_tidy)
          )

        ticker <- internal_args$ticker
        deficiency <- internal_args$deficiency
        chart  <- internal_args$chart



        candle_color <- movement_color(
          deficiency = deficiency
        )

        # 0.3) band color
        color <- '#F100F1'

        # 0.4) linewidth
        linewidth <- 0.90

        # 1) calculate MACD
        # indicator
        indicator_ <- toDF(
          TTR::BBands(
            HLC = toQuote(ticker)[, c("High", "Low", "Close")],
            n = !!n,
            maType = !!maType,
            ... = !!rlang::enquos(...)
          )
        )

        chart <- plotly::add_ribbons(
          showlegend = TRUE,
          p = chart,
          inherit = FALSE,
          x = ~Index,
          ymin = ~dn,
          ymax = ~up,
          data = indicator_,
          fillcolor = 'rgba(241,0,241,0.1)',
          line = list(
            color = "transparent"
          ),
          name = "Bollinger Bands"
        )

        # 2) add middle band
        chart <- plotly::add_lines(
          p= plotly::add_lines(
            p =plotly::add_lines(
              showlegend = TRUE,
              p = chart,
              inherit = FALSE,
              data = indicator_,
              x = ~Index,
              y = ~mavg,
              line = list(
                color =color,
                dash ='dot',
                width = linewidth
              ),
              name = "Moving Average"
            ),
            name = "Upper Band",
            inherit = FALSE,
            x = ~Index,
            y = ~up,
            line = list(
              color = color,
              width = linewidth
            )
          ),
          inherit = FALSE,
          name = "Lower Band",
          x = ~Index,
          y = ~dn,
          line = list(
            color = color,
            width = linewidth
          )
        )

        chart

      }
    ),
    class = "indicator"
  )

}
# script end;
