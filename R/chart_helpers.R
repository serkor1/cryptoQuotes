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


bar <- function(
    dark,
    plot,
    name,
    market,
    ...) {

  paper_bgcolor <- plot_bgcolor <- '#2b3139'

  font_color <- '#848e9c'

  grid_color <- '#40454c'

  if (!dark) {

    paper_bgcolor <- plot_bgcolor <- '#E3E3E3'

    font_color <- '#A3A3A3'

    grid_color <- '#D3D3D3'

  }



  plot <- plotly::layout(
    p = plot,
    paper_bgcolor = paper_bgcolor, # was D
    plot_bgcolor  = plot_bgcolor,
    font = list(
      size = 14,
      color = font_color
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
      text = paste(
        "<b>Ticker:</b>",
        name,
        "<b>Market:</b>",
        market

      ),
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
          gridcolor = grid_color # Was CCCCCC
        )
      ),
      chart_layout(
        x = length(plot),
        layout_element = "xaxis",
        layout_attribute = list(
          gridcolor = grid_color# was C3
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
