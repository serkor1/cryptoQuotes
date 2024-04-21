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
    y    = stats::as.formula(paste("~",y)),
    line = list(
      width = 0.9
    )
  )

}


#' Add Simple Moving Averages to the charts
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' A high-level [plotly::add_lines()]-wrapper function that interacts with [TTR]'s moving average family of functions.
#'
#' @inheritParams TTR::SMA
#' @param price A [character]-vector of [length] 1. Close by default. The name of the vector to passed into [TTR::SMA]
#' @param ... For internal use. Please ignore.
#'
#' @example man/examples/scr_charting.R
#'
#' @returns
#'
#' A [plotly::plot_ly()]-object
#'
#' @family chart indicators
#' @family moving average indicators
#'
#' @export
sma <- function(
    price = "close",
    n = 10,
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


#' Add Exponentially Weighted Moving Average to the charts
#' @param price A [character]-vector of [length] 1. Close by default. The name of the vector to passed into [TTR::EMA]
#' @inheritParams TTR::EMA
#' @inherit sma
#' @family chart indicators
#' @family moving average indicators
#' @export
ema <- function(
    price = "Close",
    n = 10,
    wilder = FALSE,
    ratio = NULL,
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

#' Add Double Exponential Moving Average to the chart
#' @param price A [character]-vector of [length] 1. Close by default. The name of the vector to passed into [TTR::DEMA]
#' @inheritParams TTR::DEMA
#' @inherit sma
#' @family chart indicators
#' @family moving average indicators
#' @export
dema <- function(
    price = "close",
    n = 10,
    v = 1,
    wilder = FALSE,
    ratio = NULL,
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


#' Add Weighted Moving Average to the chart
#' @param price A [character]-vector of [length] 1. Close by default. The name of the vector to passed into [TTR::WMA]
#' @inheritParams TTR::WMA
#' @inherit sma
#' @family chart indicators
#' @family moving average indicators
#' @export
wma <- function(
    price = "close",
    n = 10,
    wts = 1:n,
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


#' Add Elastic Volume-weighted Moving Average to the chart
#' @param price A [character]-vector of [length] 1. Close by default. The name of the vector to passed into [TTR::EVWMA]
#' @inheritParams TTR::EVWMA
#' @inherit sma
#' @family chart indicators
#' @family moving average indicators
#' @export
evwma <- function(
    price = "close",
    n = 10,
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


#' Add Zero Lag Exponential Moving Average to the chart
#' @param price A [character]-vector of [length] 1. Close by default. The name of the vector to passed into [TTR::ZLEMA]
#' @inheritParams TTR::ZLEMA
#' @inherit sma
#' @family chart indicators
#' @family moving average indicators
#' @export
zlema <- function(
    price = "close",
    n = 10,
    ratio = NULL,
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


#' Add Volume-weighted Moving Average to the chart
#' @param price A [character]-vector of [length] 1. Close by default. The name of the vector to passed into [TTR::VWAP]
#' @inheritParams TTR::VWAP
#' @inherit sma
#' @family chart indicators
#' @family moving average indicators
#' @export
vwap <- function(
    price = "close",
    n = 10,
    ratio = NULL,
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



#' Add Hull Moving Average to the chart
#' @param price A [character]-vector of [length] 1. Close by default. The name of the vector to passed into [TTR::HMA]
#' @inheritParams TTR::HMA
#' @inherit sma
#' @family chart indicators
#' @family moving average indicators
#' @export
hma <- function(
    price = "close",
    n = 20,
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

#' Add Arnaud Legoux Moving Average to the chart
#' @param price A [character]-vector of [length] 1. Close by default. The name of the vector to passed into [TTR::ALMA]
#' @inheritParams TTR::ALMA
#' @inherit sma
#' @family chart indicators
#' @family moving average indicators
#' @export
alma <- function(
    price = "close",
    n = 9,
    offset = 0.85,
    sigma  = 6,
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
