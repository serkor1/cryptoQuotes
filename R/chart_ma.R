# script: Moving Averages
# date: 2024-01-29
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create expressions to be evaluted in
# the charting function
# script start;

chart_ma <- function(
    data,
    plot,
    name,
    y
) {

  plotly::add_lines(
    p    = plot,
    data = data,
    inherit = FALSE,
    showlegend = TRUE,
    name = name,
    x    = ~index,
    y    = stats::as.formula(
      # NOTE: to avoid possible naming
      # bugs in TTR use names(data)[2].
      # names(data)[1] is index as per
      # zoo.fortify
      paste("~",names(data)[2])
      ),
    line = list(
      width = 0.9
    )
  )

}

#' @title
#' Add Simple Moving Average (SMA) indicators to the chart
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' A high-level [plotly::add_lines()]-wrapper function that
#' interacts with [TTR]'s moving average family of functions.
#' The function adds moving average indicators to the main [chart()].
#'
#' @usage sma(
#'  price  = "close",
#'  n      = 10,
#'  ...
#' )
#'
#' @inheritParams TTR::SMA
#' @param price A [character]-vector of [length] 1. "close" by default.
#' The name of the vector to passed into [TTR::SMA].
#' @param ... For internal use. Please ignore.
#'
#' @example man/examples/scr_MAindicator.R
#'
#' @returns
#'
#' A [plotly::plot_ly()]-object
#'
#' @family chart indicators
#' @family moving average indicators
#' @family main chart indicators
#' @author Serkan Korkmaz
#' @export
sma <- function(
    price = "close",
    n = 10,
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
      args <- list(
        ...
      )

      # 1) calculate MACD
      # indicator
      data <- indicator(
        x = args$data,
        columns = price,
        .f = TTR::SMA,
        n = n
      )


      # 3) add ma chart
      chart_ma(
        data = data,
        plot = args$plot,
        name = paste0("SMA(", n, ")"),
        y    = "sma"

      )


    },
    class = c(
      "indicator",
      "plotly",
      "htmlwidget"
    )
  )

}

#' @title
#' Add Exponentially-Weighted Moving Average (EMA) to the chart
#'
#' @usage ema(
#'  price  = "close",
#'  n      = 10,
#'  wilder = FALSE,
#'  ratio  = NULL,
#'  ...
#' )
#'
#' @param price A [character]-vector of [length] 1. "close" by default.
#' The name of the vector to passed into [TTR::EMA].
#' @inheritParams TTR::EMA
#' @param ... For internal use. Please ignore.
#'
#' @inherit sma
#'
#' @family chart indicators
#' @family moving average indicators
#' @family main chart indicators
#' @author Serkan Korkmaz
#' @export
ema <- function(
    price = "close",
    n = 10,
    wilder = FALSE,
    ratio = NULL,
    ...) {

  # check if the indicator is called
  # from the chart-function
  #
  # stops the function if not
  check_indicator_call()

  structure(
    .Data  = {

      # 0) construct arguments
      # via chart function
      args <- list(
        ...
      )

      # 1) calculate MACD
      # indicator
      data <- indicator(
        x = args$data,
        columns = price,
        .f = TTR::EMA,
        n = n,
        wilder = wilder,
        ratio = ratio,
      )

      # 2) add ma chart
      chart_ma(
        data = data,
        plot = args$plot,
        name = paste0("EMA(", n, ")"),
        y    = "ema"

      )



    },
    class = c(
      "indicator",
      "plotly",
      "htmlwidget"
    )
  )

}

#' @title
#' Add Double Exponential Moving Average (DEMA) to the chart
#'
#' @usage dema(
#'  price  = "close",
#'  n      = 10,
#'  v      = 1,
#'  wilder = FALSE,
#'  ratio  = NULL,
#'  ...
#' )
#'
#' @param price A [character]-vector of [length] 1. "close" by default.
#' The name of the vector to passed into [TTR::DEMA].
#' @inheritParams TTR::DEMA
#' @param ... For internal use. Please ignore.
#'
#' @inherit sma
#'
#' @family chart indicators
#' @family moving average indicators
#' @family main chart indicators
#' @author Serkan Korkmaz
#' @export
dema <- function(
    price = "close",
    n = 10,
    v = 1,
    wilder = FALSE,
    ratio = NULL,
    ...) {

  # check if the indicator is called
  # from the chart-function
  #
  # stops the function if not
  check_indicator_call()

  structure(
    .Data  = {

      # 0) construct arguments
      # via chart function
      args <- list(
        ...
      )

      # 1) calculate MACD
      # indicator
      data <- indicator(
        x = args$data,
        columns = price,
        .f = TTR::DEMA,
        n = n,
        v = v,
        wilder = wilder,
        ratio = ratio
      )

      # 2) add ma chart
      chart_ma(
        data = data,
        plot = args$plot,
        name = paste0("DEMA(", n, ")"),
        y    = "dema"

      )



    },
    class = c(
      "indicator",
      "plotly",
      "htmlwidget"
    )
  )


}


