# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup;
{rm(list = ls()); gc(); devtools::load_all()}

available_tickers(
  "kraken",
  FALSE
)

source <- "kraken"
futures <- FALSE

response <- GET(
  url = baseUrl(
    source  = source,
    futures = futures
  ),
  endpoint = endPoint(
    source  = source,
    futures = futures,
    type    = 'ticker'
  )
)


do.call(
  `c`,
  (
    X   = response$result,
    FUN = function(x){
      if (x$status == "online"){
        x$altname
      }},
    USE.NAMES = FALSE,
    simplify = TRUE)
)





class(
  
)


response$result[[1]]


  vapply(response$result, function(x){
    x$altname
  }, 
  FUN.VALUE = character(1),USE.NAMES = FALSE
  )

chart(
  ticker = BTC,
  indicator = list(
    sma(),
    wma()
  ),
  sub = list(
    rsi(),
    macd()
  ),
  options = list(
    width = 2
  )
)

print.chart <- function(x) {

  suppressWarnings(
    print(x)
  )

}



library(plotly)
sloop::s3_dispatch(
  call = print(plot_ly())
)

my_chart

class(my_chart)
my_chart



# lapply vs for loop
foo <- function() {

  lapply(
    X = 1:1000,
    FUN = function(x) {
      x * 2
    }
  )

}

bar <- function() {

  for (i in 1:1000) {

    i * 2

  }

}

baz <- function() {

  vapply(
    X = 1:1000,
    FUN = function(x) {

      x * 2

    },
    FUN.VALUE = as.numeric(1000)
  )

}

microbenchmark::microbenchmark(
  foo(),
  bar(),
  baz()
)

response <- list(
  a = 1,
  b = 2,
  c = data.frame(
    a = 1
  )
)

which(

)

idx <- vapply(
  X = response,
  FUN.VALUE = logical(1),
  FUN = inherits,
  what = c('array', 'matrix', 'data.frame')
)


# script end;



library(plotly)

# Create a sample subplot with various types of traces
x <- c(1, 2, 3, 4)
y1 <- c(10, 11, 12, 13)
y2 <- c(20, 21, 22, 23)
y3 <- c(30, 31, 32, 33)

p <- subplot(
  plot_ly(x = x, y = y1, type = 'scatter', mode = 'lines', name = 'Line 1'),
  plot_ly(x = x, y = y2, type = 'scatter', mode = 'lines+markers', name = 'Line 2'),
  plot_ly(x = x, y = y3, type = 'bar', name = 'Bar')
)

# Vectorized approach to change linewidth for scatter traces only
scatter_indices <- which(sapply(p$x$data, function(trace) trace$type == "scatter"))

p <- style(p, line = list(width = 4), traces = scatter_indices)

p
