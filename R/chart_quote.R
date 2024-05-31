#' @title
#' Candlestick Chart
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' A high-level [plotly::plot_ly()]-function for charting
#' Open, High, Low and Close prices.
#'
#' @param ... For internal use. Please ignore.
#'
#' @example man/examples/scr_klinechart.R
#'
#' @returns
#' An [invisible] [plotly::plot_ly()]-object.
#'
#' @family price charts
#' @author Serkan Korkmaz
#' @export
kline <- function(
    ...) {

  # check if the indicator is called
  # from the chart-function
  #
  # stops the function if not
  check_indicator_call()

  structure(
    .Data = {

      # 0) construct arguments
      # via chart function
      args <- list(...)
      data <- indicator(args$data)

      #   # 1) bottom trace
      bot <- 3
      p <- plotly::plot_ly(
        data = data,
        x = ~index,
        type = 'candlestick',
        hoverinfo = "none",
        open = ~open,
        close = ~close,
        high = ~high,
        low = ~low,
        increasing = list(
          # Border color and width
          line = list(color = "black", width = bot),
          fillcolor = "black"
        ),
        decreasing = list(
          # Border color and width
          line = list(color = "black", width = bot),
          fillcolor = "black"
        ),
        showlegend = FALSE,
        legendgroup = "price",
        name = "Border"
      )



      p <- plotly::add_trace(
        p,
        inherit = FALSE,
        x = ~index,
        type = "candlestick",
        open = ~open,
        close = ~close,
        high = ~high,
        low = ~low,
        increasing = list(
          # Main candle color and narrower width
          line = list(color = args$candle_color$bullish, width = bot - 1.75),
          fillcolor = args$candle_color$bullish
        ),
        decreasing = list(
          # Main candle color and narrower width
          line = list(color = args$candle_color$bearish, width = bot - 1.75),
          fillcolor = args$candle_color$bearish
        ),
        showlegend = TRUE,
        legendgroup = "price",
        name = args$interval
      )


      invisible(
        {
          plotly::layout(
            p = p,
            xaxis = list(
              rangeslider = list(
                visible = args$slider,
                thickness    = 0.05
              )
            )
          )
        }
      )




    },
    class = c("pricechart", "plotly", "htmlwidget")
  )

}


#' @title
#' OHLC Barchart
#'
#' @inherit kline
#'
#' @example man/examples/scr_ohlcchart.R
#'
#' @family price charts
#' @author Serkan Korkmaz
#' @export
ohlc <- function(
    ...) {

  # check if the indicator is called
  # from the chart-function
  #
  # stops the function if not
  check_indicator_call()

  structure(
    .Data = {

      # 0) construct arguments
      # via chart function
      args <- list(...)
      data <- indicator(args$data)

      #   # 1) bottom trace
      bot <- 5
      p <- plotly::plot_ly(
        data        = data,
        x           = ~ index,
        type        = 'ohlc',
        open        = ~ open,
        hoverinfo   = "none",
        close       = ~ close,
        high        = ~ high,
        low         = ~ low,
        increasing  = list(
          # Border color and width
          line      = list(color = "black", width = bot),
          fillcolor = "black"
        ),
        decreasing  = list(
          # Border color and width
          line      = list(color = "black", width = bot),
          fillcolor = "black"
        ),
        showlegend  = FALSE,
        name        = "Border",
        legendgroup = "price"
      )

      p <- plotly::add_trace(
        p           = p,
        x           = ~ index,
        inherit     = FALSE,
        type        = "ohlc",
        open        = ~ open,
        close       = ~ close,
        high        = ~ high,
        low         = ~ low,
        increasing  = list(
          # Main candle color and narrower width
          line      = list(color = args$candle_color$bullish, width = bot - 3),
          fillcolor = args$candle_color$bullish
        ),
        decreasing  = list(
          # Main candle color and narrower width
          line      = list(color = args$candle_color$bearish, width = bot - 3),
          fillcolor = args$candle_color$bearish
        ),
        showlegend  = TRUE,
        name = args$interval,
        legendgroup = "price"
      )

      plotly::layout(
        p     = p,
        xaxis = list(
          rangeslider = list(
            visible   = args$slider,
            thickness = 0.05
          )
        )
      )
    },

    class = c("pricechart", "plotly", "htmlwidget")
  )
}

#' @title
#' Line Chart
#'
#' @inherit kline
#'
#' @param price A [character]-vector of [length] 1. "close" by default.
#'
#' @example man/examples/scr_plinechart.R
#'
#' @family price charts
#' @author Serkan Korkmaz
#' @export
pline <- function(
    price = "close",
    ...) {

  # check if the indicator is called
  # from the chart-function
  #
  # stops the function if not
  check_indicator_call()

  structure(
    .Data = {

      # 0) arguments passed
      # via the chart function
      args <- list(...)

      data <- indicator(args$data, columns = price)

      p <- plotly::plot_ly(
        data = data,
        x    = ~index,
        y    = stats::as.formula(
          paste("~", price)
        ),
        type = "scatter",
        mode = "lines",
        showlegend = TRUE,
        legendgroup = "price",
        name        = paste0(
          to_title(price),
          " (", args$interval, ")"
        ),
        line = list(
          width = 1.2,
          color = "#d38b68"# was: "#d3ba68"
        )
      )

      invisible({
        plotly::layout(
          p = p,
          xaxis = list(
            rangeslider = list(
              visible = args$slider,
              thickness    = 0.05
            )
          )
        )
      })

    },
    class = c("pricechart", "plotly", "htmlwidget")
  )

}
