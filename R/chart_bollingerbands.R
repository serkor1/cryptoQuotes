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
            HLC = toQuote(ticker)[, grep(pattern = 'high|low|close', x = colnames(ticker),ignore.case = TRUE)],
            n = !!n,
            maType = !!maType,
            ... = !!rlang::enquos(...)
          )
        )



        layers <- list(
          # middle line
          list(
            type = "add_lines",
            params = list(
              showlegend = FALSE,legendgroup = 'bb',
              name = "Lower",
              inherit = FALSE,
              data = indicator_,
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
              data = indicator_,
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
              name = paste(!!maType),
              inherit = FALSE,
              data = indicator_,
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

        chart <- plotly::add_ribbons(
          showlegend = TRUE,
          legendgroup = 'bb',
          p = chart,
          inherit = FALSE,
          x = ~index,
          ymin = ~dn,
          ymax = ~up,
          data = indicator_,
          fillcolor = 'rgba(241,0,241,0.1)',
          line = list(
            color = "transparent"
          ),
          name = paste0("BB(", paste(c(!!n, !!sd), collapse = ", "), ")")
        )


        chart <- build(
          plot = chart,
          layers = layers
        )

        chart

      }
    ),
    class = "indicator"
  )

}
# script end;
