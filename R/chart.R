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
#'
#'
#' @family chart indicators
#' @family price charts
#'
#'
#' @example man/examples/scr_charting.R
#'
#' @returns Returns a [plotly::plot_ly()] object.
#'
#' @author Serkan Korkmaz
#'
#' @export
chart <- function(
    ticker,
    main = kline(),
    sub  = list(
      volume()
    ),
    indicator  = list(
      bollinger_bands()
    ),
    event_data = NULL,
    options = list()) {
  suppressWarnings(
    expr = {

      # internal helper function;
      #
      # This is mainly to reduce
      # the amount of repeated code
      foo <- function(expr,...) {


        # 1) Extract and modify calls
        # by adding deficiency and ticker
        # to the function
        call <- rlang::call_modify(
          .call = expr,
          internal = list(
            deficiency = deficiency,
            ticker    = ticker,
            interval  = interval,
            ...
          )
        )

        # 2) expose the structure
        # and the class of the call;
        call <- rlang::eval_bare(
          call
        )

        # 2.1) Extract the class
        # from the call structure
        call_class <- class(
          call
        )

        # 3) evaluate the call
        # and add the class
        call <- rlang::eval_bare(
          call
        )

        class(call) <- c(class(call), call_class)

        call

      }

      # 0) intial parameters;
      # TODO: Check wether this is unnecessary
      name <- rlang::as_label(rlang::enquo(ticker))
      interval <- infer_interval(ticker)
      market <- attributes(ticker)$source
      ticker <- toDF(ticker)

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



      # 1) Initialise the chart
      # elements starting with the
      # main_chart
      chart_elements <- list(
        main_chart = foo(
          rlang::enexpr(main)
          )
      )

      # 2) wrap all indicator
      # functions as expressions
      indicator_fns <- rlang::enexpr(
        sub
      )

      indicator_fns[1] <- NULL


      # 2) locate all subcharts
      # from the indicator_fns
      idx <-vapply(
        X = lapply(X = indicator_fns, rlang::eval_bare),
        FUN.VALUE = logical(1),
        FUN = rlang::inherits_any,
        class = c("chartelement", "subchart")
      )

      chart_elements$sub_chart <- lapply(indicator_fns[idx], foo)

      chart_elements <- flatten(chart_elements)



      # 3) extract price chart if it exists
      # and apply the indicator functions
      idx <- vapply(
        X = chart_elements,
        FUN = rlang::inherits_any,
        class = "pricechart",
        FUN.VALUE = logical(1)
      )

      if (any(idx)) {

        # 3.1) Extract all indicator
        # functions
        indicator_fns <- rlang::enexpr(
          indicator
        )

        # 3.2) Remove the first element
        # of the list
        indicator_fns[1] <- NULL


        pchart <- chart_elements[idx]

        lapply(
          indicator_fns,
          function(call) {

            pchart <<- foo(
              call,
              chart = pchart
            )

          }
        )


        chart_elements[idx] <- list(pchart)



      }


      # Add event data if it
      # exists
      if (!is.null(event_data)){


        iteration <- 0
        chart_elements <- lapply(
          chart_elements,
          function(chart){

            iteration <<- iteration + 1

            rlang::eval_bare(
              expr = add_event(
                chart = chart,
                event_data = event_data,
                label = as.logical(iteration == 1)
              )
            )

          }
        )


      }










      # # # 0) Finalize plot
      # # # and return
      # #
      # # chart_elements <- flatten(chart_elements)
      # #
      # #
      chart_elements <- lapply(
        X = chart_elements,
        function(plot) {

          plotly::layout(
            p = plot,
            colorway = paletteer::paletteer_d("ggsci::category20b_d3"),

            # colorway =paletteer::paletteer_d("ggthemes::excel_Slice"),
            # was 848e9c
            xaxis = list(
              gridcolor = if (dark) '#40454c' else NULL
            ),
            yaxis = list(
              gridcolor = if (dark) '#40454c' else NULL
            )

          )


        }
      )

      if (length(chart_elements) > 1) {

        heights <- c(
          size,
          rep(
            x          = (1-size)/ (length(chart_elements) - 1),
            length.out = length(chart_elements) - 1
          )
        )

      } else {

        heights <- 1


      }


      chart <- plotly::subplot(
        chart_elements,
        nrows = length(chart_elements),
        shareX = TRUE,
        titleY = TRUE,
        heights = heights
      )

      plotly::layout(
        p = chart,
        font = list(
          size = 14,
          color = if (dark)'#848e9c' else NULL
        ),
        # width  = if (interactive()) Inf else 1980,  #Was 1000
        # height =  if (interactive()) Inf else 1080,  #was 1000
        margin = list(l = 60, r = 30, b = 60, t = 60),
        yaxis = list(
          #title = 'Price',
          gridcolor = if (dark) '#40454c' else NULL
        ),
        xaxis = list(
          rangeslider = list(
            visible = slider,
            thickness = 0.05
          ),
          gridcolor = if (dark) '#40454c' else NULL
        ),
        showlegend = TRUE,
        legend = list(
          orientation = 'h', x = 0, y = 1,yref="container", title = list(text = "Indicators:")),
        paper_bgcolor = if(dark)'#2b3139'else NULL,
        plot_bgcolor  = if(dark)'#2b3139'else NULL,
        # font    = list(
        #   color= if (dark)'#848e9c' else NULL
        # ),
        annotations = list(
          list(
            text = paste(
              '<b>Ticker:</b>', name,
              '<b>Interval:</b>', interval
              ),
            x = 0,
            xref = 'paper',
            y = 1,
            yref = 'paper',
            xanchor = 'left',
            yanchor = 'bottom',
            showarrow = FALSE,
            font = list(
              size =24
            )
          ),
          list(
            text = paste('<b>Market:</b>', market),
            x = 1,
            xref = 'paper',
            y = 1,
            yref = 'paper',
            xanchor = 'right',
            yanchor = 'bottom',
            showarrow = FALSE,
            font = list(
              size = 24
            )
          )
        )
        # title = list(
        #   text=paste(
        #     '<b>Ticker:</b>',
        #     name,
        #     '<b>Interval:</b>',
        #     interval
        #   ),
        #   x = 0,
        #   xref = 'paper',
        #   yref = "container"
        #   # ,
        #   # y = 1,
        #   # x = 0,
        #
        #   # yref =  'paper'
        # )
      )

    }
  )


}

# script end;

