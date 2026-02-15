# Get the minimum and maximum date range

**\[experimental\]**

All
[`available_exchanges()`](https://serkor1.github.io/cryptoQuotes/reference/available_exchanges.md)
have different limitations on the returned data this function is
adaptive in nature so enforces compliance on the limits

## Usage

``` r
default_dates(interval, from = NULL, to = NULL, length = 200, limit = NULL)
```

## Arguments

- interval:

  A [character](https://rdrr.io/r/base/character.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1. `1d` by default. See
  [`available_intervals()`](https://serkor1.github.io/cryptoQuotes/reference/available_intervals.md)
  for available intervals.

- from:

  An optional [character](https://rdrr.io/r/base/character.html)-,
  [date](https://rdrr.io/r/base/date.html)- or
  [POSIXct](https://rdrr.io/r/base/DateTimeClasses.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1.
  [NULL](https://rdrr.io/r/base/NULL.html) by default.

- to:

  An optional [character](https://rdrr.io/r/base/character.html)-,
  [date](https://rdrr.io/r/base/date.html)- or
  [POSIXct](https://rdrr.io/r/base/DateTimeClasses.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1.
  [NULL](https://rdrr.io/r/base/NULL.html) by default.

- length:

  a [numeric](https://rdrr.io/r/base/numeric.html)-value of
  [length](https://rdrr.io/r/base/length.html) 1. The desired distance
  between `from` and `to`.

## Value

A vector of minimum and maximum dates.

## See also

Other development tools:
[`GET()`](https://serkor1.github.io/cryptoQuotes/reference/GET.md),
[`chart_layout()`](https://serkor1.github.io/cryptoQuotes/reference/chart_layout.md),
[`convert_date()`](https://serkor1.github.io/cryptoQuotes/reference/convert_date.md),
[`fetch()`](https://serkor1.github.io/cryptoQuotes/reference/fetch.md),
[`flatten()`](https://serkor1.github.io/cryptoQuotes/reference/flatten.md),
[`is.date()`](https://serkor1.github.io/cryptoQuotes/reference/is.date.md)

## Author

Serkan Korkmaz
