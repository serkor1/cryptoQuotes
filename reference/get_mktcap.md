# Get the global market capitalization

The `get_mktcap()`-functions returns the global cryptocurrency market
capitalization.

## Usage

``` r
get_mktcap(
  interval = "1d",
  from = NULL,
  to = NULL,
  altcoin = FALSE,
  reported = FALSE
)
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

- altcoin:

  A [logical](https://rdrr.io/r/base/logical.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1.
  [FALSE](https://rdrr.io/r/base/logical.html) by default. Returns
  altcoin market capitalization if
  [TRUE](https://rdrr.io/r/base/logical.html)

- reported:

  A [logical](https://rdrr.io/r/base/logical.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1.
  [FALSE](https://rdrr.io/r/base/logical.html) by default. Returns
  reported volume if [TRUE](https://rdrr.io/r/base/logical.html).

## Value

An \<\[[xts](https://rdrr.io/pkg/xts/man/xts.html)\]\>-object
containing,

- index:

  \<[POSIXct](https://rdrr.io/r/base/DateTimeClasses.html)\> The
  time-index

- marketcap:

  \<[numeric](https://rdrr.io/r/base/numeric.html)\> Market
  capitalization

- volume:

  \<[numeric](https://rdrr.io/r/base/numeric.html)\> Trading volume

## Details

### On time-zones and dates

Values passed to
``` from`` or  ```to`must be coercible by [as.Date()], or [as.POSIXct()], with a format of either`"%Y-%m-%d"`or`"%Y-%m-%d
%H:%M:%S"\`. By default all dates are passed and returned with
[`Sys.timezone()`](https://rdrr.io/r/base/timezones.html).

### On returns

If only `from` is provided 200 pips are returned up to
[`Sys.time()`](https://rdrr.io/r/base/Sys.time.html). If only `to` is
provided 200 pips up to the specified date is returned.

## See also

Other get-functions:
[`get_fgindex()`](https://serkor1.github.io/cryptoQuotes/reference/get_fgindex.md),
[`get_fundingrate()`](https://serkor1.github.io/cryptoQuotes/reference/get_fundingrate.md),
[`get_lsratio()`](https://serkor1.github.io/cryptoQuotes/reference/get_lsratio.md),
[`get_openinterest()`](https://serkor1.github.io/cryptoQuotes/reference/get_openinterest.md),
[`get_quote()`](https://serkor1.github.io/cryptoQuotes/reference/get_quote.md)

## Author

Serkan Korkmaz

## Examples

``` r
if (FALSE) { # \dontrun{
  # script start;

  # get quote on
  # BTCUSDT pair from
  # Binance in 30m
  # intervals from the
  # last 24 hours
  tail(
    BTC <- cryptoQuotes::get_quote(
      ticker   = 'BTCUSDT',
      source   = 'binance',
      interval = '30m',
      futures  = FALSE,
      from     = Sys.Date() - 1
    )
  )

  # script end;
} # }
```
