# script: Moving Averages
# date: 2024-01-29
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Create expressions to be evaluted in
# the charting function
# script start;

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
#' @param internal An empty [list]. Used for internal purposes. Ignore.
#'
#' @example man/examples/scr_charting.R
#'
#' @returns
#'
#' A [plotly::plot_ly()]-object wrapped in [rlang::expr()].
#'
#' @family chart indicators
#' @family moving average indicators
#'
#' @export
sma <- function(
    price = "close",
    n = 10,
    ...) {


  structure(
    .Data = {



      # 0) construct arguments
      # via chart function
      args <- list(
        ...
      )


      # 0.4) linewidth
      linewidth <- 0.90

      # 1) calculate MACD
      # indicator
      indicator <- toDF(
        TTR::SMA(
          x = toQuote(args$data)[, grep(pattern = price, x = colnames(args$data),ignore.case = TRUE)],
          n = n
        )
      )

      # 2) add middle band
      plotly::add_lines(
        showlegend = TRUE,
        p = args$plot,
        inherit = FALSE,
        data = indicator,
        x = ~index,
        y = ~sma,
        line = list(
          width = linewidth
        ),
        name = paste0("SMA(", n, ")")
      )



    },
    class = c("indicator", "plotly", "htmlwidget")
  )

}


#' Add Exponentially Weighted Moving Average to the charts
#'
#' @inherit sma description
#'
#' @param price A [character]-vector of [length] 1. Close by default. The name of the vector to passed into [TTR::EMA]
#' @inheritParams TTR::EMA
#' @param internal An empty [list]. Used for internal purposes. Ignore.
#'
#' @example man/examples/scr_charting.R
#'
#' @returns
#'
#' A [plotly::plot_ly()]-object wrapped in [rlang::expr()].
#'
#' @family chart indicators
#' @family moving average indicators
#'
#' @export
ema <- function(
    price = "Close",
    n = 10,
    wilder = FALSE,
    ratio = NULL,
    ...) {

  structure(
    rlang::expr(
      {

        # 0) locate global
        # parameters to be passed
        # into the charting functions;

        # internal_args <- flatten(lapply(!!rlang::enquos(internal), rlang::eval_tidy))
        internal_args <- flatten(lapply(!!rlang::enexpr(internal), rlang::eval_tidy))


        ticker <- internal_args$ticker
        deficiency <- internal_args$deficiency
        chart  <- internal_args$chart



        candle_color <- movement_color(
          deficiency = deficiency
        )


        # 0.4) linewidth
        linewidth <- 0.90

        # 1) calculate MACD
        # indicator
        indicator <- toDF(
          TTR::EMA(
            x = toQuote(ticker)[, grep(pattern = !!price, x = colnames(ticker),ignore.case = TRUE)],
            n = !!n,
            wilder = !!wilder,
            ratio = !!ratio,
            ... = !!rlang::enquos(...)
          )
        )



        # 2) add middle band
        plotly::add_lines(
          showlegend = TRUE,
          p = chart,
          inherit = FALSE,
          data = indicator,
          x = ~index,
          y = ~ema,
          line = list(
            width = linewidth
          ),
          name = paste0("EMA(", !!n, ")")
        )





      }
    ),
    class = "indicator"
  )


  structure(
    .Data = {

    },
    class = c("indicator", "plotly", "htmlwidget")
  )
}

