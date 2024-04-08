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
#' @param ... For internal use. Please ignore.
#'
#' @family price charts
#'
#' @example man/examples/scr_charting.R
#'
#' @returns
#'
#' Invisbly returns [plotly::plot_ly()]-object.
#'
#' @author Serkan Korkmaz
#'
#' @export
kline <- function(
    ...) {


  structure(
    .Data = {


      # 0) construct arguments
      # via chart function
      args <- list(
        ...
      )

      data <- indicator(args$data)


      #   # 1) bottom trace
      bot <- 3
      p <- plotly::plot_ly(
        data = data,
        x = ~index,
        type = 'candlestick',
        open = ~open,
        close = ~close,
        high = ~high,
        low = ~low,
        increasing = list(
          line = list(color = "black", width = bot),  # Border color and width
          fillcolor = "black"
        ),
        decreasing = list(
          line = list(color = "black", width = bot),  # Border color and width
          fillcolor = "black"
        ),
        showlegend = FALSE,
        name = "Border"
      )



      p <- plotly::add_trace(
        p,
        x = ~index,
        type = "candlestick",
        open = ~open,
        close = ~close,
        high = ~high,
        low = ~low,
        increasing = list(
          line = list(color = args$candle_color$bullish, width = bot - 1.75),  # Main candle color and narrower width
          fillcolor = args$candle_color$bullish
        ),
        decreasing = list(
          line = list(color = args$candle_color$bearish, width = bot - 1.75),    # Main candle color and narrower width
          fillcolor = args$candle_color$bearish
        ),
        showlegend = TRUE,
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


#' OHLC chart
#'
#' @inherit kline
#' @family price charts
#' @export
ohlc <- function(
    ...) {

  structure(
    .Data = {


      # 0) construct arguments
      # via chart function
      args <- list(
        ...
      )

      data <- indicator(args$data)


      #   # 1) bottom trace
      bot <- 5
      p <- plotly::plot_ly(
        data = data,
        x = ~index,
        type = 'ohlc',
        open = ~open,
        close = ~close,
        high = ~high,
        low = ~low,
        increasing = list(
          line = list(color = "black", width = bot),  # Border color and width
          fillcolor = "black"
        ),
        decreasing = list(
          line = list(color = "black", width = bot),  # Border color and width
          fillcolor = "black"
        ),
        showlegend = FALSE,
        name = "Border"
      )



      p <- plotly::add_trace(
        p,
        x = ~index,
        type = "ohlc",
        open = ~open,
        close = ~close,
        high = ~high,
        low = ~low,
        increasing = list(
          line = list(color = args$candle_color$bullish, width = bot - 3),  # Main candle color and narrower width
          fillcolor = args$candle_color$bullish
        ),
        decreasing = list(
          line = list(color = args$candle_color$bearish, width = bot - 3),    # Main candle color and narrower width
          fillcolor = args$candle_color$bearish
        ),
        showlegend = TRUE,
        name = args$interval
      )


      plotly::layout(
        p = p,
        xaxis = list(
          rangeslider = list(
            visible = args$slider,
            thickness    = 0.05
          )
        )
      )



    },
    class = c("pricechart", "plotly", "htmlwidget")
  )


}