#' @title
#' Add Weighted Moving Average (WMA) to the chart
#'
#' @usage wma(
#'  price  = "close",
#'  n      = 10,
#'  wts    = 1:n,
#'  ...
#' )
#'
#' @param price A [character]-vector of [length] 1. "close" by default.
#' The name of the vector to passed into [TTR::WMA].
#' @inheritParams TTR::WMA
#' @param ... For internal use. Please ignore.
#'
#' @inherit sma
#'
#' @family chart indicators
#' @family moving average indicators
#' @family main chart indicators
#' @author Serkan Korkmaz
#' @export
wma <- function(
    price = "close",
    n = 10,
    wts = 1:n,
    ...) {

  # TODO: Submit PR, WMA has an issue
  # too in the naming.

  # check if the indicator is called
  # from the chart-function
  #
  # stops the function if not
  check_indicator_call()

  structure(
    .Data  = {

      # 0) construct arguments
      # via chart function
      args <- list(
        ...
      )

      # 1) calculate MACD
      # indicator
      data <- indicator(
        x = args$data,
        columns = price,
        .f = TTR::WMA,
        n = n,
        wts = wts
      )

      # 2) add ma chart
      chart_ma(
        data = data,
        plot = args$plot,
        name = paste0("WMA(", n, ")"),
        y    = "wma"

      )



    },
    class = c(
      "indicator",
      "plotly",
      "htmlwidget"
    )
  )

}

#' @title
#' Add Elastic Volume-Weighted Moving Average (EVWMA) to the chart
#'
#' @usage evwma(
#'  price  = "close",
#'  n      = 10,
#'  ...
#' )
#'
#' @param price A [character]-vector of [length] 1. "close" by default.
#' The name of the vector to passed into [TTR::EVWMA]
#' @inheritParams TTR::EVWMA
#' @param ... For internal use. Please ignore.
#'
#' @inherit sma
#'
#' @family chart indicators
#' @family moving average indicators
#' @family main chart indicators
#' @author Serkan Korkmaz
#' @export
evwma <- function(
    price = "close",
    n = 10,
    ...) {

  # check if the indicator is called
  # from the chart-function
  #
  # stops the function if not
  check_indicator_call()

  structure(
    .Data  = {

      # 0) construct arguments
      # via chart function
      args <- list(
        ...
      )

      # 1) calculate MACD
      # indicator
      data <- indicator(
        x = args$data,
        columns = price,
        .f = TTR::EVWMA,
        volume = args$data$volume,
        n = n
      )

      # 2) add ma chart
      chart_ma(
        data = data,
        plot = args$plot,
        name = paste0("EVWMA(", n, ")"),
        y    = "evwma"

      )

    },
    class = c(
      "indicator",
      "plotly",
      "htmlwidget"
    )
  )

}


#' @title
#' Add Zero Lag Exponential Moving Average (ZLEMA) to the chart
#'
#' @usage zlema(
#'  price  = "close",
#'  n      = 10,
#'  ratio = NULL,
#'  ...
#' )
#'
#' @param price A [character]-vector of [length] 1. "close" by default.
#' The name of the vector to passed into [TTR::ZLEMA].
#' @inheritParams TTR::ZLEMA
#' @param ... For internal use. Please ignore.
#'
#' @inherit sma
#'
#' @family chart indicators
#' @family moving average indicators
#' @family main chart indicators
#' @author Serkan Korkmaz
#' @export
zlema <- function(
    price = "close",
    n = 10,
    ratio = NULL,
    ...) {

  # check if the indicator is called
  # from the chart-function
  #
  # stops the function if not
  check_indicator_call()

  structure(
    .Data  = {

      # 0) construct arguments
      # via chart function
      args <- list(
        ...
      )

      # 1) calculate MACD
      # indicator
      data <- indicator(
        x = args$data,
        columns = price,
        .f = TTR::ZLEMA,
        n = n,
        ratio = ratio
      )

      # 2) add ma chart
      chart_ma(
        data = data,
        plot = args$plot,
        name = paste0("ZLEMA(", n, ")"),
        y    = "zlema"

      )

    },
    class = c(
      "indicator",
      "plotly",
      "htmlwidget"
    )
  )

}


