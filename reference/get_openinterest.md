# Get the open interest on perpetual futures contracts

**\[stable\]**

Get the open interest on a cryptocurrency pair from the
[`available_exchanges()`](https://serkor1.github.io/cryptoQuotes/reference/available_exchanges.md)
in any actively traded
[`available_tickers()`](https://serkor1.github.io/cryptoQuotes/reference/available_tickers.md)
on the FUTURES markets.

## Usage

``` r
get_openinterest(
 ticker,
 interval = '1d',
 source   = 'binance',
 from     = NULL,
 to       = NULL
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

## Value

An \<\[[xts](https://rdrr.io/pkg/xts/man/xts.html)\]\>-object
containing,

- index:

  \<[POSIXct](https://rdrr.io/r/base/DateTimeClasses.html)\> the
  time-index

- open_interest:

  \<[numeric](https://rdrr.io/r/base/numeric.html)\> open perpetual
  contracts on both both sides

**Sample output**

    #>                     open_interest
    #> 2024-05-12 02:00:00      70961.07
    #> 2024-05-13 02:00:00      69740.49
    #> 2024-05-14 02:00:00      71110.33
    #> 2024-05-15 02:00:00      67758.06
    #> 2024-05-16 02:00:00      73614.70
    #> 2024-05-17 02:00:00      72377.85

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
[`get_mktcap()`](https://serkor1.github.io/cryptoQuotes/reference/get_mktcap.md),
[`get_quote()`](https://serkor1.github.io/cryptoQuotes/reference/get_quote.md)

## Author

Serkan Korkmaz

## Examples

``` r
if (FALSE) { # \dontrun{
  # script start;

  # 1) check available
  # exchanges for open interest
  cryptoQuotes::available_exchanges(
    type = 'interest'
    )

  # 2) get BTC funding rate
  # for the last 7 days
  tail(
    BTC <- cryptoQuotes::get_openinterest(
      ticker = "BTCUSDT",
      source = "binance",
      from   = Sys.Date() - 7
    )
  )

  # script end;
} # }
```
