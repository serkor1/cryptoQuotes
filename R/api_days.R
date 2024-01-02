# script: api_dates
# date: 2023-12-21
# author: Serkan Korkmaz, serkor1@duck.com
# objective: create a sequence corresponding
# to 100 pips per call, if no
# from and to is provided.
# script start;
default_dates <-function(
    interval,
    from = NULL,
    to   = NULL
) {

  # 1) Determine parameters
  # passed futher;
  current_time <- Sys.time()
  origin_date <- '1970-01-01'

  # 1.1) check if from date is
  # provided
  is_from_provided <- !is.null(from)

  # 1.2) if a from date is provided
  # the operation is always
  # adding values
  operation <- if (is_from_provided) "+" else "-"

  # 1.3) determine starting point
  # if from is no provided
  # use Sys.time. Truncate to nearest
  # 15 minutes
  starting_point_time <- if (is_from_provided) from else current_time
  starting_point <- as.POSIXct(
    trunc(as.double(starting_point_time)/(15*60))*(15*60),
    tz = 'UTC',
    origin = origin_date
  )

  # 2) Construct the returning
  # intervals based on granularity
  # and units

  # 2.1) Extract the granularity
  # by removing the numbers
  # of the intervals; this is a
  # reverse operation
  #
  # Returns either s, m, h, d, w, M
  # based on supplied intervals
  granularity <-  gsub(
    pattern = "([0-9]*)",
    x = interval,
    replacement = ""
  )

  # 2.2) Extract the numerical
  # value of the interval -
  # all intervals is 1m, 2w, etc
  # which has to be supplied
  # to sequence
  value <- as.integer(
    gsub("([a-zA-Z]+)", "", interval)
  )

  # 2.3) translate the granularity
  # so it can passed into seq
  # accordingly using switc;
  #
  # This change gains 10-15% in speed
  # over using multiple if-statements
  granularity <- switch(
    EXPR = granularity,
    s = "secs",
    m = "mins",
    h = "hours",
    w = "weeks",
    d = "days",
    M = "months"
  )

  # 2.4) construct interval
  # from starting point and return
  # 100 (or 100 if daily) values
  interval_length <- 100 + (granularity == "days")
  interval_seq <- seq(
    from = starting_point,
    by = paste0(operation, value, " ", granularity),
    length.out = interval_length
  )

  # 3) construct the interval
  # by extracing the min date (from)
  # and the max date in the constructed
  # interval; this has to be limited
  # by sys.date to avoid calling values
  # that havent been realized yet... for obvious reasons...
  interval <- list(
    from = min(interval_seq),
    to   = min(
      max(interval_seq),
      as.POSIXct(current_time, tz = "UTC", origin = origin_date)
    )
  )

  # 4) return statement
  # as interval
  return(
    interval
  )

}

# script end;
