# script: helpr
# date: 2023-09-22
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A class of helper
# function
# script start;
indicator <- function(
    x,
    columns = NULL,
    .f = NULL,
    ...) {

  x <- tryCatch(
    xts::as.xts(
      x
    ),
    error = function(error) {

      x

    }
  )

  x <- do.call(
    cbind,
    # Set  names here
    # and remove from pull
    stats::setNames(
      lapply(
        X = if (is.null(columns)) names(x) else columns,
        FUN = pull,
        from = x
      ),
      nm = if (is.null(columns))  names(x) else columns
    )


  )


  # 1) get the indicator function
  # for each
  if (!is.null(.f)) {

    x = .f(
      x,
      ...
    )

  }


  names(x) <- tolower(names(x))

  zoo::fortify.zoo(
    x,
    names = c(
      "index"
    )
  )


}




# var_ly <- function(
    #     variable) {
#
#   # 0) extract variable
#   # from the source
#   variable <- grep(
#     pattern     = variable,
#     x           = names(get("args",envir = parent.frame())$data),
#     ignore.case = TRUE,
#     value       = TRUE
#   )
#
#   # 1) assert variable
#   # existance
#   assert(
#     !identical(
#       variable,
#       character(0)
#     ) & length(variable) == 1,
#     error_message = c(
#       "x" = "Error in {.val variable}"
#     )
#   )
#
#   # 2) return as formula
#   as.formula(
#     paste(
#       '~', variable
#     )
#   )
#
# }




build <- function(
    plot,
    layers,
    ...
) {

  # 0) generate function
  apply_layer <- function(
    plot,
    layer
  ) {

    # Generalize function calling based on the 'type' attribute
    fun_name <- layer$type  # The Plotly function to call, e.g., "add_lines", "add_ribbons"
    layer$params$p <- plot  # Ensure the plot is passed as the first argument

    if (!"data" %in% names(layer$params)) {
      # If 'data' is not explicitly provided, assume the plot's original data should be used
      layer$params$data <- plot$x$data
    }

    # Dynamically call the Plotly function with the parameters specified in 'layer$params'
    do.call(
      get(
        fun_name,
        envir = asNamespace('plotly')
      ), args = layer$params
    )

  }

  plotly::layout(
    p =  Reduce(
      f = apply_layer,
      x = layers,
      init = plot
    ),
    ...
  )


}




# converting Quotes to and from data.frames; ####

to_title <- function(
    x) {

  gsub("\\b(.)", "\\U\\1", tolower(x), perl = TRUE)
}




find_mode <- function(
    x) {

  # 1) create a trable
  # of values
  frequency_table <- table(
    x
  )

  # 2) find the mode
  # and return as character
  value <- as.character(
    names(frequency_table)[which.max(frequency_table)]
  )

  value

}


infer_interval <- function(
    x) {


  # 0) extract
  # index
  index <- zoo::index(
    head(
      x = x,
      # n should be the minimum
      # of available rows and 7. 7
      # was chosen randomly, but its important
      # that its odd numbered so consensus can be
      # reached. This application is 20x faster
      # than using the entire dataset
      # and reaches the same conclusion
      n = min(nrow(x), 7)
    )
  )

  # 1) calculate
  # differences
  x <- as.numeric(
    difftime(
      time1 = index[-1],
      time2 = index[-length(index)],
      units = "secs"
    )
  )

  x <- find_mode(x)


  switch(
    x,
    "1" = "1s",
    "60" = "1m",
    "180" = "3m",
    "300" = "5m",
    "900" = "15m",
    "1800" = "30m",
    "3600" = "1h",
    "7200" = "2h",
    "14400" = "4h",
    "21600" = "6h",
    "28800" = "8h",
    "43200" = "12h",
    "86400" = "1d",
    "259200" = "3d",
    "604800" = "1w",
    "1209600" = "2w",
    "2629746" = "1M",
    NULL
  )



}


