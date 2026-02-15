# Get the long to short ratio of a cryptocurrency pair

**\[stable\]**

Get the long-short ratio for any
[`available_tickers()`](https://serkor1.github.io/cryptoQuotes/reference/available_tickers.md)
from the
[`available_exchanges()`](https://serkor1.github.io/cryptoQuotes/reference/available_exchanges.md)

## Usage

``` r
get_lsratio(
   ticker,
   interval = '1d',
   source   = 'binance',
   from     = NULL,
   to       = NULL,
   top      = FALSE
)
```

## Arguments

- ticker:

  A [character](https://rdrr.io/r/base/character.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1. See
  [`available_tickers()`](https://serkor1.github.io/cryptoQuotes/reference/available_tickers.md)
  for available tickers.

- interval:

  A [character](https://rdrr.io/r/base/character.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1. `1d` by default. See
  [`available_intervals()`](https://serkor1.github.io/cryptoQuotes/reference/available_intervals.md)
  for available intervals.

- source:

  A [character](https://rdrr.io/r/base/character.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1. `binance` by default.
  See
  [`available_exchanges()`](https://serkor1.github.io/cryptoQuotes/reference/available_exchanges.md)
  for available exchanges.

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

- top:

  A [logical](https://rdrr.io/r/base/logical.html) vector.
  [FALSE](https://rdrr.io/r/base/logical.html) by default. If
  [TRUE](https://rdrr.io/r/base/logical.html) it returns the top traders
  Long-Short ratios.

## Value

An [xts::xts](https://rdrr.io/pkg/xts/man/xts.html)-object containing,

- index:

  \<[POSIXct](https://rdrr.io/r/base/DateTimeClasses.html)\> the
  time-index

- long:

  \<[numeric](https://rdrr.io/r/base/numeric.html)\> the share of longs

- short:

  \<[numeric](https://rdrr.io/r/base/numeric.html)\> the share of shorts

- ls_ratio:

  \<[numeric](https://rdrr.io/r/base/numeric.html)\> the ratio of longs
  to shorts

**Sample output**

    #>                       long  short  ls_ratio
    #> 2024-05-12 02:00:00 0.6930 0.3070 2.2573290
    #> 2024-05-13 02:00:00 0.6637 0.3363 1.9735355
    #> 2024-05-14 02:00:00 0.5555 0.4445 1.2497188
    #> 2024-05-15 02:00:00 0.6580 0.3420 1.9239766
    #> 2024-05-16 02:00:00 0.4868 0.5132 0.9485581
    #> 2024-05-17 02:00:00 0.5102 0.4898 1.0416497

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
[`get_mktcap()`](https://serkor1.github.io/cryptoQuotes/reference/get_mktcap.md),
[`get_openinterest()`](https://serkor1.github.io/cryptoQuotes/reference/get_openinterest.md),
[`get_quote()`](https://serkor1.github.io/cryptoQuotes/reference/get_quote.md)

## Author

Jonas Cuzulan Hirani

## Examples

``` r
if (FALSE) { # \dontrun{
  # script start;

  LS_BTC <- cryptoQuotes::get_lsratio(
    ticker   = 'BTCUSDT',
    interval = '15m',
    from     = Sys.Date() - 1,
    to       = Sys.Date()
  )

  # end of scrtipt;
} # }
```
