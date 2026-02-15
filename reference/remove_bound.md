# remove upper and lower bounds from an XTS object

**\[experimental\]**

The [`stats::window()`](https://rdrr.io/r/stats/window.html)-function
has inclusive upper and lower bounds, which in some cases is an
undesirable feature. This high level function removes the bounds if
desired

## Usage

``` r
remove_bound(xts, bounds = c("upper"))
```

## Arguments

- xts:

  A xts-object that needs its bounds modified.

- bounds:

  A character vector of length 1. Has to be one of
  `c('upper','lower','both')`. Defaults to Upper.

## Value

Returns an xts-class object with its bounds removed.

## See also

Other utility:
[`calibrate_window()`](https://serkor1.github.io/cryptoQuotes/reference/calibrate_window.md),
[`split_window()`](https://serkor1.github.io/cryptoQuotes/reference/split_window.md),
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