#' Check if values are valid dates
#'
#' @description
#' This function check is equivalent to [is.numeric()], [is.logical()], and checks for the date type classes
#' POSIXct, POSIXt and Date. And wether the character vector can be formatted to dates.
#'
#' @param x object to be tested
#'
#'
#' @family development tools
#' @keywords internal
#' @returns [TRUE] if its either POSIXct, POSIXt or Date. [FALSE] otherwise.
is.date <- function(x){


  # check if its
  # a date
  indicator <- inherits(
    x = x,
    what = c("Date","POSIXct","POSIXt")
  )


  if (!indicator & is.character(x)){


    indicator <- tryCatch(
      expr = {
        # Either of these have to be
        # non-NA to work
        !is.na(as.POSIXct(x)) | !is.na(as.POSIXct(x,format = "%Y-%m-%d %H:%M:%S"))
      },
      error = function(error){

        FALSE

      }
    )

  }

  indicator

}

#' Assert truthfulness of conditions before evaluation
#'
#'
#' @description
#' This function is a wrapper of [stopifnot()], [tryCatch()] and [cli::cli_abort()] and asserts
#' the truthfulness of the passed expression(s).
#' @param ... expressions >= 1. If named the names are used as error messages, otherwise
#' R's internal error-messages are thrown
#'
#' @param error_message character. An error message, supports [cli]-formatting.
#' @example man/examples/scr_assert.R
#' @seealso [stopifnot()], [cli::cli_abort()], [tryCatch()]
#' @keywords internal
#' @returns [NULL] if all statements in ... are [TRUE]
assert <- function(..., error_message = NULL) {

  # 1) count number of expressions
  # in the ellipsis - this
  # is the basis for the error-handling
  number_expressions <- ...length()
  named_expressions  <- ...names()


  # 2) if there is more than
  # one expression the condtions
  # will either be stored in an list
  # or pased directly into the tryCatch/stopifnot
  if (number_expressions != 1 & !is.null(named_expressions)){

    # 2.1) store all conditions
    # in a list alongside its
    # names
    conditions <- list(...)

    # 2.2) if !is.null(condition_names) the
    # above condition never gets evaluated and
    # stopped otherwise, if there is errors
    #
    # The condition is the names(list()), and is
    # the error messages written on lhs of the the assert
    # function
    for (condition in named_expressions) {

      # if TRUE abort
      # function
      if (!eval.parent(conditions[[condition]])) {

        cli::cli_abort(
          c("x" = condition),

          # the call will reference the caller
          # by default, so we need the second
          # topmost caller
          call = sys.call(
            1 - length(sys.calls())
          )
        )


      }

    }

    # stop the function
    # here
    return(NULL)

  }

  # 3) if there length(...) == 1 then
  # above will not run, and stopped if anything

  tryCatch(
    expr = {
      eval.parent(
        substitute(
          stopifnot(exprs = ...)
        )
      )
    },
    error = function(error){

      # each error message
      # has a message and call
      #
      # the call will reference the caller
      # by default, so we need the second
      # topmost caller

      cli::cli_abort(
        # 3.1) if the length of expressions
        # is >1, then then the error message
        # is forced to be the internal otherwise
        # the assert function will throw the same error-message
        # for any error.
        message = if (is.null(error_message) || number_expressions != 1) error$message else error_message,
        call    = sys.call(
          1 - length(sys.calls())
        )
      )

    }
  )

}

toDF <- function(quote) {


  # this function converts
  # the quote to a data.frame
  # for the plotting and reshaping

  attr_list <- attributes(quote)$source
  # 2) convert to
  # data.frame
  DF <- as.data.frame(
    zoo::coredata(quote),
    row.names = NULL
  )

  colnames(DF) <- tolower(
    colnames(DF)
  )

  # 3) add the index;
  DF$index <- zoo::index(
    quote
  )

  # 1) determine
  # wether the the day is closed
  # green
  if (all(c('open', 'close') %in% colnames(DF))) {

    DF$direction <- ifelse(
      test = DF$close > DF$open,
      yes  = 'Increasing',
      no   = 'Decreasing'
    )

  }


  attributes(DF)$source <- attr_list

  return(
    DF
  )

}


pull <- function(
    from,
    what = "Open") {


  # 0) identify column
  # by name
  column <- grep(
    pattern = what,
    x       = colnames(from),
    ignore.case = TRUE,
    value = TRUE
  )

  assert(
    !identical(character(0), column),
    error_message = c(
      "x" = sprintf(
        fmt = "Could not find column {.val %s}",
        what
      )
    )
  )


  stats::setNames(
    do.call(
      what = `$`,
      args = list(
        from,
        column
      )
    ),
    nm = tolower(what)
  )

}





