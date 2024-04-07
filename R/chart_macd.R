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

      # 1) unpack all elements
      # of the args
      #data <- args$data


      # 0.4) linewidth
      linewidth <- 0.90

      # 1) calculate MACD
      # indicator
      data <- indicator(
        x = args$data,
        columns = "close",
        .f = TTR::MACD,
        nFast    = nFast,
        nSlow    = nSlow,
        nSig     = nSig,
        maType   = maType,
        percent  = percent

      )


      data$direction <- as.logical(
        data$signal >= data$macd
      )

      # 2) create plot
      # without using pipes;
      p <- plotly::plot_ly(
        data       = data,
        showlegend = FALSE,
        name       = 'MACD',
        x          = ~ index,
        y          = ~ (macd - signal),
        color      = ~ direction,
        colors     = c(
          # The first color always
          # applies to the true condition
          args$candle_color$bullish,
          args$candle_color$bearish),
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
            data = data,
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
            data = data,
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
            text = paste0("MACD(",paste(c(nFast, nSlow,nSig), collapse = ', '), ")"),
            x = 0,
            y = 1,
            font = list(
              size = 18
            ),
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




    },
    class = c("subchart", "plotly", "htmlwidget")
  )

}

# script end;
