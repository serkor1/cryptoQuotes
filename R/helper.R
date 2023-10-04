# script: helpr
# date: 2023-09-22
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A class of helper
# function
# script start;


constructInterval <- function(source, futures, interval) {

  # 1) construct the interval
  interval <- get(
    paste0(source, 'Intervals')
  )(
    futures = futures,
    interval = interval
  )

  # 2) return the interval
  return(
    interval
  )

}



# check_interval <- function(
#     interval
# ) {
#
#   indicator <- grepl(
#     pattern = paste0(
#       collapse = '|',
#       available_intervals()
#     ),
#     x = interval
#   )
#
#   if (!indicator) {
#
#     rlang::abort(
#       message = paste0('Chosen interval: "', interval, '" is not available.'),
#       body = 'Use availableIntervals()-function to see a full list.',
#       call = NULL
#     )
#
#   }
#
#
# }




convert_date <- function(
  input
  ) {

  # Was:
  # format(
  #   as.numeric(
  #     as.POSIXct(to,tz = 'UTC'
  #     )
  #   ) * 1e3,
  #   cientific = FALSE
  # )

  as.POSIXct(
    as.numeric(input)/1e3,
    origin = '1970-01-01'
    )



}






# script end;
