#' @title
#' Add eventlines to the chart
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' A high-level [plotly::layout()]-function.
#' The function adds `shapes` and `annotations` to the main [chart()].
#'
#' @param data a [data.frame]-type object with `index`, `event`
#' and `color` columns.
#' @param ... For internal use. Please ignore.
#'
#' @returns A [plotly::plot_ly()]-object with `shapes` and `annotations`
#'
#' @details
#' The [data.frame] must include the following columns,
#'
#' * `index` [integer] or [date]: corresponding to the event timing.
#' * `event` [character]: the event label.
#' * `color` [character]: the color of the event
#'
#' @example man/examples/scr_addEvents.R
#'
#' @family chart indicators
#' @family subchart indicators
#' @family main chart indicators
#' @author Serkan Korkmaz
#' @keywords internal
add_event <- function(
    data,
    ...
) {

  # check if the indicator is called
  # from the chart-function
  #
  # stops the function if not
  check_indicator_call()

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
          "x" = "Expected columns {.val index},
          {.val event}, {.val color}. None found."
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
            seq_len(nrow(data)),
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
            seq_len(nrow(data)),
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
