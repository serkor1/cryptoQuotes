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
    expr = {

      xts::as.xts(
        x
      )

    },
    error = function(error) {

      assert(
        FALSE,
        error_message = c(
          "x" = "Could not coerce to {.cls xts}",
          "i" = error$message
        )
      )

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

    x <- .f(
      x,
      ...
    )

  }

  names(x) <- tolower(names(x))

  zoo::fortify.zoo(
    x,
    names = "index"
  )

}

# var_ly <- function(
    #     variable) {
#
#   # 0) extract variable
#   # from the source
#   variable <- grep(
#     pattern     = variable,
#     x           = names(get("data",envir = parent.frame())),
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

    # The Plotly function to call, e.g., "add_lines", "add_ribbons"
    fun_name <- layer$type

    # Ensure the plot is passed as the first argument
    layer$params$p <- plot

    if (!"data" %in% names(layer$params)) {
      # If 'data' is not explicitly provided,
      #  assume the plot's original data should be used
      layer$params$data <- plot$x$data
    }

    # Dynamically call the Plotly function with
    #  the parameters specified in 'layer$params'
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
    utils::head(
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
    "1296000" = "2w",
    "2678400" = "1M",
    "2592000" = "1M",
    "2419200" = "1M",
    "2505600" = "1M",
    NULL
  )



}


#' Check if values are valid dates
#'
#' @description
#' This function check is equivalent to [is.numeric()], [is.logical()],
#' and checks for the date type classes POSIXct, POSIXt and Date.
#' And wether the character vector can be formatted to dates.
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
        !is.na(as.POSIXct(x)) | !is.na(
          as.POSIXct(
            x,
            format = "%Y-%m-%d %H:%M:%S")
        )
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
#' This function is a wrapper of [stopifnot()], [tryCatch()] and
#' [cli::cli_abort()] and asserts the truthfulness of the passed expression(s).
#' @param ... expressions >= 1. If named the names are used
#' as error messages, otherwise R's internal error-messages are thrown
#'
#' @param error_message character. An error message, supports [cli::cli]-formatting.
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
    conditions <- c(...)

    # 2.2) if !is.null(condition_names) the
    # above condition never gets evaluated and
    # stopped otherwise, if there is errors
    #
    # The condition is the names(list()), and is
    # the error messages written on lhs of the the assert
    # function
    if (all(conditions)) {

      # Stop the funciton
      # here if all conditions
      # are [TRUE]
      return(NULL)

    } else {

      cli::cli_abort(
        message = c(
          "x" = named_expressions[which.min(conditions)]
        ),
        call = sys.call(
          1 - length(sys.calls())
        )
      )

    }

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
        message = if (is.null(error_message) || number_expressions != 1)
          error$message else
            error_message,
        call    = sys.call(
          1 - length(sys.calls())
        )
      )

    }
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

  if (!inherits(x, "list"))
    list(x)
  else
    unlist(c(lapply(x, flatten)), recursive = FALSE)
}



# base-chart colors; ####
movement_color <- function(
    deficiency = FALSE) {

  palette  <- c("#d3ba68","#d5695d","#5d8ca8","#65a479")
  location <- if (deficiency) c(3,1) else c(4,2)

  list(
    bullish = palette[location[1]],
    bearish = palette[location[2]]
  )

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
  scale_factor <- multiplier ** if (is_numeric) -1 else 1

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
            fmt = "
            Unexpected error. Contact the package maintainer or submit a %s.
            ",
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
#' @param length a [numeric]-value of [length] 1.
#' The desired distance between `from` and `to`.
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
    tz = Sys.timezone(),
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
        tz = Sys.timezone(),
        origin = origin_date
      )
    )
  )

  # 4) return statement
  # as interval
  interval

}


# pkg-startup; ####

# This information contains
# links to the development blog, github source code
# and guides
pkg_information <- function(){

  # 1) wrattep in format
  # inline to ensure that the
  # message be supressed at startup
  cli::format_inline(
    c(
      paste(
        cli::col_br_red(cli::symbol$heart),
        cli::style_hyperlink(
          text = cli::col_br_blue('release notes'),
          url = 'https://serkor1.github.io/cryptoQuotes/news/index.html'
        ),
        "\n"
      ),
      # Source code  link
      paste(
        cli::col_br_yellow(cli::symbol$star),
        "Browse the",
        cli::style_hyperlink(
          text = cli::col_br_blue("source code"),
          url = "https://github.com/serkor1/cryptoQuotes/"
        ),
        "\n"
      ),

      # link to pkgdown website
      paste(
        cli::col_br_yellow(cli::symbol$star),
        "Read the",
        cli::style_hyperlink(
          text = cli::col_br_blue("documentation"),
          url = 'https://serkor1.github.io/cryptoQuotes/'
        ),
        "\n"
      ),

      paste(
        cli::col_br_yellow(cli::symbol$star),
        "Join the",
        cli::style_hyperlink(
          text = cli::col_br_blue("discussion"),
          url = 'https://github.com/serkor1/cryptoQuotes/discussions'
        )
      )
    )
  )

}


# This is the cryptoQuotes
# header that prints the line
# with pkgname and version
pkg_header <- function(
    pkgname) {


  cli::cli(
    cli::cli_h1(
      text =  paste(
        pkgname,
        utils::packageVersion(
          pkgname
        )
      )
    )

  )

}



