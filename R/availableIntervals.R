#' availableIntervals
#'
#' This function shows all
#' available intervals available
#' from each exchange
#'
#' @param source character vector of length one. Must be the name of the
#' supported exchange
#'
#' @param futures logical. TRUE by default. If FALSE, spotmarket are
#' returned
#'
#' @export
availableIntervals <- function(source = 'binance', futures = TRUE) {

  rlang::inform(
    message = c(
      'i' = paste0('Available Intervals at ', source, ifelse(futures, ' (futures)', no = ' (spot)')),
      'v' = paste(
        get(paste0(source, 'Intervals'))(
          futures = futures,
          all = TRUE,
          interval = NULL
        ),
        collapse = ', '
      )

    )
  )

}

