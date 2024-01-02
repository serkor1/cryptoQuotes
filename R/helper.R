# script: helpr
# date: 2023-09-22
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A class of helper
# function
# script start;



toDF <- function(quote) {


  # this function converts
  # the quote to a data.frame
  # for the plotting and reshaping

  attr_list <- attributes(quote)$tickerInfo
  # 2) convert to
  # data.frame
  DF <- as.data.frame(
    zoo::coredata(quote),
    row.names = NULL
  )

  # 3) add the index;
  DF$Index <- zoo::index(
    quote
  )

  # 1) determine
  # wether the the day is closed
  # green
  if (all(c('Open', 'Close') %in% colnames(DF))) {

    DF$direction <- ifelse(
      test = DF$Close > DF$Open,
      yes  = 'Increasing',
      no   = 'Decreasing'
    )

  }


  attributes(DF)$tickerInfo <- attr_list

  return(
    DF
  )

}


toQuote <- function(DF) {

  quote <- xts::as.xts(
    DF[,c('Open','High', 'Low', 'Close', 'Volume', 'Index')]
  )

  zoo::index(quote) <- as.POSIXct(
    DF$Index
  )

  attributes(quote)$tickerInfo <- attributes(DF)$tickerInfo

  return(
    quote
  )
}


vline <- function(
    x = 0,
    col = 'steelblue'
) {

  list(
    type = "line",
    y0 = 0,
    y1 = 1,
    yref = "paper",
    x0 = x,
    x1 = x,
    line = list(
      color = col,
      dash="dot"
    )
  )

}

annotations <- function(
    x = 0,
    text = 'text'
) {

  list(
    x = x,
    y = 1,
    text = text,
    showarrow = FALSE,
    #xref = 'paper',
    yref = 'paper',
    xanchor = 'right',
    yanchor = 'auto',
    xshift = 0,
    textangle = -90,
    yshift = 0,
    font = list(
      size = 15,
      color = "black",
      angle = '90'
    )
  )


}



# check for http errors;
check_for_errors <- function(
    response,
    source,
    futures = FALSE,
    call = rlang::caller_env(n = 2)
) {

  # 1) Evaluate error message
  # based on source and market;
  error_message <- rlang::eval_bare(
    get(
      paste0(
        source, 'Error'
      )
    )(
      response = response,
      futures = futures
    ),
    env = rlang::caller_env(n = 0)
  )


  # 2) Some APIs dosnt give
  # an error message;
  if (length(error_message) == 0) {

    error_message <- 'No error information.'

  }

  # 3) Throw an error
  # on user-side
  rlang::abort(
    message = paste(
      error_message
    ),
    call = call
  )

}

# check for errors
# in chosen exchange
# ie. the source
check_exchange_validity <- function(
    source,
    call = rlang::caller_env(n = 1)
) {

  # 0) get all available exchanges
  all_available_exchanges <- suppressMessages(
    availableExchanges()
  )

  if (!(source %in% all_available_exchanges)) {

    rlang::abort(
      message = c(
        paste(source, 'is not supported.'),
        'v' = paste(
          paste(
            all_available_exchanges,
            collapse = ', '
          ),
          'is currently supported'
        )
      ),
      call = call
    )

  }
}

# check fo rerrors
# in the chosen intervals;
# it depends on the chosen market
# and exchange
check_interval_validity <- function(
    interval,
    source,
    futures,
    call = rlang::caller_env(n = 1)
) {

  # 0) get all available intervals
  all_available_intervals <- suppressMessages(
    availableIntervals(
      source = source,
      futures = futures
    )
  )


  if (!(interval %in% all_available_intervals)) {

    rlang::abort(
      message = c(
        paste(
          'Interval',
          interval,
          'is not supported in',
          paste(
            source,
            ifelse(
              test = futures,
              yes = 'futures.',
              no = 'spot.'
            )
          )
        ),
        'v' = paste(all_available_intervals, collapse = ', ')
      ),
      call = call
    )

  }

}


convertDate <- function(
    date,
    is_response = FALSE,
    multiplier = 1,
    power = 1
) {

  # This function converts
  # epoch times to POSIXct

  # TODO: Change pwer
  # to character.
  if (!is_response) {

   output <-  tryCatch(
      expr = {
        as.numeric(
          as.POSIXct(
            date,
            tz = 'UTC',
            origin = "1970-01-01"
          )
        ) * (multiplier^power)
      },
      error = function(error) {

        rlang::abort(
          message = c(
            'Error in date format',
            'v' = 'Accepted formats:',
            '*' = as.character(Sys.Date()),
            '*' = as.character(
              format(
                Sys.time()
              )
            )
          ),
          call = rlang::caller_env(n = 9)
        )

      }
    )

  } else {

    # If there is an error
    # here; its on the API side
    #

    output <- tryCatch(
      expr = {
        as.POSIXct(
      date * (multiplier^power),
      tz = 'UTC',
      origin = "1970-01-01"
    )
      },
    error = function(error) {

      rlang::abort(
        message = c(
          'Error on API side',
          'i' = 'Contact maintainer, or submit a bugreport!'
        ),
        call = rlang::caller_env(n = 9)
      )



    }
    )


  }

  return(
    output
  )


}


flatten <- function(x) {
  if (!inherits(x, "list")) return(list(x))
  else return(unlist(c(lapply(x, flatten)), recursive = FALSE))
}


# package startup messages;
startup_message <- function(
    pkgname,
    pkgversion
) {

  # 1) get github release
  # using rvest
  github_release <- rvest::html_text(
    rvest::html_element(
      css = 'small',
      rvest::html_element(
        css = 'div',
        rvest::html_element(
          css = 'nav',
          rvest::read_html(
            x = 'https://serkor1.github.io/cryptoQuotes/index.html'
          )
        )
      )
    )
  )

  # 2) Generate CLI
  # formatted messages
  c(
    paste('Attaching', pkgname),
    'i' = paste('CRAN version:', pkgversion),
    'i' = paste('Development version:', github_release),
    '*' = paste('Release notes:',  "https://serkor1.github.io/cryptoQuotes/news/index.html")
  )



}


date_validator <- function(from, to) {

  # Function to parse and convert a date string
  parse_and_convert_date <- function(date) {
    if (!is.null(date)){
      parsed_date <- as.POSIXct(date, format = "%Y-%m-%d %H:%M:%S", tz = 'UTC')
      if (is.na(parsed_date)) {
        parsed_date <- as.POSIXct(date, format = "%Y-%m-%d", tz = 'UTC')
      }
      if (is.na(parsed_date)) {
        rlang::abort(
          message = c(
            'Error in date formats',
            'v' = 'Accepted formats:',
            '*' = as.character(Sys.Date()),
            '*' = as.character(
              format(
                Sys.time()
              )
            )
          ),
          call = rlang::caller_env(n = 1)
        )
      }
      return(parsed_date)
    } else {
      return(NULL)
    }
  }

  # Apply the function to both dates
  from <- parse_and_convert_date(from)
  to <- parse_and_convert_date(to)

  return(
    list(
      from = from,
      to   = to
    )

  )
}


check_internet_connection <- function() {

  # 0) check internet connection
  # before anything
  if (!curl::has_internet()) {

    rlang::abort(
      message = 'You are currently not connected to the internet. Try again later.',

      # disable traceback, on this error.
      trace = rlang::trace_back()
    )

  }

}



# script end;
