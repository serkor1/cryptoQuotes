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
    title = "Basic Candlestick Chart",
    xaxis = list(rangeslider = list(visible = slider)),
    showlegend = FALSE,
    paper_bgcolor='rgba(0,0,0,0)',
    plot_bgcolor='rgba(0,0,0,0)'
    )


}





# script end;
