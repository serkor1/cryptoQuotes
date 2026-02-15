# Fetch time-based API-endpoint responses

**\[experimental\]**

This function is a high-level wrapper around the development tools
available and should reduce the amount of coding.

## Usage

``` r
fetch(ticker, source, futures, interval, type, to, from, ...)
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

- type:

  [character](https://rdrr.io/r/base/character.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1. One of,

  - `"ohlc"` - Available exchanges for Open, High, Low, Close and Volume
    market data. See the
    [`get_quote()`](https://serkor1.github.io/cryptoQuotes/reference/get_quote.md)-function.

  - `"lsratio"` - Available exchanges for Long-Short ratios. See the
    [`get_lsratio()`](https://serkor1.github.io/cryptoQuotes/reference/get_lsratio.md)-function.

  - `"fundingrate"` - Available exchanges for Funding rates. See the
    [`get_fundingrate()`](https://serkor1.github.io/cryptoQuotes/reference/get_fundingrate.md)-function.

  - `"interest"` - Available exchanges for Open interest on perpetual
    contracts on both sides. See the
    [`get_openinterest()`](https://serkor1.github.io/cryptoQuotes/reference/get_openinterest.md)-function.

- to:

  An optional [character](https://rdrr.io/r/base/character.html)-,
  [date](https://rdrr.io/r/base/date.html)- or
  [POSIXct](https://rdrr.io/r/base/DateTimeClasses.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1.
  [NULL](https://rdrr.io/r/base/NULL.html) by default.

- from:

  An optional [character](https://rdrr.io/r/base/character.html)-,
  [date](https://rdrr.io/r/base/date.html)- or
  [POSIXct](https://rdrr.io/r/base/DateTimeClasses.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1.
  [NULL](https://rdrr.io/r/base/NULL.html) by default.

- ...:

  additional parameters passed down the endpoint

## Value

It returns an [xts::xts](https://rdrr.io/pkg/xts/man/xts.html)-object
from the desired endpoint.

## Details

This function can only be used to fetch time-based objects, and can
therefore not be used to get, for example,
[`available_tickers()`](https://serkor1.github.io/cryptoQuotes/reference/available_tickers.md).

## See also

Other development tools:
[`GET()`](https://serkor1.github.io/cryptoQuotes/reference/GET.md),
[`chart_layout()`](https://serkor1.github.io/cryptoQuotes/reference/chart_layout.md),
[`convert_date()`](https://serkor1.github.io/cryptoQuotes/reference/convert_date.md),
[`default_dates()`](https://serkor1.github.io/cryptoQuotes/reference/default_dates.md),
[`flatten()`](https://serkor1.github.io/cryptoQuotes/reference/flatten.md),
[`is.date()`](https://serkor1.github.io/cryptoQuotes/reference/is.date.md)

## Author

Serkan Korkmaz
