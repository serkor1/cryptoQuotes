# script: create chart helpers
# date: 2024-04-06
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;


#' Create a list of layout elements on subcharts
#'
#' @param x [integer]-vector of [length] 1.
#' @param layout_element [character]-vector of [length] 1. [plotly::layout] elements. See example.
#' @param layout_attribute [character]-vector of [length] 1. [plotly::layout] element value. See example.
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
    ...) {


  # 0) chart theme
  theme <- chart_theme(
    dark = dark
  )




  title_text <- ifelse(
    !is.null(market),
    yes = sprintf(
      fmt = "<b>Ticker:</b> %s <b>Market:</b> %s<br><sub><b>Period:</b> %s</sub>",
      name,
      market,
      date_range
    ),
    no = sprintf(
      fmt = "<b>Ticker:</b> %s<br><sub><b>Period:</b> %s</sub>",
      name,
      date_range
    )

  )


  plot <- plotly::layout(
    p = plot,
    margin = list(l = 5, r = 5, b = 5, t = 65),
    paper_bgcolor = theme$paper_bgcolor,
    plot_bgcolor  = theme$plot_bgcolor,
    font = list(
      size = 14,
      color = theme$font_color
    ),
    legend = list(
      orientation = 'h',
      x = 0,
      y = 100,
     yref="container",
      title = list(
        text = "<b>Indicators:</b>",
        font = list(
          size = 18
        )
      )
    ),
    title = list(
      text = title_text,
      font = list(
        size = 24
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



# Function to convert hex color to CSS rgb() or rgba() string format
hex_to_rgb_string <- function(hex_color, alpha = NULL) {
  # Remove the '#' if present and convert to RGB values
  rgb_values <- grDevices::col2rgb(hex_color)

  # Format RGB values
  rgb_string <- sprintf("rgb(%d, %d, %d)", rgb_values[1, ], rgb_values[2, ], rgb_values[3, ])

  # Check if alpha is provided
  if (!is.null(alpha)) {
    # Validate alpha value
    if(alpha < 0 || alpha > 1) {
      stop("Alpha value should be between 0 and 1.")
    }
    # Append alpha for rgba() format
    rgb_string <- sprintf("rgba(%d, %d, %d, %.2f)", rgb_values[1, ], rgb_values[2, ], rgb_values[3, ], alpha)
  }

  return(rgb_string)
}

# script end;
