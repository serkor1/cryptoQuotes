# Get the Open, High, Low, Close and Volume data on a cryptocurrency pair

**\[stable\]**

Get a quote on a cryptocurrency pair from the
[`available_exchanges()`](https://serkor1.github.io/cryptoQuotes/reference/available_exchanges.md)
in various
[`available_intervals()`](https://serkor1.github.io/cryptoQuotes/reference/available_intervals.md)
for any actively traded
[`available_tickers()`](https://serkor1.github.io/cryptoQuotes/reference/available_tickers.md).

## Usage

``` r
get_quote(
 ticker,
 source   = 'binance',
 futures  = TRUE,
 interval = '1d',
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

- source:

  A [character](https://rdrr.io/r/base/character.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1. `binance` by default.
  See
  [`available_exchanges()`](https://serkor1.github.io/cryptoQuotes/reference/available_exchanges.md)
  for available exchanges.

- futures:

  A [logical](https://rdrr.io/r/base/logical.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1.
  [TRUE](https://rdrr.io/r/base/logical.html) by default. Returns
  futures market if [TRUE](https://rdrr.io/r/base/logical.html), spot
  market otherwise.

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

## Value

An \<\[[xts](https://rdrr.io/pkg/xts/man/xts.html)\]\>-object
containing,

- index:

  \<[POSIXct](https://rdrr.io/r/base/DateTimeClasses.html)\> The
  time-index

- open:

  \<[numeric](https://rdrr.io/r/base/numeric.html)\> Opening price

- high:

  \<[numeric](https://rdrr.io/r/base/numeric.html)\> Highest price

- low:

  \<[numeric](https://rdrr.io/r/base/numeric.html)\> Lowest price

- close:

  \<[numeric](https://rdrr.io/r/base/numeric.html)\> Closing price

- volume:

  \<[numeric](https://rdrr.io/r/base/numeric.html)\> Trading volume

**Sample output**

    #>                        open    high     low   close   volume
    #> 2024-05-12 02:00:00 60809.2 61849.4 60557.3 61455.8 104043.9
    #> 2024-05-13 02:00:00 61455.7 63440.0 60750.0 62912.1 261927.1
    #> 2024-05-14 02:00:00 62912.2 63099.6 60950.0 61550.5 244345.3
    #> 2024-05-15 02:00:00 61550.5 66440.0 61316.1 66175.4 365031.7
    #> 2024-05-16 02:00:00 66175.4 66800.0 64567.0 65217.7 242455.3
    #> 2024-05-17 02:00:00 65217.7 66478.5 65061.2 66218.8  66139.1

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
[`get_openinterest()`](https://serkor1.github.io/cryptoQuotes/reference/get_openinterest.md)

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
