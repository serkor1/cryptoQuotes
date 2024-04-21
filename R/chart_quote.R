#' Candlestick chart
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' A high-level [plotly::plot_ly()]-wrapper function for charting Open, High, Low and Close prices.
#'
#' @param ... For internal use. Please ignore.
#'
#' @family price charts
#'
#' @example man/examples/scr_charting.R
#'
#' @returns
#'
#' A [plotly::plot_ly()]-object.
#'
#' @author Serkan Korkmaz
#'
#' @export
kline <- function(
    ...) {

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
        legendgroup = "price",
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


#' OHLC chart
#'
#' @inherit kline
#' @family price charts
#' @export
ohlc <- function(
    ...) {

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
        name = "Border",
        legendgroup = "price"
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
        name = args$interval,
        legendgroup = "price"
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
