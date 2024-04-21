#' add eventlines to
#' the chart
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' A high-level [plotly::layout()]-wrapper that adds `shapes` and `annotations` to the [chart()].
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
#' @author Serkan Korkmaz
#'
#' @returns A [plotly::plot_ly()]-object with `shapes` and `annotations`
add_event <- function(
    data,
    ...
    ) {

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
