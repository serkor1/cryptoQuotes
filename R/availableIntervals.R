#' availableIntervals
#'
#'
#' This function shows all
#' available
#' intervals
#'
#' @export

availableIntervals <- function(source = 'binance') {


  rlang::inform(
    message = c(
      paste0('Available Intervals at ', source),
      get(paste0(source, 'Intervals'))()
    )
  )

}

