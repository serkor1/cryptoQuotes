# Get available intervals

**\[stable\]**

Get available intervals for the
[`available_tickers()`](https://serkor1.github.io/cryptoQuotes/reference/available_tickers.md)
on the
[`available_exchanges()`](https://serkor1.github.io/cryptoQuotes/reference/available_exchanges.md).

## Usage

``` r
available_intervals(
   source = "binance",
   type   = "ohlc",
   futures = TRUE
)
```

## Arguments

- source:

  A [character](https://rdrr.io/r/base/character.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1. `binance` by default.
  See
  [`available_exchanges()`](https://serkor1.github.io/cryptoQuotes/reference/available_exchanges.md)
  for available exchanges.

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

- futures:

  A [logical](https://rdrr.io/r/base/logical.html)-vector of
  [length](https://rdrr.io/r/base/length.html) 1.
  [TRUE](https://rdrr.io/r/base/logical.html) by default. Returns
  futures market if [TRUE](https://rdrr.io/r/base/logical.html), spot
  market otherwise.

## Value

An [`invisible()`](https://rdrr.io/r/base/invisible.html)
[character](https://rdrr.io/r/base/character.html)-vector containing the
available intervals on the exchange, market and endpoint.

**Sample output**

    #> i Available Intervals at "bybit" (futures):
    #> v 1m, 3m, 5m, 15m, 30m, 1h, 2h, 4h, 6h, 12h, 1d, 1M, 1w
    #> [1] "1m"  "3m"  "5m"  "15m" "30m" "1h"

## Details

The endpoints supported by the
[`available_exchanges()`](https://serkor1.github.io/cryptoQuotes/reference/available_exchanges.md)
are not uniform, so exchanges available for, say,
[`get_lsratio()`](https://serkor1.github.io/cryptoQuotes/reference/get_lsratio.md)
is not necessarily the same as those available for
[`get_quote()`](https://serkor1.github.io/cryptoQuotes/reference/get_quote.md)

## See also

Other supported calls:
[`available_exchanges()`](https://serkor1.github.io/cryptoQuotes/reference/available_exchanges.md),
[`available_tickers()`](https://serkor1.github.io/cryptoQuotes/reference/available_tickers.md)

## Author

Serkan Korkmaz

## Examples

``` r
if (FALSE) { # \dontrun{
  # script start;

  # available intervals
  # at kucoin futures market
  cryptoQuotes::available_intervals(
    source  = 'kucoin',
    futures = TRUE,
    type    = "ohlc"
  )

  # available intervals
  # at kraken spot market
  cryptoQuotes::available_intervals(
    source  = 'kraken',
    futures = FALSE,
    type    = "ohlc"
  )

  # script end;
} # }
```
