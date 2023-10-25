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
#'
#' @description
#' A short description...
#'
#' `r lifecycle::badge("experimental")`
#'
#'
#' @param plot a kline, or OHLC, chart.
#' @param cols a vector of column names for the
#' Bollinger bands calculations.
#' @param ... See [TTR::BBands()]

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
  quote <- (
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
      showlegend = FALSE,
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
      showlegend = FALSE,
      fill = 'tonexty',
      fillcolor = 'rgba(168, 216, 234, 0.1)',
      line = list(
        color ='steelblue'
      ),
      inherit = FALSE
    ) %>%
    plotly::add_lines(
      showlegend = FALSE,
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
  attributes(plot)$quote <- attributes(plot)$quote


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
#' @description
#' A short description...
#'
#' `r lifecycle::badge("experimental")`
#'
#' @param plot A plotly object of either
#' klines or OHLC
#'
#' @returns NULL
#' @example man/examples/scr_charting.R
#' @export
addVolume <- function(plot) {

  ## 1) extract the data
  ## and deficieny attribute
  ## fron the main plt.
  quoteDF <- toDF(attributes(plot)$quote)
  deficiency <- attributes(plot)$deficiency


  ## 2) create volume
  ## plot and store it
  ## as plot_
  plot_ <- plotly::plot_ly(
    data = quoteDF,
    name = 'Volume',
    x = ~Index,
    y = ~Volume,
    showlegend = FALSE,
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
#' @description
#' A short description...
#'
#' `r lifecycle::badge("experimental")`
#' @param plot A plotly object of either
#' klines or OHLC
#'
#' @param ... See [TTR::MACD()]
#' @example man/examples/scr_charting.R
#' @export
addMACD <- function(
    plot,
    ...
) {

  # 1) Extract
  quoteDF <- toDF(attributes(plot)$quote)
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
      showlegend = FALSE,
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
      showlegend = FALSE,
      x = ~Index,
      y = ~signal,
      inherit = FALSE
    ) %>% plotly::add_lines(
      data = indicator,
      showlegend = FALSE,
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
#' @description
#'
#' The function supports all moving averages calculated
#' by the TTR library. Has to be explicitly called.
#'
#' `r lifecycle::badge("experimental")`
#'
#' @param plot A plotly object of either
#' klines or OHLC
#' @param FUN A named function calculating MAs. See [TTR::SMA()]
#' @param ... See [TTR::SMA()]
#'
#' @example man/examples/scr_charting.R
#' @export
addMA <- function(plot, FUN = TTR::SMA, ...) {

  ## 0) extract
  ## call to paste into the function
  if (...length() == 0) {

    arguments <- rlang::fn_fmls(
      fn = eval(FUN)
    )

  } else {

    arguments <- as.list(
      match.call()
    )
  }


  foo <- match.fun(
    FUN = FUN
  )


  quote <- attributes(plot)$quote

  # 1) extract the main
  # chart from the plot
  plot_ <- plot$main

  quote_ <- toDF(
    foo(
      quote[,'Close'],
      ...
    )
  )



  colnames(quote_)[!grepl(colnames(quote_), pattern = 'Index', ignore.case =TRUE)] <- 'value'

  plot_ <- plot_ %>% plotly::add_lines(
    data = quote_,
    name = paste0(
      gsub(pattern = '^[a-z]+::', replacement = '', ignore.case = TRUE, x = deparse(arguments$FUN)),
      '(',
      names(arguments[4]),
      '=',
      arguments[[4]],
      ')'
    ),
    x = ~Index,
    y = ~value,
    inherit = FALSE
  )




  plot$main <- plot_
  attributes(plot)$quote <- quote


  return(
    invisible(plot)
  )




}




#' Add RSI indicators to your
#' chart
#' @description
#' A short description...
#'
#' `r lifecycle::badge("experimental")`
#'
#' @param plot A plotly object of either
#' klines or OHLC
#'
#' @param ... See [TTR::RSI()]
#' @returns NULL
#' @example man/examples/scr_charting.R
#' @export
addRSI <- function(
    plot,
    ...) {

  quote <- attributes(plot)$quote
  deficiency <- attributes(plot)$deficiency
  # 3) create volume
  # plot

  quoteDF <- toDF(
    TTR::RSI(
      quote[,'Close'],
      ...
    )
  )


  plot_ <- plotly::plot_ly(
    data = quoteDF,
    name = 'RSI',
    x = ~Index,
    y = ~rsi,
    showlegend = FALSE,
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


#' add vertical lines to
#' the chart
#'
#' @description
#' A short description...
#'
#' `r lifecycle::badge("experimental")`
#'
#' @param plot Chart
#' @param object an XTS object with dates
#' where the vertical line has to be drawn
#' @param color description
#'
#' @example man/examples/scr_addVlines.R
#'
#' @export
addVlines <- function(plot, object, color = 'steelblue') {

  quote <- toDF(
    object
  )

  # 1) extract the main
  # chart from the plot
  plot_ <- plot$main



  plot_ <- plotly::layout(
    p = plot_,
    shapes = do.call(
      list,
      lapply(
        zoo::index(quote),
        function(x) {

          vline(
            x,
            color = color
          )
        }

      )
    )
  )

  plot$main <- plot_
  attributes(plot)$quote <- toDF(quote)

  return(
    invisible(plot)
  )



}

# script end;
