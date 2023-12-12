# script: scr_chart
# date: 2023-10-06
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Chart the quotes using
# plotly
# script start;

#' Create a candlestick chart
#'
#' This function returns a plotly kline chart with
#' the most common indicators.
#'
#' @param quote A cryptoQuote in xts/zoo format.
#' @param deficiency Logical. FALSE by default, if TRUE color defiency compliant
#' colors are used.
#' @param slider Logical. TRUE by default. If FALSE, no slider will be included.
#' @family charting
#' @returns Invisbly returns a plotly object.
#' @export

kline <- function(
    quote,
    deficiency = FALSE,
    slider = TRUE
) {

  # 1) Covnert the Quote
  # to data.frame
  quoteDF <- toDF(
    quote = quote
  )


  # 2) Create candlestick
  # plot
  plot <- plotly::plot_ly(
    data = quoteDF,
    showlegend = FALSE,
    name = attributes(quote)$interval,
    yaxis = 'y',
    x    = ~Index,
    type = 'candlestick',
    open = ~Open,
    close = ~Close,
    high  = ~High,
    low   = ~Low,
    increasing = list(
      line =list(color =ifelse(
        test = deficiency,
        yes = '#FFD700',
        no  = 'palegreen'
      )
      )
    ),
    decreasing = list(
      line =list(color =ifelse(
        test = deficiency,
        yes = '#0000ff',
        no  = 'tomato'
      )
      )
    )
  )




  plot_list <- list(
    main = plot
  )

  attributes(plot_list)$quote <- quote
  attributes(plot_list)$deficiency <- deficiency

  return(
    invisible(plot_list)
  )

}


#' chart quote using
#' ohlc bars
#'
#' @param quote A cryptoQuote in xts/zoo format.
#' @param deficiency Logical. FALSE by default, if TRUE color defiency compliant
#' colors are used.
#' @param slider Logical. TRUE by default. If FALSE, no slider will be included.
#' @family charting
#' @example man/examples/scr_charting.R
#'
#' @returns Invisbly returns a plotly object.
#' @export
ohlc <- function(
    quote,
    deficiency = FALSE,
    slider = TRUE
) {

  # 1) Covnert the Quote
  # to data.frame
  quoteDF <- toDF(
    quote = quote
  )


  # 2) Create candlestick
  # plot
  plot <- plotly::plot_ly(
    data = quoteDF,
    showlegend = FALSE,
    name = attributes(quote)$interval,
    yaxis = 'y',
    x    = ~Index,
    type = 'ohlc',
    open = ~Open,
    close = ~Close,
    high  = ~High,
    low   = ~Low,
    increasing = list(
      line =list(color =ifelse(
        test = deficiency,
        yes = '#FFD700',
        no  = 'palegreen'
      )
      )
    ),
    decreasing = list(
      line =list(color =ifelse(
        test = deficiency,
        yes = '#0000ff',
        no  = 'tomato'
      )
      )
    )
  )




  plot_list <- list(
    main = plot
  )

  attributes(plot_list)$quote <- quote
  attributes(plot_list)$deficiency <- deficiency

  return(
    invisible(plot_list)
  )

}





#' Chart your data
#'
#' @param chart A kline or ohlc chart with and without
#' indicators
#'
#' @param slider Logical. TRUE by default.
#' @family charting
#'
#' @example man/examples/scr_charting.R
#' @returns Returns a plotly object
#' @export
chart <- function(
    chart,
    slider = TRUE
) {
  suppressWarnings(
    {
      # 0) calculate number of
      # charts
      has_subplot <- length(chart) > 1

      if (has_subplot) {

        heights <- c(
          0.5,
          rep(
            x          = (1-0.5)/ (length(chart) - 1),
            length.out = length(chart) - 1
          )
        )

      } else {

        heights <- 1


      }


      quoteDF <- attributes(chart)$quote
      quote   <-  attributes(chart)$quote




      # 1) Main Chart
      chart <- plotly::subplot(
        chart,
        nrows = length(chart),
        shareX = TRUE,
        titleY = TRUE,
        heights = heights
      )


      chart <- chart %>% plotly::layout(
        margin = list(l = 60, r = 60, b = 110, t = 60),
        yaxis = list(
          title = 'Price'
        ),
        xaxis = list(
          rangeslider = list(
            visible = slider
            )
        ),
        showlegend = TRUE,
        legend = list(orientation = 'h', x = 0, y = 1.1),
        paper_bgcolor='rgba(0,0,0,0)',
        plot_bgcolor='rgba(0,0,0,0)'
      ) %>% plotly::add_annotations(
        x= 0,
        y= 1.05,
        xref = "paper",
        yref = "paper",
        text = paste(
          '<b>Ticker:</b>',
          attributes(quote)$tickerInfo$ticker,
          '<b>Interval:</b>', attributes(quote)$tickerInfo$interval, paste0('(', attributes(quote)$tickerInfo$market,')'),
          '<b>Exchange:</b>', attributes(quote)$tickerInfo$source),
        showarrow = FALSE,
        font = list(
          size = 18
        )

      )

      return(chart)
    }
  )

}








