# Get the funding rate on futures contracts

**\[stable\]**

Get the funding rate on a cryptocurrency pair from the
[`available_exchanges()`](https://serkor1.github.io/cryptoQuotes/reference/available_exchanges.md)
in any actively traded
[`available_tickers()`](https://serkor1.github.io/cryptoQuotes/reference/available_tickers.md)
on the futures markets.

## Usage

``` r
get_fundingrate(
 ticker,
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

- funding_rate:

  \<[numeric](https://rdrr.io/r/base/numeric.html)\> the current funding
  rate

**Sample output**

    #>                     funding_rate
    #> 2024-03-09 17:00:00   0.00026407
    #> 2024-03-10 01:00:00   0.00031010
    #> 2024-03-10 09:00:00   0.00063451
    #> 2024-03-10 17:00:00   0.00054479
    #> 2024-03-11 01:00:00   0.00035489
    #> 2024-03-11 09:00:00   0.00078428

## See also

Other get-functions:
[`get_fgindex()`](https://serkor1.github.io/cryptoQuotes/reference/get_fgindex.md),
[`get_lsratio()`](https://serkor1.github.io/cryptoQuotes/reference/get_lsratio.md),
[`get_mktcap()`](https://serkor1.github.io/cryptoQuotes/reference/get_mktcap.md),
[`get_openinterest()`](https://serkor1.github.io/cryptoQuotes/reference/get_openinterest.md),
[`get_quote()`](https://serkor1.github.io/cryptoQuotes/reference/get_quote.md)

## Author

Serkan Korkmaz

## Examples

``` r
if (FALSE) { # \dontrun{
# script start;

# 1) check available
# exchanges for funding rates
cryptoQuotes::available_exchanges(
  type = "fundingrate"
  )

# 2) get BTC funding rate
# for the last 7 days
tail(
  BTC <- cryptoQuotes::get_fundingrate(
    ticker = "BTCUSDT",
    source = "binance",
    from   = Sys.Date() - 7
  )
)

# script end;
} # }
```
