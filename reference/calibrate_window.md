# calibrate the time window of a list of xts objects

**\[experimental\]**

This function is a high-level wrapper of
[do.call](https://rdrr.io/r/base/do.call.html) and
[lapply](https://rdrr.io/r/base/lapply.html) which modifies each xts
object stored in a [`list()`](https://rdrr.io/r/base/list.html).

## Usage

``` r
calibrate_window(list, FUN, ...)
```

## Arguments

- list:

  A list of xts objects.

- FUN:

  A function applied to each element of the list

- ...:

  optional arguments passed to `FUN`.

## Value

Returns a xts object.

## See also

Other utility:
[`remove_bound()`](https://serkor1.github.io/cryptoQuotes/reference/remove_bound.md),
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