#' Add Double Exponential Moving Average to the chart
#'
#' @inherit sma description
#'
#' @param price A [character]-vector of [length] 1. Close by default. The name of the vector to passed into [TTR::DEMA]
#' @inheritParams TTR::DEMA
#' @param internal An empty [list]. Used for internal purposes. Ignore.
#'
#' @example man/examples/scr_charting.R
#'
#' @returns
#'
#' A [plotly::plot_ly()]-object wrapped in [rlang::expr()].
#'
#' @family chart indicators
#' @family moving average indicators
#'
#' @export
dema <- function(
    price = "close",
    n = 10,
    v = 1,
    wilder = FALSE,
    ratio = NULL,
    internal = list()) {

  structure(
    rlang::expr(
      {

        # 0) locate global
        # parameters to be passed
        # into the charting functions;

        # internal_args <- flatten(lapply(!!rlang::enquos(internal), rlang::eval_tidy))
        internal_args <- flatten(lapply(!!rlang::enexpr(internal), rlang::eval_tidy))


        ticker <- internal_args$ticker
        deficiency <- internal_args$deficiency
        chart  <- internal_args$chart



        candle_color <- movement_color(
          deficiency = deficiency
        )


        # 0.4) linewidth
        linewidth <- 0.90

        # 1) calculate MACD
        # indicator
        indicator <- toDF(
          TTR::DEMA(
            x = toQuote(ticker)[, grep(pattern = !!price, x = colnames(ticker),ignore.case = TRUE)],
            n = !!n,
            v = !!v,
            wilder = !!wilder,
            ratio = !!ratio
          )
        )



        # 2) add middle band
        plotly::add_lines(
          showlegend = TRUE,
          p = chart,
          inherit = FALSE,
          data = indicator,
          x = ~index,
          y = ~dema,
          line = list(
            width = linewidth
          ),
          name = paste0("DEMA(", !!n, ")")
        )



        chart

      }
    ),
    class = "indicator"
  )

}


#' Add Weighted Moving Average to the chart
#'
#' @inherit sma description
#'
#' @param price A [character]-vector of [length] 1. Close by default. The name of the vector to passed into [TTR::WMA]
#' @inheritParams TTR::WMA
#' @param internal An empty [list]. Used for internal purposes. Ignore.
#'
#' @example man/examples/scr_charting.R
#'
#' @returns
#'
#' A [plotly::plot_ly()]-object wrapped in [rlang::expr()].
#'
#' @family chart indicators
#' @family moving average indicators
#'
#' @export
wma <- function(
    price = "close",
    n = 10,
    wts = 1:n,
    internal = list(),
    ...) {

  structure(
    rlang::expr(
      {

        # 0) locate global
        # parameters to be passed
        # into the charting functions;

        # internal_args <- flatten(lapply(!!rlang::enquos(internal), rlang::eval_tidy))
        internal_args <- flatten(lapply(!!rlang::enexpr(internal), rlang::eval_tidy))


        ticker <- internal_args$ticker
        deficiency <- internal_args$deficiency
        chart  <- internal_args$chart



        candle_color <- movement_color(
          deficiency = deficiency
        )


        # 0.4) linewidth
        linewidth <- 0.90

        # 1) calculate MACD
        # indicator
        indicator <- toDF(
          TTR::WMA(
            x = toQuote(ticker)[, grep(pattern = !!price, x = colnames(ticker),ignore.case = TRUE)],
            n   = !!n,
            wts = !!wts,
            ... = !!rlang::enquos(...)
          )
        )

        # NOTE: The column
        # name of WMA is broken
        # TODO: Submit a PR



        # 2) add middle band
        plotly::add_lines(
          showlegend = TRUE,
          p = chart,
          inherit = FALSE,
          data = indicator,
          x = ~index,
          y = ~v1,
          line = list(
            width = linewidth
          ),
          name = paste0("WMA(", !!n, ")")
        )


      }
    ),
    class = "indicator"
  )

}


#' Add Elastic Volume-weighted Moving Average to the chart
#'
#' @inherit sma description
#'
#' @param price A [character]-vector of [length] 1. Close by default. The name of the vector to passed into [TTR::EVWMA]
#' @inheritParams TTR::EVWMA
#' @param internal An empty [list]. Used for internal purposes. Ignore.
#'
#' @example man/examples/scr_charting.R
#'
#' @returns
#'
#' A [plotly::plot_ly()]-object wrapped in [rlang::expr()].
#'
#' @family chart indicators
#' @family moving average indicators
#'
#' @export
evwma <- function(
    price = "Close",
    n = 10,
    internal = list(),
    ...) {

  structure(
    rlang::expr(
      {

        # 0) locate global
        # parameters to be passed
        # into the charting functions;

        # internal_args <- flatten(lapply(!!rlang::enquos(internal), rlang::eval_tidy))
        internal_args <- flatten(lapply(!!rlang::enexpr(internal), rlang::eval_tidy))


        ticker <- internal_args$ticker
        deficiency <- internal_args$deficiency
        chart  <- internal_args$chart



        candle_color <- movement_color(
          deficiency = deficiency
        )


        # 0.4) linewidth
        linewidth <- 0.90

        # 1) calculate MACD
        # indicator
        indicator <- toDF(
          TTR::EVWMA(
            price  = toQuote(ticker)[, grep(pattern = !!price, x = colnames(ticker),ignore.case = TRUE)],
            volume = toQuote(ticker)$volume,
            n   = !!n,
            ... = !!rlang::enquos(...)
          )
        )

        # NOTE: The column
        # name of WMA is broken
        # TODO: Submit a PR



        # 2) add middle band
        plotly::add_lines(
          showlegend = TRUE,
          p = chart,
          inherit = FALSE,
          data = indicator,
          x = ~index,
          y = ~v1,
          line = list(
            width = linewidth
          ),
          name = paste0("EVWMA(", !!n, ")")
        )

      }
    ),
    class = "indicator"
  )

}


