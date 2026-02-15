# Convert dates passed to UNIX

This function converts dates to UNIX time if passed to the API, and
converts it to [POSIXct](https://rdrr.io/r/base/DateTimeClasses.html)
from API

## Usage

``` r
convert_date(x, multiplier)
```

## Arguments

- x:

  a [numeric](https://rdrr.io/r/base/numeric.html) vector, or
  [date](https://rdrr.io/r/base/date.html)-type object

- multiplier:

  [numeric](https://rdrr.io/r/base/numeric.html)

## Value

A vector of same length as x.

## Details

If x is numeric, then the function assumes that its a return value

## See also

Other development tools:
[`GET()`](https://serkor1.github.io/cryptoQuotes/reference/GET.md),
[`chart_layout()`](https://serkor1.github.io/cryptoQuotes/reference/chart_layout.md),
[`default_dates()`](https://serkor1.github.io/cryptoQuotes/reference/default_dates.md),
[`fetch()`](https://serkor1.github.io/cryptoQuotes/reference/fetch.md),
[`flatten()`](https://serkor1.github.io/cryptoQuotes/reference/flatten.md),
[`is.date()`](https://serkor1.github.io/cryptoQuotes/reference/is.date.md)
