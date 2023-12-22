# script: indicators;
# date: 2023-10-11
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Generate indictors
# that are compatible with
# plotly
# script start;

#' Add Bollinger Bands
#' to the chart
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' Bollinger Bands provide a visual representation of price volatility and are widely used by traders
#' and investors to assess potential price reversals and trade opportunities in various financial markets, including stocks, forex, and commodities.
#'
#'
#' @param chart a [kline()] or [ohlc()] chart
#' @param cols a vector of column names used to calculate the  Bollinger Bands
#' Default values ``High``, `Low` and ``Close``
#'
#' @param ... See [TTR::BBands()]
#' @example man/examples/scr_charting.R
#'
#'
#'
#' @returns Invisbly returns a plotly object.
#'
#' @family chart indicators
#'
#' @export
addBBands <- function(
    chart,
    cols = c('High', 'Low', 'Close'),
    ...
) {


  ## 1) convert the embedded
  ## data.frame in the plot
  ## to xts, zoo object
  quote <- (
    attributes(chart)$quote
  )

  ## 2) extract the main chart
  ## and store it it as plot_
  chart_ <- chart$main

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
  chart_ <- chart_ %>%
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
  chart$main <- chart_

  ## 6) pass the quote on
  ## to the attributes of the
  ## for further indicator plots
  attributes(chart)$quote <- attributes(chart)$quote


  ## 7) return
  ## the plot invisibly
  ## to force enduser
  ## to use chart-function
  return(
    invisible(chart)
  )

}

#' Add volume indicators
#' to the chart
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' Volume indicators are technical analysis tools used to analyze trading volume, which represents the number of shares or contracts traded in a financial market over a specific period of time.
#' These indicators provide valuable insights into the strength and significance of price movements.
#'
#' @param chart a [kline()] or [ohlc()] chart
#'
#' @returns Invisbly returns a plotly object.
#'
#' @example man/examples/scr_charting.R
#'
#' @family chart indicators
#'
#' @export
addVolume <- function(
    chart
    ) {

  ## 1) extract the data
  ## and deficieny attribute
  ## fron the main plt.
  quoteDF <- toDF(
    attributes(chart)$quote
    )

  deficiency <- attributes(chart)$deficiency


  ## 2) create volume
  ## plot and store it
  ## as plot_
  chart_ <- plotly::plot_ly(
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
  chart$volume <- chart_

  ## 4) pass on the data
  ## as is in the the quote
  ## attribute of the plot
  ## so it can be used in the additional
  ## plot
  attributes(chart)$quote <- attributes(chart)$quote


  return(
    invisible(chart)
  )


}


#' Add MACD indicators to the chart
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' Traders and investors use the MACD indicator to identify trend changes, potential reversals, and overbought or oversold conditions in the market.
#' It is a versatile tool that can be applied to various timeframes and asset classes, making it a valuable part of technical analysis for many traders.
#'
#' @param chart a [kline()] or [ohlc()] chart
#'
#'
#' @param ... See [TTR::MACD()]
#' @example man/examples/scr_charting.R
#'
#' @returns Invisbly returns a plotly object.
#' @family chart indicators
#' @export
addMACD <- function(
    chart,
    ...
) {

  # 1) Extract
  quoteDF <- toDF(attributes(chart)$quote)
  deficiency <- attributes(chart)$deficiency

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

  chart_ <- plotly::plot_ly(
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
    color = I('steelblue'),
    inherit = FALSE
  ) %>% plotly::add_lines(
    data = indicator,
    showlegend = FALSE,
    x = ~Index,
    y = ~macd,
    color = I('orange'),
    inherit = FALSE
  )  %>% plotly::layout(
    yaxis = list(
      title = 'MACD'
    )
  ) %>% plotly::add_annotations(
    x= 0,
    y= 1,
    xref = "paper",
    yref = "paper",
    text = 'Placeholder',
    showarrow = FALSE,
    font = list(
      size = 12
    )

  )

  chart$macd <- chart_
  attributes(chart)$quote <- attributes(chart)$quote

  return(
    invisible(chart)
  )
}



#' Add various Moving Average indicators
#' to the chart
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' Moving averages are versatile tools used by traders and analysts in various timeframes, from short-term intraday trading to long-term investing.
#' They help smooth out noise in price data and provide valuable information for decision-making in financial markets.
#'
#'
#'
#' @param chart a [kline()] or [ohlc()] chart
#' @param FUN A named function calculating MAs. Has to be explicitly called. See [TTR::SMA()] for more information.
#' @param ... See [TTR::SMA()]
#'
#' @details
#' The function supports all moving averages calculated
#' by the [TTR] library. See [TTR::SMA()] for more information.
#'
#'
#'
#' @example man/examples/scr_charting.R
#'
#' @returns Invisbly returns a plotly object.
#'
#' @family chart indicators
#' @export
addMA <- function(chart, FUN = TTR::SMA, ...) {

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


  quote <- attributes(chart)$quote

  # 1) extract the main
  # chart from the plot
  chart_ <- chart$main

  quote_ <- toDF(
    foo(
      quote[,'Close'],
      ...
    )
  )



  colnames(quote_)[!grepl(colnames(quote_), pattern = 'Index', ignore.case =TRUE)] <- 'value'

  chart_ <- chart_ %>% plotly::add_lines(
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




  chart$main <- chart_
  attributes(chart)$quote <- quote


  return(
    invisible(chart)
  )




}




#' Add RSI indicators to your
#' chart
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' The RSI can be customized with different look-back periods to suit various trading strategies and timeframes.
#' It is a valuable tool for assessing the momentum and relative strength of an asset, helping traders make more informed decisions in financial markets.
#'
#'
#' @param chart a [kline()] or [ohlc()] chart
#' @param ... See [TTR::RSI()]
#'
#' @returns Invisbly returns a plotly object.
#'
#' @example man/examples/scr_charting.R
#'
#'
#' @family chart indicators
#' @export
addRSI <- function(
    chart,
    ...) {

  quote <- attributes(chart)$quote
  deficiency <- attributes(chart)$deficiency
  # 3) create volume
  # plot

  quoteDF <- toDF(
    TTR::RSI(
      quote[,'Close'],
      ...
    )
  )


  chart_ <- plotly::plot_ly(
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

  chart$rsi <- chart_

  attributes(chart)$quote <- attributes(chart)$quote


  return(
    invisible(chart)
  )



}
# script end;
