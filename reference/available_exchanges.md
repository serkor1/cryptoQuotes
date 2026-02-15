# Get available exchanges

**\[stable\]**

Get a [vector](https://rdrr.io/r/base/vector.html) of all available
exchanges passed into the `source` argument of the get-functions.

## Usage

``` r
available_exchanges(
   type = "ohlc"
)
```

## Arguments

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

## Value

An [`invisible()`](https://rdrr.io/r/base/invisible.html)
[character](https://rdrr.io/r/base/character.html)-vector containing
available exchanges

## Details

The endpoints supported by the `available_exchanges()` are not uniform,
so exchanges available for, say,
[`get_lsratio()`](https://serkor1.github.io/cryptoQuotes/reference/get_lsratio.md)
is not necessarily the same as those available for
[`get_quote()`](https://serkor1.github.io/cryptoQuotes/reference/get_quote.md)

## See also

Other supported calls:
[`available_intervals()`](https://serkor1.github.io/cryptoQuotes/reference/available_intervals.md),
[`available_tickers()`](https://serkor1.github.io/cryptoQuotes/reference/available_tickers.md)

## Author

Serkan Korkmaz

## Examples

``` r
# script start;

# 1) available exchanges
# on ohlc-v endpoint
cryptoQuotes::available_exchanges(
  type = "ohlc"
)
#> ℹ Available Exchanges:
#> ✔ binance, bitmart, bybit, cmc, crypto.com, huobi, kraken, kucoin, mexc

# 2) available exchanges
# on long-short ratios
cryptoQuotes::available_exchanges(
  type = "lsratio"
)
#> ℹ Available Exchanges:
#> ✔ binance, bybit, kraken

# script end;
```
