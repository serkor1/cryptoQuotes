# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup;
rm(list = ls()); gc(); devtools::load_all()


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
