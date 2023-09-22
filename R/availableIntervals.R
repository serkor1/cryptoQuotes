#' availableIntervals
#'
#'
#' This function shows all
#' available
#' intervals
#'
#' @export

availableIntervals <- function() {

  rlang::inform(
    message = c(
      'Available Intervals',
      available_intervals()
    )
  )

}