#' @title
#' Add Volume-Weighted Moving Average (VWAP) to the chart
#'
#' @usage vwap(
#'  price  = "close",
#'  n      = 10,
#'  ratio = NULL,
#'  ...
#' )
#'
#' @param price A [character]-vector of [length] 1. "close" by default.
#' The name of the vector to passed into [TTR::VWAP]
#' @inheritParams TTR::VWAP
#' @param ... For internal use. Please ignore.
#'
#' @inherit sma
#'
#' @family chart indicators
#' @family moving average indicators
#' @family main chart indicators
#' @author Serkan Korkmaz
#' @export
vwap <- function(
    price = "close",
    n = 10,
    ratio = NULL,
    ...) {

  # check if the indicator is called
  # from the chart-function
  #
  # stops the function if not
  check_indicator_call()

  structure(
    .Data  = {

      # 0) construct arguments
      # via chart function
      args <- list(
        ...
      )

      # 1) calculate MACD
      # indicator
      data <- indicator(
        x = args$data,
        columns = price,
        .f = TTR::VWAP,
        n = n,
        ratio = ratio,
        volume = args$data$volume
      )

      # 2) add ma chart
      chart_ma(
        data = data,
        plot = args$plot,
        name = paste0("VWAP(", n, ")"),
        y    = "vwap"

      )

    },
    class = c(
      "indicator",
      "plotly",
      "htmlwidget"
    )
  )



}



#' @title
#' Add Hull Moving Average (HMA) to the chart
#'
#' @usage hma(
#'  price  = "close",
#'  n      = 20,
#'  ...
#' )
#'
#' @param price A [character]-vector of [length] 1. "close" by default.
#' The name of the vector to passed into [TTR::HMA].
#' @inheritParams TTR::HMA
#' @param ... For internal use. Please ignore.
#'
#' @inherit sma
#'
#' @family chart indicators
#' @family moving average indicators
#' @family main chart indicators
#' @author Serkan Korkmaz
#' @export
hma <- function(
    price = "close",
    n = 20,
    ...) {

  # check if the indicator is called
  # from the chart-function
  #
  # stops the function if not
  check_indicator_call()

  structure(
    .Data  = {

      # 0) construct arguments
      # via chart function
      args <- list(
        ...
      )

      # 1) calculate MACD
      # indicator
      data <- indicator(
        x = args$data,
        columns = price,
        .f = TTR::HMA,
        n = n
      )

      # 2) add ma chart
      chart_ma(
        data = data,
        plot = args$plot,
        name = paste0("HMA(", n, ")"),
        y    = "hma"

      )

    },
    class = c(
      "indicator",
      "plotly",
      "htmlwidget"
    )
  )

}

#' @title
#' Add Arnaud Legoux Moving Average (ALMA) to the chart
#'
#' @usage alma(
#'  price  = "close",
#'  n      = 9,
#'  offset = 0.85,
#'  sigma  = 6,
#'  ...
#' )
#'
#' @param price A [character]-vector of [length] 1. "close" by default
#' The name of the vector to passed into [TTR::ALMA].
#' @inheritParams TTR::ALMA
#' @param ... For internal use. Please ignore.
#'
#' @inherit sma
#'
#' @family chart indicators
#' @family moving average indicators
#' @family main chart indicators
#' @author Serkan Korkmaz
#' @export
alma <- function(
    price = "close",
    n = 9,
    offset = 0.85,
    sigma  = 6,
    ...) {

  # check if the indicator is called
  # from the chart-function
  #
  # stops the function if not
  check_indicator_call()

  structure(
    .Data  = {

      # 0) construct arguments
      # via chart function
      args <- list(
        ...
      )

      # 1) calculate MACD
      # indicator
      data <- indicator(
        x = args$data,
        columns = price,
        .f = TTR::ALMA,
        n = n,
        offset = offset,
        sigma  = sigma
      )

      # 2) add ma chart
      chart_ma(
        data = data,
        plot = args$plot,
        name = paste0("ALMA(", n, ")"),
        y    = "alma"

      )

    },
    class = c(
      "indicator",
      "plotly",
      "htmlwidget"
    )
  )

}

# script end;
