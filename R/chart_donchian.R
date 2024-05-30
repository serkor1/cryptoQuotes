# script: Donchian Channel
# author: Serkan Korkmaz, serkor1@duck.com
# date: 2024-05-30
# objective: Charting the Donchian Channel. This was originally
# an example in the vignette custom_indicators - but has now been permanently
# added as a tribute to the turtle trading system
# script start;

#' @title
#' Add Donchian Channels
#' to the chart
#'
#' @description
#' `r lifecycle::badge("experimental")`
#'
#' A high-level [plotly::add_lines()]-wrapper function that interacts
#' with the [TTR::DonchianChannel()]-function.
#' The function adds Donchian Channels
#' to the main [chart()].
#'
#' @usage donchian_channel(
#'  n = 10,
#'  include.lag = FALSE,
#'  color = '#4682b4',
#'  ...
#' )
#'
#' @inheritParams TTR::DonchianChannel
#' @param color A [character]-vector of [length] 1. "#4682b4" by default.
#'
#' @inherit kline
#'
#' @family chart indicators
#' @family main chart indicators
#' @author Serkan Korkmaz
#' @export
donchian_channel <- function(
    ## these arguments are the
  ## available arguments in the TTR::DonchianChannel
  ## function
  n = 10,
  include.lag = FALSE,
  color = '#4682b4',
  ...
) {

  check_indicator_call()

  structure(
    .Data = {

      ## 1) define args
      ## as a list from the ellipsis
      ## which is how the chart-function
      ## communicates with the indicators
      args <- list(
        ...
      )

      ## 2) define the data, which in this
      ## case is the indicator. The indicator
      ## function streamlines the data so it works
      ## with plotly
      data <- indicator(
        ## this is just the ticker
        ## that is passed into the chart-function
        x = args$data,

        ## columns are the columns of the ohlc
        ## which the indicator is calculated on
        columns = c("high", "low"),

        ## the function itself
        ## can be a custom function
        ## too.
        .f = TTR::DonchianChannel,

        ## all other arguments
        ## passed into .f
        n = n,
        include.lag = include.lag
      )

      ## each layer represents
      ## each output from the indicator
      ## in this case we have
      ## high, mid and low.
      ##
      ## The lists represents a plotly-function
      ## and its associated parameters.
      layers <- list(
        ## high
        list(
          type = "add_lines",
          params = list(
            showlegend = FALSE,
            legendgroup = "DC",
            name = "high",
            inherit = FALSE,
            data = data,
            x    = ~index,
            y    = ~high,
            line = list(
              color = color,
              width = 0.9
            )
          )
        ),

        ## mid
        list(
          type = "add_lines",
          params = list(
            showlegend = FALSE,
            legendgroup = "DC",
            name = "mid",
            inherit = FALSE,
            data = data,
            x    = ~index,
            y    = ~mid,
            line = list(
              color = color,
              dash ='dot',
              width = 0.9
            )
          )
        ),

        ## low
        list(
          type = "add_lines",
          params = list(
            showlegend = FALSE,
            legendgroup = "DC",
            name = "low",
            inherit = FALSE,
            data = data,
            x    = ~index,
            y    = ~low,
            line = list(
              color = color,
              width = 0.9
            )
          )
        )
      )

      ## we can add ribbons
      ## to the main plot to give
      ## it a more structured look.
      plot <- plotly::add_ribbons(
        showlegend = TRUE,
        legendgroup = 'DC',
        p = args$plot,
        inherit = FALSE,
        x = ~index,
        ymin = ~low,
        ymax = ~high,
        data = data,
        fillcolor = as_rgb(alpha = 0.1, hex_color = color),
        line = list(
          color = "transparent"
        ),
        name = paste0("DC(", paste(c(n), collapse = ", "), ")")
      )

      ## the plot has to be build
      ## using the cryptoQuotes::build-function
      invisible(
        build(
          plot,
          layers = layers
        )
      )

    }
  )

}


# script end;
