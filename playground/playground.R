# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup;
rm(list = ls()); gc(); devtools::load_all()


BTC <- get_quote(
  "BTCUSDT",
  from = Sys.Date() - 3000,
  to   = Sys.Date()
)


foo <- function() {
  window(
    BTC,
    start = "2023-09-18 02:00:00",
    end   = "2023-12-04 01:00:00"
  )
}

bar <- function(){
  BTC[paste(c("2023-09-18 02:00:00", "2023-12-04 01:00:00"),collapse = "/")]
}

class(bar())
class(foo())
stopifnot(setequal(foo(), bar()))

microbenchmark::microbenchmark(
  foo(),
  bar(),times = 1000
)


# foo <- function() {
#
#   Sys.sleep(1)
#   get_quote("BTCUSDT", "binance")
# }
#
# microbenchmark::microbenchmark(
#   foo()
# )
#
#
# microbenchmark::microbenchmark(
#   assert(
#     "Not TRUE" = TRUE & TRUE,
#     "Get rekt" = TRUE
#   )
# )
#
#
# vector <- LETTERS
#
#
# foo <- function() {
#
#
#   vector[vector %in% "G"]
#
#
# }
#
# baz <- function() {
#
#
#   vector[grepl(pattern = "G", vector)]
#
#
# }
#
# stopifnot(
#   setequal(
#     baz(),
#     foo()
#   )
# )
#
# microbenchmark::microbenchmark(
#   foo(),
#   baz()
# )


test_df <- data.frame(
  labels = c(
    '1m',
    '3m',
    '5m',
    '15m',
    '30m',
    '1h',
    '2h',
    '4h',
    '6h',
    '8h',
    '12h',
    '1d',
    '3d',
    '1w',
    '1M'
  ),
  values = c(
    '1m',
    '3m',
    '5m',
    '15m',
    '30m',
    '1h',
    '2h',
    '4h',
    '6h',
    '8h',
    '12h',
    '1d',
    '3d',
    '1w',
    '1M'
  )
)



foo <- function(){

  test_df$values[
    grepl(paste0('^', "12h", '$'), test_df$values)
  ]

}


test_vector <- c(
  '1m',
  '3m',
  '5m',
  '15m',
  '30m',
  '1h',
  '2h',
  '4h',
  '6h',
  '8h',
  '12h',
  '1d',
  '3d',
  '1w',
  '1M'
)

test_vector_nm <-  c(
  '1m',
  '3m',
  '5m',
  '15m',
  '30m',
  '1h',
  '2h',
  '4h',
  '6h',
  '8h',
  '12h',
  '1d',
  '3d',
  '1w',
  '1M'
)

names(test_vector) <-  c(
  '1m',
  '3m',
  '5m',
  '15m',
  '30m',
  '1h',
  '2h',
  '4h',
  '6h',
  '8h',
  '12h',
  '1d',
  '3d',
  '1w',
  '1M'
)

intervals <- function(
    values,
    labels) {

  # set the names
  names(values) <- labels

}

bar <- function() {

  test_vector_nm[test_vector %in% "12h"]


}

baz <- function() {

  names(test_vector[test_vector %in% "12h"])

}

microbenchmark::microbenchmark(
  foo(),
  bar(),
  baz(),
  times = 10000
)

# 1) Remove kraken if statement
# 2) convert to vectors one for labels,
# and one for values

# script end;
