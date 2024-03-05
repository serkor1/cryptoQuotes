#' Candlestick chart
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' Candlestick charts are highly visual and provide a quick and intuitive way to assess market sentiment and price action.
#' Traders and analysts use them in conjunction with other technical analysis tools to make informed trading decisions.
#' These charts are particularly useful for identifying key support and resistance levels, trend changes, and potential entry and exit points in financial markets.
#'
#' @param internal An empty [list]. Used for internal purposes. Ignore.
#'
#' @family price charts
#'
#' @example man/examples/scr_charting.R
#'
#' @returns
#'
#' A [plotly::plot_ly()]-object wrapped in [rlang::expr()].
#'
#' @author Serkan Korkmaz
#'
#' @export
kline <- function(
    internal = list()) {
  structure(
    rlang::expr(
      {
        # 0) locate global
        # parameters to be passed
        # into the charting functions;

        # internal_args <- flatten(lapply(!!rlang::enquos(internal), rlang::eval_tidy))
        internal_args <- flatten(lapply(!!rlang::enexpr(internal), rlang::eval_tidy))

        ticker     <- internal_args$ticker
        interval   <- internal_args$interval
        deficiency <- internal_args$deficiency



        candle_color <- movement_color(
          deficiency = deficiency
        )


        candle_color <- movement_color(
          deficiency = deficiency
        )

        plotly::layout(
          p =  plotly::plot_ly(
            data = ticker,
            showlegend = TRUE,
            name = interval,
            yaxis = 'y',
            x    = ~Index,
            type = 'candlestick',
            open = ~Open,
            close = ~Close,
            high  = ~High,
            low   = ~Low,
            increasing = list(
              line = list(
                color = candle_color$bullish
              ),
              fillcolor = candle_color$bullish
            ),
            decreasing = list(
              line = list(
                color =candle_color$bearish
              ),
              fillcolor = candle_color$bearish
            )
          ),
          yaxis = list(
            title = "Price"
          )
        )






      }
    ),
    class = c("pricechart", "chartelement")
  )

}


#' OHLC chart
#'
#' @inherit kline
#' @family price charts
#' @export
ohlc <- function(
    internal = list()) {

  structure(
    rlang::expr(
      {
        # 0) locate global
        # parameters to be passed
        # into the charting functions;

        # internal_args <- flatten(lapply(!!rlang::enquos(internal), rlang::eval_tidy))
        internal_args <- flatten(lapply(!!rlang::enexpr(internal), rlang::eval_tidy))

        ticker <- internal_args$ticker
        interval   <- internal_args$interval
        deficiency <- internal_args$deficiency



        candle_color <- movement_color(
          deficiency = deficiency
        )

        plotly::layout(
          p =  plotly::plot_ly(
            data = ticker,
            showlegend = TRUE,
            name = interval,
            yaxis = 'y',
            x    = ~Index,
            type = 'ohlc',
            open = ~Open,
            close = ~Close,
            high  = ~High,
            low   = ~Low,
            increasing = list(
              line = list(
                color = candle_color$bullish
              )
            ),
            decreasing = list(
              line = list(
                color =candle_color$bearish
              )
            )
          ),
          yaxis = list(title = "Price")
        )




      }

    ),
    class = c("pricechart", "chartelement")
  )


}
