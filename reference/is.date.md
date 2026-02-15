# Check if values are valid dates

This function check is equivalent to
[`is.numeric()`](https://rdrr.io/r/base/numeric.html),
[`is.logical()`](https://rdrr.io/r/base/logical.html), and checks for
the date type classes POSIXct, POSIXt and Date. And wether the character
vector can be formatted to dates.

## Usage

``` r
is.date(x)
```

## Arguments

- x:

  object to be tested

## Value

[TRUE](https://rdrr.io/r/base/logical.html) if its either POSIXct,
POSIXt or Date. [FALSE](https://rdrr.io/r/base/logical.html) otherwise.

## See also

Other development tools:
[`GET()`](https://serkor1.github.io/cryptoQuotes/reference/GET.md),
[`chart_layout()`](https://serkor1.github.io/cryptoQuotes/reference/chart_layout.md),
[`convert_date()`](https://serkor1.github.io/cryptoQuotes/reference/convert_date.md),
[`default_dates()`](https://serkor1.github.io/cryptoQuotes/reference/default_dates.md),
[`fetch()`](https://serkor1.github.io/cryptoQuotes/reference/fetch.md),
[`flatten()`](https://serkor1.github.io/cryptoQuotes/reference/flatten.md)
