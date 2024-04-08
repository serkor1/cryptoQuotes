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
#'
#' # Note
#' The eventlines are drawn using [plotly::layout()], so all existing
#' eventlines will be replaced each time you call [add_event()].
#'
#'
#' @param event_data a [data.frame] with index, event and colors.
#' @param ... arguments pass interally by [chart], ignore.
#'
#'
#' @details
#'
#' TBA
#'
#'
#'
#' @example man/examples/scr_addEvents.R
#'
#' @family chart indicators
#' @family subcharts
#'
#' @returns Invisbly returns a plotly object.
#' @export

add_event <- function(
    event_data,
    ...
    # chart,
    # event_data,
    # label = TRUE
    ) {


  message("Hi - I am a broken function")

  # structure(
  #   rlang::expr(
  #     {
  #
  #       # 0) store the data
  #       # so it can be passed in the remainder
  #       # of the function with !!
  #       event_data <- !!event_data
  #       internal_args <- lapply(!!rlang::enquos(...), rlang::eval_tidy)
  #       chart <- internal_args$chart
  #       label <- internal_args$label
  #
  #
  #       # 1) check if the data is
  #       # passed as data.frame, tibble or data.table
  #       # etc.
  #       if (!rlang::inherits_any(x = event_data, class = "data.frame")) {
  #
  #         cli::cli_abort(
  #           message = c(
  #             "{.var event_data} must be a {.cls data.frame}",
  #             "x" = "You've supplied a {.cls {class(event_data)}}."
  #           )
  #         )
  #
  #       }
  #
  #       # 2) check if expected columns
  #       # have been passed correctly
  #       expected_colnames <- c('index', 'event', 'color')
  #
  #       # check if the column names
  #       # include event, labels, color
  #       colnames(event_data) <- tolower(
  #         colnames(
  #           event_data
  #         )
  #       )
  #
  #       if (sum(grepl(x = colnames(event_data),pattern = paste(expected_colnames, collapse = "|"))) != 3) {
  #
  #         # determine the missing column names
  #         # from the data
  #         missing_cols <- setdiff(
  #           expected_colnames,
  #           colnames(event_data)
  #         )
  #
  #         cli::cli_abort(
  #           message = c(
  #             paste("Expected columns:",  paste0("{.val ", expected_colnames, "}", collapse = ", ")),
  #             "x" = paste("Missing columns:",  paste0("{.val ", missing_cols, "}", collapse = ", ")),
  #             "i" = "Check your spelling, or add the columns."
  #           )
  #         )
  #
  #       }
  #
  #
  #       # 3) modify the layout
  #       # of the data to add
  #       # the event lines
  #       #
  #       #
  #       # TODO: Open issue at Github
  #       # when calling layout + shapes twice,
  #       # the first lines doesnt draw.
  #
  #       if (label) {
  #
  #         chart <- plotly::layout(
  #           p = chart,
  #           annotations = do.call(
  #             list,
  #             lapply(
  #               1:nrow(event_data),
  #               function(i) {
  #
  #                 annotations(
  #                   x = event_data$index[i],
  #                   text = event_data$event[i]
  #                 )
  #               }
  #
  #             )
  #           ),
  #           shapes = do.call(
  #             list,
  #             lapply(
  #               1:nrow(event_data),
  #               function(i) {
  #
  #                 vline(
  #                   x = event_data$index[i],
  #                   col = event_data$color[i]
  #                 )
  #
  #               }
  #
  #             )
  #           )
  #         )
  #
  #       } else {
  #
  #
  #         chart <- plotly::layout(
  #           p = chart,
  #           shapes = do.call(
  #             list,
  #             lapply(
  #               1:nrow(event_data),
  #               function(i) {
  #
  #                 vline(
  #                   x = event_data$index[i],
  #                   col = event_data$color[i]
  #                 )
  #
  #               }
  #
  #             )
  #           )
  #         )
  #
  #
  #       }
  #
  #       chart
  #
  #     }
  #   ),
  #   class = "event"
  # )

}

# end of script;
