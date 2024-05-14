# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup;
rm(list = ls()); gc(); devtools::load_all()


# 1) SPY
# SPY <- quantmod::getSymbols(
#   "SPY",
#   auto.assign = FALSE
# )

line <- function(
    price = "close",
    ...) {

  call_stack <- as.character(
    lapply(sys.calls(), `[[`, 1)
  )

  assert(
    call_stack[1] != as.character(match.call()),
    error_message = c(
      "x" = "Error",
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

  structure(
    .Data = {

      # 0) arguments passed
      # via the chart function
      args <- list(
        ...
      )

      data <- indicator(args$data, columns = price)

      p <- plotly::plot_ly(
        data = data,
        x    = ~index,
        y    = as.formula(
          paste("~", price)
        ),
        type = "scatter",
        mode = "lines",
        showlegend = TRUE,
        legendgroup = "price",
        name        = paste0(
          to_title(price),
          " (", args$interval, ")"
        ),
        line = list(
          width = 1.2,
          color = "#d38b68"# was: "#d3ba68"
        )
      )

      invisible({
        plotly::layout(
          p = p,
          xaxis = list(
            rangeslider = list(
              visible = args$slider,
              thickness    = 0.05
            )
          )
        )
      })

    },
    class = c("pricechart", "plotly", "htmlwidget")
  )

}


chart(
  ticker = BTC,
  main   = line(price = "close"),
  indicator = list(
    bollinger_bands(color = "steelblue")
  ),
  sub = list(
    volume()
  ),
  options = list(
    dark = TRUE,
    slider = TRUE
  )
)

# script end;
