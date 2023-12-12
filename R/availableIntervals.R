#' See all available intervals for the futures and spot markets
#' on the desired exchange
#'
#' This function shows all
#' available intervals available
#' from each exchange
#'
#' @param source character vector of length one. Must be the name of the
#' supported exchange
#'
#' @param futures logical. TRUE by default. If FALSE, spot market are
#' returned
#'
#' @example man/examples/scr_availableIntervals.R
#'
#' @returns Invisbly returns a character vector.
#'
#' @export
availableIntervals <- function(source = 'binance', futures = TRUE) {

  # 0) extract available
  # intervals
  all_intervals <- get(paste0(source, 'Intervals'))(
    futures = futures,
    all = TRUE,
    interval = NULL
  )

  # 1) return a message
  # with  available
  # intervals by exchange and market
  rlang::inform(
    message = c(
      'i' = paste0('Available Intervals at ', source, ifelse(futures, ' (futures)', no = ' (spot)')),
      'v' = paste(
        all_intervals,
        collapse = ', '
      )
    )
  )

  return(
    invisible(
      all_intervals
    )
  )

}

