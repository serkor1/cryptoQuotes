# script: Charting the Fear and Greed Index
# date: 2024-01-30
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;

#' Chart the Fear and Greed Index
#'
#' @description
#'
#' `r lifecycle::badge("experimental")`
#'
#' The fear and greed index is a market sentiment indicator that measures investor emotions to
#' gauge whether they are generally fearful (indicating potential selling pressure) or greedy (indicating potential buying enthusiasm)
#'
#' @param index The Fear and Greed Index created by [getFGIndex()]
#' @param internal An empty [list]. Used for internal purposes. Ignore.
#'
#' @example man/examples/scr_FGIndex.R
#'
#' @details
#' The Fear and Greed Index goes from 0-100, and can be classifed as follows
#'
#' \itemize{
#'   \item 0-24, Extreme Fear
#'   \item 25-44, Fear
#'   \item 45-55, Neutral
#'   \item 56-75, Greed
#'   \item 76-100, Extreme Greed
#' }
#'
#' @family chart indicators
#' @family sentiment indicators
#' @family subcharts
#'
#' @returns Invisbly returns a plotly object.
#' @export
fgi <- function(
    index,
    internal = list()) {
  structure(
    rlang::expr(
      {

        # 0) locate global
        # parameters to be passed
        # into the charting functions;

        internal_args <- flatten(lapply(!!rlang::enexpr(internal), rlang::eval_tidy))
        deficiency <- internal_args$deficiency


        candle_color <- movement_color(
          deficiency = deficiency
        )


        DT <- toDF(
          quote = !!index
        )


        color_scale <- if (deficiency){


          rev(paletteer::paletteer_c("grDevices::Cividis", 30))


        } else {
          paletteer::paletteer_c("grDevices::RdYlGn", 30)

        }

        value <- DT$fgi

        DT$color_scale <- ceiling(
          (1-30) * (value -0)/(100 - 0) + 30
        )

        DT$color_scale <- rev(color_scale)[
          DT$color_scale
        ]

        plotly::layout(
          yaxis = list(
            title = 'Fear and Greed Index'
          ),
          p = plotly::plot_ly(
            showlegend = TRUE,
            name = "FGI",
            data = DT,
            y = ~fgi,
            x = ~index,
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