#' Add Zero Lag Exponential Moving Average to the chart
#'
#'
#' @inherit sma description
#'
#' @param price A [character]-vector of [length] 1. Close by default. The name of the vector to passed into [TTR::ZLEMA]
#' @inheritParams TTR::ZLEMA
#' @param internal An empty [list]. Used for internal purposes. Ignore.
#'
#' @example man/examples/scr_charting.R
#'
#' @returns
#'
#' A [plotly::plot_ly()]-object wrapped in [rlang::expr()].
#'
#' @family chart indicators
#' @family moving average indicators
#'
#' @export
zlema <- function(
    price = "close",
    n = 10,
    ratio = NULL,
    internal = list(),
    ...) {

  structure(
    rlang::expr(
      {

        # 0) locate global
        # parameters to be passed
        # into the charting functions;

        # internal_args <- flatten(lapply(!!rlang::enquos(internal), rlang::eval_tidy))
        internal_args <- flatten(lapply(!!rlang::enexpr(internal), rlang::eval_tidy))


        ticker <- internal_args$ticker
        deficiency <- internal_args$deficiency
        chart  <- internal_args$chart



        candle_color <- movement_color(
          deficiency = deficiency
        )


        # 0.4) linewidth
        linewidth <- 0.90

        # 1) calculate MACD
        # indicator
        indicator <- toDF(
          TTR::ZLEMA(
            x  = toQuote(ticker)[, grep(pattern = !!price, x = colnames(ticker),ignore.case = TRUE)],
            ratio = !!ratio,
            n   = !!n,
            ... = !!rlang::enquos(...)
          )
        )

        # NOTE: The column
        # name of WMA is broken
        # TODO: Submit a PR



        # 2) add middle band
        plotly::add_lines(
          showlegend = TRUE,
          p = chart,
          inherit = FALSE,
          data = indicator,
          x = ~index,
          y = ~v1,
          line = list(
            width = linewidth
          ),
          name = paste0("ZLEMA(", !!n, ")")
        )

      }
    ),
    class = "indicator"
  )

}


#' Add Volume-weighted Moving Average to the chart
#'
#' @inherit sma description
#'
#' @param price A [character]-vector of [length] 1. Close by default. The name of the vector to passed into [TTR::VWAP]
#' @inheritParams TTR::VWAP
#' @param internal An empty [list]. Used for internal purposes. Ignore.
#'
#' @example man/examples/scr_charting.R
#'
#' @returns
#'
#' A [plotly::plot_ly()]-object wrapped in [rlang::expr()].
#'
#' @family chart indicators
#' @export
vwap <- function(
    price = "close",
    n = 10,
    ratio = NULL,
    internal = list(),
    ...) {

  structure(
    rlang::expr(
      {

        # 0) locate global
        # parameters to be passed
        # into the charting functions;

        # internal_args <- flatten(lapply(!!rlang::enquos(internal), rlang::eval_tidy))
        internal_args <- flatten(lapply(!!rlang::enexpr(internal), rlang::eval_tidy))


        ticker <- internal_args$ticker
        deficiency <- internal_args$deficiency
        chart  <- internal_args$chart



        candle_color <- movement_color(
          deficiency = deficiency
        )


        # 0.4) linewidth
        linewidth <- 0.90

        # 1) calculate MACD
        # indicator
        indicator <- toDF(
          TTR::VWAP(
            price  = toQuote(ticker)[, grep(pattern = !!price, x = colnames(ticker),ignore.case = TRUE)],
            volume = toQuote(ticker)$volume,
            n   = !!n,
            ... = !!rlang::enquos(...)
          )
        )

        # 2) add middle band
        plotly::add_lines(
          showlegend = TRUE,
          p = chart,
          inherit = FALSE,
          data = indicator,
          x = ~index,
          y = ~vwap,
          line = list(
            width = linewidth
          ),
          name = paste0("VWAP(", !!n, ")")
        )

      }
    ),
    class = "indicator"
  )

}



