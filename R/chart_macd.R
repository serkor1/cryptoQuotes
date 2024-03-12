# script: Moving Average Convergence Divergence (MACD)
# indicators
# date: 2024-01-29
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create expressions to be evaluted in
# the charting function
# script start;

#' Add MACD indicators to the chart
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' Traders and investors use the MACD indicator to identify trend changes, potential reversals, and overbought or oversold conditions in the market.
#' It is a versatile tool that can be applied to various timeframes and asset classes, making it a valuable part of technical analysis for many traders.
#'
#' @inheritParams TTR::MACD
#' @param internal An empty [list]. Used for internal purposes. Ignore.
#'
#' @example man/examples/scr_charting.R
#'
#' @returns Invisbly returns a plotly object.
#'
#' @family chart indicators
#' @family subcharts
#'
#' @export
macd <- function(
    nFast   = 12,
    nSlow   = 26,
    nSig    = 9,
    maType  = "SMA",
    percent = TRUE,
    internal = list(),
    ...){


  structure(
    rlang::expr(
      {
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

        # 1) calculate MACD
        # indicator
        indicator_ <- toDF(
          TTR::MACD(
            x = toQuote(ticker)[,grep(pattern = 'close', x = colnames(ticker))],
            nFast    = !!nFast,
            nSlow    = !!nSlow,
            nSig     = !!nSig,
            maType   = !!maType,
            percent  = !!percent,
            !!rlang::enquos(...)
          )
        )

        indicator_$direction <- as.logical(
          indicator_$signal >= indicator_$macd
        )

        # 2) create plot
        # without using pipes;
        p <- plotly::plot_ly(
          data       = indicator_,
          showlegend = FALSE,
          name       = 'MACD',
          x          = ~ index,
          y          = ~ (macd - signal),
          color      = ~ direction,
          colors     = c(
            # The first color always
            # applies to the true condition
            candle_color$bullish,
            candle_color$bearish),
          type       = 'bar',
          marker     = list(line = list(
            color = "black",
            width = 0.5
          ))
        )

        layers <- list(
          list(
            type = "add_lines",
            params = list(
              name = "MACD: Signal",
              data = indicator_,
              showlegend = FALSE,
              x = ~ index,
              y = ~ signal,
              inherit = FALSE,
              line = list(width = linewidth)
            )

          ),
          list(
            type = "add_lines",
            params = list(
              name = "MACD: MACD",
              data = indicator_,
              showlegend = FALSE,
              x = ~ index,
              y = ~ macd,
              inherit = FALSE,
              line = list(width = linewidth)
            )

          )
        )


        p <- build(
          plot = p,
          layers = layers,
          annotations = list(
            list(
              text = paste0("MACD(",paste(c(!!nFast, !!nSlow,!!nSig), collapse = ','), ")"),
              x = 0.01,
              y = 1,
              xref = 'paper',
              yref = 'paper',
              showarrow = FALSE
            )
          ),
          yaxis = list(
            title = NA
          )
        )


        p


      }
    ),
    class = c("subchart")
  )

}

# script end;