toQuote <- function(DF) {

  quote <- xts::as.xts(
    DF[,grep(pattern = 'open|high|low|close|volume|index',x = colnames(DF), ignore.case = TRUE)]
  )

  zoo::index(quote) <- as.POSIXct(
    DF$index
  )

  attributes(quote)$source <- attributes(DF)$source

  quote
}

# Plotly parameters; ####
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
      # color = "black",
      angle = '90'
    )
  )


}



check_internet_connection <- function() {

  # 0) check internet connection
  # before anything
  assert(
    curl::has_internet(),
    error_message = c(
      "x" = "You are currently not connected to the internet."
    )
  )

}


coerce_date <- function(x){

  if (!is.null(x)) {

    as.POSIXct(
      x = x,
      tz = Sys.timezone(),
      origin = "1970-01-01"
    )
  } else {

    NULL

  }


}

# general helpers; ####
#' flatten nested lists
#'
#' @description
#' `r lifecycle::badge("stable")`
#'
#' Flatten a nested [list], regardless of its level of nesting.
#'
#' @param x A [list]
#'
#' @example man/examples/devtools_flatten.R
#'
#' @family development tools
#'
#' @returns An unnested [list]
#'
#' @keywords internal
flatten <- function(x) {

  if (!inherits(x, "list")) return(list(x)) else return(unlist(c(lapply(x, flatten)), recursive = FALSE))
}



# base-chart colors; ####

movement_color <- function(deficiency = FALSE){

  palette <- c(
    "#d3ba68",
    "#d5695d",
    "#5d8ca8",
    "#65a479"
  )



  if (deficiency) {

    list(
      bullish = palette[3],
      bearish = palette[1]
    )

  } else {

    list(
      bullish = palette[4],
      bearish = palette[2]
    )
  }

}



#' Convert dates passed to UNIX
#'
#' @description
#' This function converts dates to UNIX time if passed to the API, and converts
#' it to [POSIXct] from API
#'
#'
#' @param x a [numeric] vector, or [date]-type object
#' @param multiplier [numeric]
#'
#' @details
#' If x is numeric, then the function assumes
#' that its a return value
#'
#' @family development tools
#'
#' @keywords internal
#' @returns A vector of same length as x.
convert_date <- function(
    x,
    multiplier) {


  # NOTE: If its numeric its a return
  # value from the API
  is_numeric <- is.numeric(x)

  # calculate scale
  # factor
  #
  # If the values are numeric
  # it is returned from the
  # API
  scale_factor <- multiplier ** ifelse(is_numeric, -1, 1)

  if (is_numeric) {

    # NOTE: Only this part
    # needs to be in try

    x <- tryCatch(
      expr = {
        as.POSIXct(
          x = x * scale_factor,
          tz = Sys.timezone(),
          origin = "1970-01-01"
        )
      },
      error = function(error){
        assert(
          FALSE,
          error_message = sprintf(
            fmt = "Unexpected error. Contact the package maintainer or submit a %s.",
            cli::style_hyperlink(
              text = cli::col_br_red("bug report"),
              url = "https://github.com/serkor1/cryptoQuotes"
            )
          )
        )
      }
    )

  } else {

    # NOTE: All dates passed into
    # this function from
    # the get_*-function are already
    # validated and checked so we
    # can just go ahead and make the numeric values
    x <- as.numeric(x) * scale_factor


  }

  x

}


#' Get the minimum and maximum date range
#'
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' All [available_exchanges()] have different limitations on the
#' returned data this function is adaptive in nature so enforces
#' compliance on the limits
#'
#' @inheritParams get_quote
#' @param length a [numeric]-value of [length] 1. The desired distance between `from` and `to`.
#'
#'
#' @returns
#'
#' A vector of minimum and maximum dates.
#'
#'
#' @family development tools
#' @keywords internal
#' @author Serkan Korkmaz
#'
default_dates <-function(
    interval,
    from   = NULL,
    to     = NULL,
    length = 200,
    limit  = NULL) {


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
  interval_length <- length + (granularity == "days")

  interval_seq <- seq(
    from = starting_point,
    by = paste0(operation, value, " ", granularity),
    length.out = interval_length
  )

  if (!is.null(limit)) interval_seq <-  utils::head(interval_seq, limit)

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
      as.POSIXct(
        current_time,
        tz = "UTC",
        origin = origin_date
      )
    )
  )

  # 4) return statement
  # as interval
  interval

}

# script end;