#' Add Hull Moving Average to the chart
#'
#' @inherit sma description
#'
#' @param price A [character]-vector of [length] 1. Close by default. The name of the vector to passed into [TTR::HMA]
#' @inheritParams TTR::HMA
#' @param internal An empty [list]. Used for internal purposes. Ignore.
#'
#' @example man/examples/scr_charting.R
#'
#' @returns
#'
#' A [plotly::plot_ly()]-object wrapped in [rlang::expr()].
#'
#' @family chart indicators
#' @family moving average indicators
#'
#' @export
hma <- function(
    price = "Close",
    n = 20,
    internal = list(),
    ...) {

  structure(
    rlang::expr(
      {

        # 0) locate global
        # parameters to be passed
        # into the charting functions;

        # internal_args <- flatten(lapply(!!rlang::enquos(internal), rlang::eval_tidy))
        internal_args <- flatten(lapply(!!rlang::enexpr(internal), rlang::eval_tidy))


        ticker <- internal_args$ticker
        deficiency <- internal_args$deficiency
        chart      <- internal_args$chart



        candle_color <- movement_color(
          deficiency = deficiency
        )


        # 0.4) linewidth
        linewidth <- 0.90

        # 1) calculate MACD
        # indicator
        indicator <- toDF(
          TTR::HMA(
            x  = toQuote(ticker)[,grep(pattern = !!price, x = colnames(ticker),ignore.case = TRUE)],
            n   = !!n,
            ... = !!rlang::enquos(...)
          )
        )

        # 2) add middle band
        plotly::add_lines(
          showlegend = TRUE,
          p = chart,
          inherit = FALSE,
          data = indicator,
          x = ~index,
          y = ~v1,
          line = list(
            width = linewidth
          ),
          name = paste0("HMA(", !!n, ")")
        )

      }
    ),
    class = "indicator"
  )

}


#' Add Arnaud Legoux Moving Average to the chart
#'
#' @inherit sma description
#'
#' @param price A [character]-vector of [length] 1. Close by default. The name of the vector to passed into [TTR::ALMA]
#' @inheritParams TTR::ALMA
#' @param internal An empty [list]. Used for internal purposes. Ignore.
#'
#' @example man/examples/scr_charting.R
#'
#' @returns
#'
#' A [plotly::plot_ly()]-object wrapped in [rlang::expr()].
#'
#' @family chart indicators
#' @family moving average indicators
#'
#' @export
alma <- function(
    price = "close",
    n = 9,
    offset = 0.85,
    sigma  = 6,
    internal = list(),
    ...) {

  # NOTE: ALMA doesnt return a
  # column with ALMA name nor V1
  #
  # It returns the same column name as
  # passed
  # TODO: Submit PR

  structure(
    rlang::expr(
      {

        # 0) locate global
        # parameters to be passed
        # into the charting functions;

        # internal_args <- flatten(lapply(!!rlang::enquos(internal), rlang::eval_tidy))
        internal_args <- flatten(lapply(!!rlang::enexpr(internal), rlang::eval_tidy))


        ticker <- internal_args$ticker
        deficiency <- internal_args$deficiency
        chart  <- internal_args$chart



        candle_color <- movement_color(
          deficiency = deficiency
        )


        # 0.4) linewidth
        linewidth <- 0.90

        # 1) calculate MACD
        # indicator
        indicator <- toDF(
          TTR::ALMA(
            x  = toQuote(ticker)[, grep(pattern = !!price, x = colnames(ticker),ignore.case = TRUE)],
            n   = !!n,
            offset = !!offset,
            sigma = !!sigma,
            ... = !!rlang::enquos(...)
          )
        )

        # 2) add middle band
        plotly::add_lines(
          showlegend = TRUE,
          p = chart,
          inherit = FALSE,
          data = indicator,
          x = ~index,
          y = ~!!rlang::sym(price),
          line = list(
            width = linewidth
          ),
          name = paste0("ALMA(", !!n, ")")
        )

      }
    ),
    class = "indicator"
  )

}


# script end;
