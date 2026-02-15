# Get actively traded cryptocurrency pairs

**\[stable\]**

Get actively traded cryptocurrency pairs on the
[`available_exchanges()`](https://serkor1.github.io/cryptoQuotes/reference/available_exchanges.md).

## Usage

``` r
available_tickers(source = "binance", futures = TRUE)
```

## Arguments

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

## Value

A [character](https://rdrr.io/r/base/character.html)-vector of actively
traded cryptocurrency pairs on the exchange, and the specified market.

**Sample output**

    #> [1] "0GUSDT"              "1000000BABYDOGEUSDT" "1000000CHEEMSUSDT"
    #> [4] "1000000MOGUSDT"      "10000QUBICUSDT"      "10000SATSUSDT"

## Details

The naming-conventions across, and within,
[`available_exchanges()`](https://serkor1.github.io/cryptoQuotes/reference/available_exchanges.md)
are not necessarily the same. This function lists all actively traded
tickers.

## See also

Other supported calls:
[`available_exchanges()`](https://serkor1.github.io/cryptoQuotes/reference/available_exchanges.md),
[`available_intervals()`](https://serkor1.github.io/cryptoQuotes/reference/available_intervals.md)

## Author

Serkan Korkmaz

## Examples

``` r
if (FALSE) { # \dontrun{
  # 1) available tickers
  # in Binance spot market
  head(
    cryptoQuotes::available_tickers(
      source  = 'binance',
      futures = FALSE
    )
  )

  # 2) available tickers
  # on Kraken futures market
  head(
    cryptoQuotes::available_tickers(
      source  = 'kraken',
      futures = TRUE
    )
  )
} # }


```
