# script: helpr
# date: 2023-09-22
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A class of helper
# function
# script start;

# check intervals;
available_intervals <- function() {

  c(
    '1s',
    '1m',
    '3m',
    '5m',
    '15m',
    '30m',
    '1h',
    '2h',
    '4h',
    '6h',
    '8h',
    '12h',
    '1d',
    '3d',
    '1w',
    '1M'
  )


}



check_interval <- function(
    interval
) {

  indicator <- grepl(
    pattern = paste0(
      collapse = '|',
      available_intervals()
    ),
    x = interval
  )

  if (!indicator) {

    rlang::abort(
      message = paste0('Chosen interval: "', interval, '" is not available.'),
      body = 'Use availableIntervals()-function to see a full list.',
      call = NULL
    )

  }


}




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
