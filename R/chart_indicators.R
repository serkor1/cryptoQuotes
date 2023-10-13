# script: indicators;
# date: 2023-10-11
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Generate indictors
# that are compatible with
# plotly
# script start;

#' Add Bollinger Bands indicators
#' to the charts
#'
#' @param plot a kline, or OHLC, chart.
#' @param cols a vector of column names for the
#' Bollinger bands calculations.
#' @param ... See [TTR::BBands()]
#'
#' @returns NULL
#' @export
addBBands <- function(
    plot,
    cols = c('High', 'Low', 'Close'),
    ...
) {


  ## 1) convert the embedded
  ## data.frame in the plot
  ## to xts, zoo object
  quote <- toQuote(
    attributes(plot)$quote
  )

  ## 2) extract the main chart
  ## and store it it as plot_
  plot_ <- plot$main

  ## 3) calculate the bollinger
  ## bands using TTR and store
  ## it as indicator.
  indicator <- toDF(
    TTR::BBands(
      HLC = quote[
        ,
        which(
          sapply(
            colnames(quote),
            grepl,
            pattern = paste0(cols, collapse = '|'),
            ignore.case = TRUE
          )
        )
      ],
      ...
    )
  )

  ## 4) add the indicator
  ## to main plot_
  plot_ <- plot_ %>%
    plotly::add_lines(
      data = indicator,
      x = ~Index,
      y = ~up,
      line = list(
        color ='steelblue'
      ),
      inherit = FALSE
    ) %>%
    plotly::add_lines(
      data = indicator,
      x = ~Index,
      y = ~dn,
      fill = 'tonexty',
      fillcolor = 'rgba(168, 216, 234, 0.1)',
      line = list(
        color ='steelblue'
      ),
      inherit = FALSE
    ) %>%
    plotly::add_lines(
      data = indicator,
      x = ~Index,
      y = ~mavg,
      line = list(
        dash ='dot',
        color = 'steelblue'
      ),
      inherit = FALSE
    )

  ## 5) store plot_
  ## in the plot list
  ## in main
  plot$main <- plot_

  ## 6) pass the quote on
  ## to the attributes of the
  ## for further indicator plots
  attributes(plot)$quote <- toDF(
    quote
  )


  ## 7) return
  ## the plot invisibly
  ## to force enduser
  ## to use chart-function
  return(
    invisible(plot)
  )

}


#' Add volume indicator
#' to the chart
#'
#'
#' @param plot A plotly object of either
#' klines or OHLC
#'
#' @returns NULL
#' @export
addVolume <- function(plot) {

  ## 1) extract the data
  ## and deficieny attribute
  ## fron the main plt.
  quoteDF <- attributes(plot)$quote
  deficiency <- attributes(plot)$deficiency


  ## 2) create volume
  ## plot and store it
  ## as plot_
  plot_ <- plotly::plot_ly(
    data = quoteDF,
    name = 'Volume',
    x = ~Index,
    y = ~Volume,
    color = ~direction,
    type = 'bar',
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
    ),
    marker = list(
      line = list(
        color = 'rgb(8,48,107)',
        width = 0.5)
    )
  )

  ## 3) store the volume
  ## plot_ in the plot list
  plot$volume <- plot_

  ## 4) pass on the data
  ## as is in the the quote
  ## attribute of the plot
  ## so it can be used in the additional
  ## plot
  attributes(plot)$quote <- attributes(plot)$quote


  return(
    invisible(plot)
  )


}


#' Add MACD indicator to the chart
#'
#' @param plot A plotly object of either
#' klines or OHLC
#'
#' @param ... See [TTR::MACD()]
#'
#' @export
addMACD <- function(
    plot,
    ...
) {

  # 1) Extract
  quoteDF <- attributes(plot)$quote
  deficiency <- attributes(plot)$deficiency

  # 2) calculate MACD
  indicator <- toDF(
    TTR::MACD(
      toQuote(
        quoteDF
      )[,'Close'],
      ...
    )
  )

  indicator$direction <- as.logical(
    indicator$macd > indicator$signal
  )

  plot_ <- plotly::plot_ly(
    data = indicator,
    name = 'MACD',
    x    = ~Index,
    y    = ~(macd - signal),
    color = ~direction,
    type = 'bar',
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
    ),
    marker = list(
      line = list(
        color = 'rgb(8,48,107)',
        width = 0.5)
    )
  ) %>% plotly::add_lines(
    data = indicator,
    x = ~Index,
    y = ~signal,
    inherit = FALSE
  ) %>% plotly::add_lines(
    data = indicator,
    x = ~Index,
    y = ~macd,
    inherit = FALSE
  )  %>% plotly::layout(
    yaxis = list(
      title = 'MACD'
    )
  )

  plot$macd <- plot_
  attributes(plot)$quote <- attributes(plot)$quote

  return(
    invisible(plot)
  )


}



#' Add various Moving Average indicators
#' to the chart.
#'
#' @param plot A plotly object of either
#' klines or OHLC
#' @param FUN A named function calculating MAs. See [TTR::MACD()]
#' @param ... See [TTR::MACD()]
#'
#'
#' @export
addMA <- function(plot, FUN = TTR::SMA, ...) {

  quote <- toQuote(
    attributes(plot)$quote
  )

  # 1) extract the main
  # chart from the plot
  plot_ <- plot$main

  foo <- match.fun(
    FUN = FUN
  )
  quote_ <- toDF(foo(
    quote[,'Close']
  ),
  ...
  )

  colnames(quote_)[!grepl(colnames(quote_), pattern = 'Index', ignore.case =TRUE)] <- 'value'

  plot_ <- plot_ %>% plotly::add_lines(
    data = quote_,
    x = ~Index,
    y = ~value,
    inherit = FALSE
  )

  plot$main <- plot_
  attributes(plot)$quote <- toDF(quote)

  return(
    invisible(plot)
  )

}




#' Add RSI indicators to your
#' chart
#'
#' Adds RSI to the chart
#' @param plot A plotly object of either
#' klines or OHLC
#'
#' @param ... See [TTR::RSI()]
#' @returns NULL
#' @export
addRSI <- function(
    plot,
    ...) {

  quote <- toQuote(attributes(plot)$quote)
  deficiency <- attributes(plot)$deficiency
  # 3) create volume
  # plot

  quoteDF <- toDF(
    TTR::RSI(
      quote[,'Close']
    )
  )


  plot_ <- plotly::plot_ly(
    data = quoteDF,
    name = 'RSI',
    x = ~Index,
    y = ~rsi,
    mode = 'lines',
    type = 'scatter',
    color = I('steelblue')
  ) %>% plotly::add_ribbons(
    ymin = 20,
    ymax = 80,
    alpha = 0.1,
    color = I('steelblue'),
    line = list(
      dash = 'dot'
    )
  ) %>% plotly::layout(
    yaxis = list(
      title = 'RSI'
    )
  )

  plot$rsi <- plot_

  attributes(plot)$quote <- attributes(plot)$quote


  return(
    invisible(plot)
  )



}




# script end;
