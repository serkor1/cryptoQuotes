# script: scr_chart
# date: 2023-10-06
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Chart the quotes using
# plotly
# script start;
# old function; #######

#' Build interactive financial charts
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' [chart()] creates interactive financial charts using [plotly::plot_ly()] as backend. It's a high-level function which collects
#' and structures the passed chart elements.
#'
#' @param ticker A [xts::xts()]-object with Open, High, Low, Close and Volume columns.
#' @param main A [plotly::plot_ly()]-object wrapped in [rlang::expr()]. [kline()] by default.
#' @param sub An optional [list] of [plotly::plot_ly()]-object(s) wrapped in [rlang::expr()].
#' @param indicator An optional [list] of [plotly::plot_ly()]-object(s) wrapped in [rlang::expr()].
#' @param event_data An optional [data.frame] with event line(s) to be added to the [chart()]. See [add_event()] for more details.
#' @param options An optional [list] of [chart()]-options. See details below.
#'
#'
#' @details
#'
#' ## Options
#' * ```dark``` A [logical]-value of [length] 1. [TRUE] by default. Sets the overall theme of the [chart()]
#' * ```slider``` A [logical]-value of [length] 1. [FALSE] by default. If [TRUE], a [plotly::rangeslider()] is added.
#' * ```deficiency``` A [logical]-value of [length] 1. [FALSE] by default. If [TRUE], all [chart()]-elements are colorblind friendly
#' * ```size``` A [numeric]-value of [length] 1. The relative size of the main chart. 0.6 by default. Must be between 0 and 1, non-inclusive.
#'
#' ## Charting Events
#'
#' If `event_data` is passed, vertical eventlines with appropriate labels and coloring are added
#' to the [chart()]. This function is rigid, as it will fail if event, label and index columns are not passed.
#'
#' For more details please see [add_event()].
#'
#' @family chart indicators
#' @family price charts
#'
#' @example man/examples/scr_charting.R
#'
#'
#' @returns Returns a [plotly::plot_ly()] object.
#'
#' @author Serkan Korkmaz
#'
#' @export
chart <- function(
    ticker,
    main = list(),
    sub = list(),
    indicator = list(),
    event_data = NULL,
    options = list()){

  # 0) chart options and common
  # independent parameters
  name <- deparse(substitute(ticker))
  interval <- infer_interval(ticker)
  market <- attributes(ticker)$source
  ticker <- do.call(
    cbind,
    stats::setNames(
      lapply(
        c("open", "high", "low", "close", "volume"),
        pull,
        from = ticker
      ),
      c("open", "high", "low", "close", "volume")
    )

  )

  # ticker <- foo(
  #   ticker
  # )



  ticker$candle <- factor(
    as.factor(
      ticker$open > ticker$close
    ),
    labels = c("bull" , "bear")
  )



  ## 1) set chart options
  ## globally (locally)
  default_options <- list(
    dark       = TRUE,
    slider     = FALSE,
    deficiency = FALSE,
    size       = 0.6
  )

  options <- utils::modifyList(
    x   = default_options,
    val = options,
    keep.null = TRUE
  )

  dark <- options$dark
  deficiency <- options$deficiency
  slider <- options$slider
  size   <- options$size


  candle_color <- movement_color(
    deficiency = deficiency
  )



  # 1) generate list
  # of calls for lazy
  # evaluation
  call_list <- list(
    main = substitute(
      main
    ),
    sub = as.list(
      substitute(sub)
    )[-1],
    indicator = as.list(
      substitute(indicator)
    )[-1]

  )



  # # 2) modify
  # # calls of the main
  # and subcharts
  modify_call <- lapply(
    flatten(
      list(
        call_list$main,
        call_list$sub
      )

    ),
    FUN = function(.f){

      .f$data <- ticker
      .f$slider <- slider
      .f$interval <- interval
      .f$candle_color <- candle_color
      .f$deficiency <- deficiency

      .f
    }
  )



  # 3) evaluate main
  # and subcharts
  #
  # The plot list determines
  # the number of plot
  plot_list <- lapply(
    modify_call,
    eval
  )



  # 3.1) Get length
  # of the plot_list
  plot_list_length <- length(
    plot_list
  )


  if (!identical(call_list$indicator, list())) {

    plot_list[1] <- lapply(
      X = call_list$indicator,
      function(.f) {

        # 0) modify the call list
        .f$data <- ticker
        .f$candle_color <- candle_color
        .f$plot <- plot_list[[1]]



        plot_list[[1]] <<- eval(.f)

        plot_list[[1]]

      }
    )[length(call_list$indicator)]

  }


  if (!is.null(event_data)) {


    # 1) convert function
    # to call
    .f <- substitute(
      add_event(
        data = event_data
      )
    )

    plot_list <- lapply(
      X = plot_list,
      FUN = function(x) {

        # 1) add the plot to
        # the function
        .f$plot <- x

        eval(
          .f
        )

      }
    )


  }


  suppressWarnings(
    plot <- plotly::subplot(
      plot_list,
      nrows = plot_list_length,
      shareX = TRUE,
      titleY = FALSE,
      titleX = FALSE,
      heights = if (plot_list_length > 1) {

        c(
          size,
          rep(
            x          = (1-size)/ (plot_list_length - 1),
            length.out = plot_list_length - 1
          )
        )


      } else {

        1

      }
    )
  )

  bar(
    dark = dark,
    plot = plot,
    name = name,
    market = market
  )

}

# script end;

