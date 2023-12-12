#' add eventlines to
#' the chart
#'
#' `r lifecycle::badge("experimental")`
#'
#' @param plot Chart
#' @param event a data.frame with index, event and colors.
#'
#' @example man/examples/scr_addEvents.R
#'
#' @family chart indicators
#'
#' @returns Invisbly returns a plotly object.
#' @export
addEvents <- function(
    plot,
    event
) {

  # check if class is
  # data.frame or the likes of it
  if (!inherits(event, 'data.frame')) {

    rlang::abort(
      message = 'The event data has to be data.frame, or similar.'
    )

  }

  # check if the column names
  # include event, labels, color
  colnames(event) <- tolower(
    colnames(
      event
    )
  )

  if (sum(grepl(x = colnames(event),pattern = 'index|event|color')) != 3) {

    # determine the missing column names
    # from the data
    missing_cols <- setdiff(
      c('index', 'event', 'color'),
      colnames(event)
    )

    rlang::abort(
      message = paste('Colum:', paste(collapse = ', ', missing_cols), 'are missing. Check your spelling, or add the columns.')
    )


  }


  # 1) extract the main
  # chart from the plot
  plot_ <- plot$main



  plot_ <- plotly::layout(
    p = plot_,
    shapes = do.call(
      list,
      lapply(
        1:nrow(event),
        function(i) {

          vline(
            x = event$index[i],
            col = event$color[i]
          )
        }

      )
    ),
    annotations = do.call(
      list,
      lapply(
        1:nrow(event),
        function(i) {

          annotations(
            x = event$index[i],
            text = event$event[i]
          )
        }

      )
    )
  )

  plot$main <- plot_
  # attributes(plot)$quote <- toDF(quote)

  return(
    invisible(plot)
  )

}

