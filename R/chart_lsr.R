# script: Charting Long-Short Ratios
# date: 2024-01-30
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;


#' Chart the long-short ratios
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' The [lsr()]-function adds a scatter plot as a subplot to the chart colored by ratio size.
#'
#' @details
#' The long-short ratio is a market sentiment indicator on expected price movement.
#'
#' @param ratio A [xts::xts()]-object with the column LSRatio. See [get_lsratio()] for more details.
#' @param internal An empty [list()]. This is an internal helper-argument, ignore.
#'
#' @example man/examples/scr_LSR.R
#'
#' @family chart indicators
#' @family sentiment indicators
#' @family subcharts
#'
#' @returns A [plotly::plot_ly()]-object wrapped in [rlang::expr()]
#'
#' @export
lsr <- function(
    ratio,
    internal = list()) {
  structure(
    rlang::expr(
      {

        # 0) locate global
        # parameters to be passed
        # into the charting functions;

        # 0) locate global
        # parameters to be passed
        # into the charting functions;

        # internal_args <- flatten(lapply(!!rlang::enquos(internal), rlang::eval_tidy))
        internal_args <- flatten(lapply(!!rlang::enexpr(internal), rlang::eval_tidy))

        ticker <- internal_args$ticker
        deficiency <- internal_args$deficiency


        ratio <- toDF(
          quote = !!ratio
        )


        value <- ratio$ls_ratio

        ratio$color_scale <- round((30) * (value -0)/(2 - 0))


        color_scale <- if (deficiency){


          rev(paletteer::paletteer_c("grDevices::Cividis", 30))


        } else {
          paletteer::paletteer_c("grDevices::RdYlGn", 30)

        }




        ratio$color_scale <- color_scale[
          ratio$color_scale
        ]



        plotly::layout(
          yaxis = list(
            title = 'Long-Short Ratio'
          ),
          p = plotly::plot_ly(
            showlegend = FALSE,
            data = ratio,
            y = ~ls_ratio,
            x = ~Index,
            type = 'scatter',
            mode = 'lines+markers',
            line = list(
              color = 'gray',
              dash = 'dash',
              shape = 'spline',
              smoothing = 1.5
            ),
            marker = list(
              size = 10,
              color = ~color_scale,
              line = list(
                color = 'black',
                width = 2
              )
            )
          )
        )

      }
    ),
    class = "subchart"
  )


}


# script end;
