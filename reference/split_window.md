# split xts object iteratively in lists of desired intervals

**\[experimental\]**

The `split_window()`-function is a high level wrapper of the
[`stats::window()`](https://rdrr.io/r/stats/window.html)-function which
restricts the intervals between the first and second index value
iteratively

## Usage

``` r
split_window(xts, by, bounds = "upper")
```

## Arguments

- xts:

  A xts-object that needs needs to be split.

- by:

  A reference
  [`zoo::index()`](https://rdrr.io/pkg/zoo/man/index.html)-object, to be
  split by.

- bounds:

  A character vector of length 1. Has to be one of
  `c('upper','lower','both')`. Defaults to Upper.

## Value

Returns a list of iteratively restricted xts objects

## See also

Other utility:
[`calibrate_window()`](https://serkor1.github.io/cryptoQuotes/reference/calibrate_window.md),
[`remove_bound()`](https://serkor1.github.io/cryptoQuotes/reference/remove_bound.md),
[`write_xts()`](https://serkor1.github.io/cryptoQuotes/reference/write_xts.md)

## Examples

``` r
# script start;

# 1) check index of BTCUSDT and
# the Fear and Greed Index
setequal(
  zoo::index(BTC),
  zoo::index(FGIndex)
)
#> [1] FALSE

# 2) to align the indices,
# we use the convincience functions
# by splitting the FGI by the BTC index.
FGIndex <- cryptoQuotes::split_window(
  xts = cryptoQuotes::FGIndex,
  by = zoo::index(BTC),

  # Remove upper bounds of the
  # index to avoid overlap between
  # the dates.
  #
  # This ensures that the FGI is split
  # according to start of each weekly
  # BTC candle
  bounds = 'upper'
)

# 3) as splitWindow returns a list
# it needs to passed into calibrateWindow
# to ensure comparability
FGIndex <- cryptoQuotes::calibrate_window(
  list = FGIndex,

  # As each element in the list can include
  # more than one row, each element needs to be aggregated
  # or summarised.
  #
  # using xts::first gives the first element
  # of each list, along with its values
  FUN = xts::first
)


# 3) check if candles aligns
# accordingly
stopifnot(
  setequal(
    zoo::index(BTC),
    zoo::index(FGIndex)
  )
)

# script end;
```
