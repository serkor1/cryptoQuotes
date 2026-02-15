# Converting XTS and ZOO objects

``` r
## load library
library(cryptoQuotes)
```

If you want to use the simplicity of
[{tidyverse}](https://github.com/tidyverse/tidyverse) or the power of
[{data.table}](https://github.com/Rdatatable/data.table), the
[{xts}](https://github.com/joshuaulrich/xts)-object can be easily
converted.

However, its important to maintain data integrity, especially, if the
date and time zone is important for you.

## Converting xts and zoo to tibble

Converting to `tibble` requires a few steps to achieve the same data
structure as the `xts`,

``` r
# 1) load pipe
library(magrittr)

# 2) convert to tibble
# using as_tibble
tbl <- tibble::as_tibble(
  x = cbind(
    index = zoo::index(ATOM),
    zoo::coredata(ATOM)
  )
) %>% dplyr::mutate(
  index = lubridate::as_datetime(
    x  = index,
    tz = "Europe/Copenhagen"
  )
)

# 3) tail data
head(tbl, 3)
#> # A tibble: 3 × 6
#>   index                open  high   low close volume
#>   <dttm>              <dbl> <dbl> <dbl> <dbl>  <dbl>
#> 1 2023-12-30 00:00:00  10.9  10.9  10.9  10.9  3260.
#> 2 2023-12-30 00:15:00  10.9  11.0  10.9  11.0  1863.
#> 3 2023-12-30 00:30:00  11.0  11.0  10.9  11.0  1861.
```

## Converting xts and zoo to data.table

Converting to a `data.table` is straightforward as `as.data.table()`
handles everything under the hood,

``` r
# 1) convert to data.table
# using as.data.table
DT <- data.table::as.data.table(
  ATOM
) 

# 2) head data
head(DT, 3)
#>                  index    open    high     low   close   volume
#>                 <POSc>   <num>   <num>   <num>   <num>    <num>
#> 1: 2023-12-30 00:00:00 10.8778 10.9133 10.8775 10.9089 3259.760
#> 2: 2023-12-30 00:15:00 10.9089 10.9530 10.9008 10.9512 1862.697
#> 3: 2023-12-30 00:30:00 10.9512 10.9884 10.9373 10.9832 1861.493
```

## Checking data integrity

### Checking date integrity

It is important that the date.time has not been converted to a different
timezone in the process, without explicitly coding it as such,

``` r
# 1) store date.time objects
time_objects <- list(
  tbl = tbl$index,
  DT  = DT$index
)

# 2) check if they are all equal
all(
  vapply(
    X   = time_objects,
    FUN = function(x) {
      
      setequal(
        x = x,
        y = zoo::index(ATOM)
        )
      
    },
    FUN.VALUE = logical(1)
  )
)
#> [1] TRUE
```

### Checking OHLCV values

It goes without saying that `R`-functions wouldn’t tamper with the order
of the data during conversion without a warning in the documentation,
but nonetheless for the sake of argument, we will check the OHLCV
values,

``` r
# 1) store price objects
# Open price here
open_price <- list(
  tbl = tbl$open,
  DT  = DT$open
)

# 2) check if they are all equal
all(
  vapply(
    X   = open_price,
    FUN = function(x) {
      
      setequal(
        x = x,
        y = ATOM$open
        )
      
    },
    FUN.VALUE = logical(1)
  )
)
#> [1] TRUE
```

## Why even convert?

Even though numerical operations on
[{xts}](https://github.com/joshuaulrich/xts)-objects are lightning fast,
it comes with a cost; it doesn’t support `factors` or `characters`.

Converting the [{xts}](https://github.com/joshuaulrich/xts)-object is a
simple and trivial process, and simplifies grouped operations in a
verbose manner.
