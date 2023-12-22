# script: api_dates
# date: 2023-12-21
# author: Serkan Korkmaz, serkor1@duck.com
# objective: create a sequence corresponding
# to 100 pips per call, if no
# from and to is provided.
# script start;

default_dates <- function(
    interval,
    from = NULL,
    to   = NULL
) {

  if (!is.null(from) | !is.null(to)) {

    if (!is.null(from)) {

      operation <- '+'

    }

    if (!is.null(to)) {

      operation <- '-'

    }

    starting_point <- as.POSIXct(
      c(from, to),
      tz = 'UTC',
      origin = '1970-01-01'
    )

  } else {

    starting_point <- as.POSIXct(
      Sys.Date(),
      tz = 'UTC',
      origin = '1970-01-01'
    )

    operation <- '-'

  }



  # 1) add white-space to the
  # interval
  interval <-  gsub(
    pattern = "([1-9]+)([a-zA-Z]+)",
    replacement =  "\\1 \\2",
    x =  interval
  )

  # 2) replace accordingly
  # to be able to parse it
  interval <- ifelse(
    test = grepl(
      pattern = 's',
      x = interval
    ),
    yes = gsub(pattern = 's',replacement = 'secs', x = interval),
    no  = interval
  )

  interval <- ifelse(
    test = grepl(
      pattern = 'm',
      x = interval
    ),
    yes = gsub(pattern = 'm',replacement = 'mins', x = interval,ignore.case = FALSE),
    no  = interval
  )

  interval <- ifelse(
    test = grepl(
      pattern = 'h',
      x = interval
    ),
    yes = gsub(pattern = 'h',replacement = 'hours', x = interval),
    no  = interval
  )

  interval <- ifelse(
    test = grepl(
      pattern = 'w',
      x = interval
    ),
    yes = gsub(pattern = 'w',replacement = 'weeks', x = interval),
    no  = interval
  )

  interval <- ifelse(
    test = grepl(
      pattern = 'M',
      x = interval
    ),
    yes = gsub(pattern = 'M',replacement = 'months', x = interval,ignore.case = FALSE),
    no  = interval
  )



  interval <- seq(
    from = starting_point,
    by = paste0(
      operation, interval
    ),
    length.out = 100
  )




  return(
    list(
      from = min(interval),
      to   = min(
        max(interval),
        as.POSIXct(
          Sys.Date(),
          tz = 'UTC',
          origin = '1970-01-01'
        )
      )
    )
  )

}




# script end;
