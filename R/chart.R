# script: scr_chart
# date: 2023-10-06
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Chart the quotes using
# plotly
# script start;

#' Create a candlestick chart
#' with volume and bollinger bands
#'
#' This function returns a plotly candlestick with
#' the most common indicators.
#' @param quote A cryptoQuote in xts/zoo format.
#' @param deficiency Logical. FALSE by default, if TRUE color defiency compliant
#' colors are used.
#' @param slider Logical. TRUE by default. If FALSE, no slider will be included.
#'
#' @returns a plotly object
#' @export

chart <- function(
    quote,
    deficiency = FALSE,
    slider = TRUE
    ) {

  # 1) convert quote
  # to data.frame
  quote_ <- as.data.frame(
    quote
  )

  # 2) determine
  # wether it closed
  # above or below
  quote_$direction <- ifelse(
    quote_$Close > quote_$Open,
    yes = 'Increasing',
    no  = 'Decreasing'
  )

  # 2) Create candlestick
  candlestick <- plotly::plot_ly(
    data = quote_,
    name = 'Price',
    x    = rownames(quote_),
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

  quote_ <- cbind(
    quote_,
    TTR::BBands(
      HLC = quote[,2:4],
      n = min(
        20,
        max(5, floor(nrow(quote_)/2))
      )
    )
  )


    candlestick <- candlestick %>% plotly::add_lines(
      data = quote_,
      x = rownames(quote_),
      y = ~up,
      line = list(
        color ='steelblue'
      ),
      inherit = FALSE
    ) %>% plotly::add_lines(
      data = quote_,
      x = rownames(quote_),
      y = ~dn,
      fill = 'tonexty',
      fillcolor = 'rgba(168, 216, 234, 0.2)',
      line = list(
        color ='steelblue'
      ),
      inherit = FALSE
    ) %>% plotly::add_lines(
      data = quote_,
      x = rownames(quote_),
      y = ~mavg,
      line = list(
        dash ='dot',
        color = 'steelblue'
      ),
      inherit = FALSE
    )




  # 3) create volume
  # plot
  volume <- plotly::plot_ly(
    data = quote_,
    name = 'Volume',
    x = rownames(quote_),
    y = ~Volume,
    type = 'bar',
    color = ~direction,
    colors = c(
      ifelse(
        test = deficiency,
        yes = '#FFD700',
        no  = 'tomato'
      ),
      ifelse(
        test = deficiency,
        yes = '#0000ff',
        no  = 'palegreen'
      )
    )
  )



  # 4) generate plot
  plot <- plotly::subplot(
    candlestick,
    volume,
    heights = c(0.7,0.2),
    nrows=2,
    shareX = TRUE,
    titleY = TRUE
  )

  plot %>% plotly::layout(
    yaxis = list(
      title = 'Price'
    ),
    xaxis = list(

      rangeslider = list(visible = slider),
      tickvals = seq(
        from = 0,
        to   = nrow(quote_),
        by   = ceiling(nrow(quote_)/24)
      )
                 ),
    showlegend = FALSE,
    paper_bgcolor='rgba(0,0,0,0)',
    plot_bgcolor='rgba(0,0,0,0)'
    ) %>% plotly::add_annotations(
      x= 0,
      y= 1,
      xref = "paper",
      yref = "paper",
      #text = "<b>Ticker:</b>",
      text = paste('<b>Ticker:</b>', attributes(quote)$ticker, '<b>Interval:</b>', attributes(quote)$interval, paste0('(', attributes(quote)$market,')'), '<b>Exchange:</b>', attributes(quote)$source),
      showarrow = FALSE,
      font = list(
        size = 18
      )

    )


}

