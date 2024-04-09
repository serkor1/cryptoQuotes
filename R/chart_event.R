#' add eventlines to
#' the chart
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' Common types of event indicators include earnings release dates, dividend payouts, central bank interest rate decisions, chart pattern breakouts, and geopolitical events like elections or geopolitical tensions.
#' The choice of event indicators depends on the trader's or analyst's specific objectives and the factors they believe are most relevant to the asset's price movements.
#'
#' @param data a [data.frame]-type object with `index`, `event` and `color` columns.
#' @param ... For internal use. Please ignore.
#'
#' @details
#'
#' The [data.frame] must include the following columns,
#'
#' * `index` [integer] or [date]: corresponding to the event timing.
#' * `event` [character]: the event label.
#' * `color` [character]: the color of the event
#'
#' @example man/examples/scr_addEvents.R
#'
#' @family chart indicators
#'
#' @returns Returns [plotly::plot_ly()]-object with event lines.
add_event <- function(
    data,
    ...
    ) {

  structure(
    .Data = {

      # 0) check data validity
      # has to be of type data.frame and contain
      # event, color and index columns
      assert(
        inherits(x = data, what = "data.frame"),
        error_message = c(
          "x" = sprintf(
            fmt = "Expected {.cls data.frame} got {.cls %s}",
            class(data)
          )
        )
      )

      assert(
        all(c("index", "event", "color") %in% colnames(data)),
        error_message = c(
          "x" = "Expected columns {.val index}, {.val event}, {.val color}. None found."
        )
      )


      args <- list(
        ...
      )


      plotly::layout(
        p = args$plot,
        annotations = do.call(
          list,
          lapply(
            1:nrow(data),
            function(i) {

              annotations(
                x = data$index[i],
                text = data$event[i]
              )
            }

          )
        ),
        shapes = do.call(
          list,
          lapply(
            1:nrow(data),
            function(i) {

              vline(
                x = data$index[i],
                col = data$color[i]
              )

            }

          )
        )
      )



    },
    class = c(
      "indicator",
      "plotly",
      "htmlwidget"
    )
  )

}

# end of script;