#' Create a list of layout elements on subcharts
#'
#' @param x [integer]-vector of [length] 1.
#' @param layout_element [character]-vector of [length] 1.
#' [plotly::layout] elements. See example.
#' @param layout_attribute [character]-vector of [length] 1.
#' [plotly::layout] element value. See example.
#'
#' @examples
#' \dontrun{
#' chart_layout(
#'   x = 1:plot_list_length,
#'   layout_element = "yaxis",
#'   layout_attribute = list(
#'   gridcolor = if (dark) "#40454c" else  '#D3D3D3' # Was CCCCCC
#'     )
#' )
#' }
#'
#'
#' @return A [list] of layout elements.
#' @keywords internal
#' @family development tools
chart_layout <- function(
    x,
    layout_element,
    layout_attribute) {

  stats::setNames(
    lapply(
      0:x,
      function(i){

        layout_attribute

      }


    ),
    nm = paste0(layout_element, c("", 1:x))
  )

}


chart_theme <- function(
    dark) {

  if (dark) {
    list(
      paper_bgcolor = '#2b3139',
      plot_bgcolor  = '#2b3139',
      font_color    = '#848e9c',
      grid_color    = '#40454c'
    )
  } else {
    list(
      paper_bgcolor = '#E3E3E3',
      plot_bgcolor  = '#E3E3E3',
      font_color    = '#A3A3A3',
      grid_color    = '#D3D3D3'
    )
  }
}


bar <- function(
    dark,
    plot,
    name,
    market,
    date_range,
    modebar,
    scale,
    ...) {

  # 0) chart theme
  theme <- chart_theme(dark = dark)

  title_text <- if (!is.null(market))
    sprintf(
      "<b>Ticker:</b> %s <b>Market:</b> %s<br><sub><b>Period:</b> %s</sub>",
      name,
      market,
      date_range
    )
  else
    sprintf(
      "<b>Ticker:</b> %s<br><sub><b>Period:</b> %s</sub>",
      name,
      date_range
    )

  plot <- plotly::layout(
    p = plot,
    margin = list(l = 5, r = 5, b = 5, t = if(modebar) 85 else 55),
    paper_bgcolor = theme$paper_bgcolor,
    plot_bgcolor  = theme$plot_bgcolor,
    font = list(
      size = 14 * scale,
      color = theme$font_color
    ),
    showlegend = TRUE,
    legend = list(
      orientation = 'h',
      x = 0,
      y = 100,
      yref="container",
      title = list(
        text = "<b>Indicators:</b>",
        font = list(
          size = 16 * scale
        )
      )
    ),
    title = list(
      text = title_text,
      font = list(
        size = 20 * scale
      ),
      x = 1,
      xref = "paper",
      xanchor = "right"
    )

  )


  do.call(
    what = plotly::layout,
    args = c(
      list(plot),
      chart_layout(
        x = length(plot),
        layout_element = "yaxis",
        layout_attribute = list(
          gridcolor = theme$grid_color # Was CCCCCC
        )
      ),
      chart_layout(
        x = length(plot),
        layout_element = "xaxis",
        layout_attribute = list(
          gridcolor = theme$grid_color# was C3
        )
      )
    )
  )

}


as_rgb <- function(
    hex_color,
    alpha = NULL) {

  # Remove the '#' if present and convert to RGB values
  rgb_values <- grDevices::col2rgb(hex_color)

  # Format RGB values
  rgb_string <- sprintf(
    fmt = "rgb(%d, %d, %d)",
    rgb_values[1, ],
    rgb_values[2, ],
    rgb_values[3, ]
  )

  # Check if alpha is provided
  if (!is.null(alpha)) {

    assert(
      alpha >= 0 & alpha <= 1,
      error_message = c(
        "x" = sprintf(
          fmt = "{.arg alpha} has to be in ]0, 1[-range. Got {.val %s}.",
          alpha
        )
      )
    )

    # Append alpha for rgba() format
    rgb_string <- sprintf(
      "rgba(%d, %d, %d, %.2f)",
      rgb_values[1, ],
      rgb_values[2, ],
      rgb_values[3, ],
      alpha
    )
  }

  rgb_string
}

normalize <- function(
    x,
    range,
    value
) {

  # 0) get the minimum/maximum
  # of the vector
  min_x <- min(value, na.rm = TRUE)
  max_x <- max(value, na.rm = TRUE)

  # 1) scale x within
  # the range
  scaled_x <- abs(
    (x - min_x) / (max_x - min_x)
  )

  # factor
  factor_x <- (max(range) - min(range))

  # 3) create range
  # and return
  pmin(
    pmax(
      ceiling(
        scaled_x * factor_x
      ),
      1
    ),
    30
  )

}


check_indicator_call <- function(
    system_calls = sys.calls(),
    caller       = match.call(envir = parent.frame())) {

  # 0) get the entire call stack
  # to determine the calling function
  call_stack <- as.character(
    lapply(system_calls, `[[`, 1)
  )

  # 1) get the calling calling
  # function, ie. SMA, EMA etc
  calling_function <- sys.call(-1)

  calling_function <- as.character(
    calling_function[[1]]
    )[length(calling_function)]

  # 2) check the location
  # of chart
  location_chart <- which(call_stack == "chart")
  location_indicator <- which(call_stack == calling_function)


  # 3) assert that the indicator
  # is being called from the charting
  # function, or some wrapper around
  # chart
  assert(
    any(call_stack == "chart") & location_chart < location_indicator,
    error_message = c(
      "x" = sprintf(
        "The {.fn %s}-function is called outside {.fn chart}",
        call_stack
      ),

      "i" = paste(
        "Run",
        cli::code_highlight(
          code = "cryptoQuotes::chart(...)",
          code_theme = "Chaos"
        ),
        "to build charts."
      )
    )
  )

}

# script end;
