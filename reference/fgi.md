# Chart the Fear and Greed Index

**\[experimental\]**

A high-level
[`plotly::plot_ly()`](https://rdrr.io/pkg/plotly/man/plot_ly.html)-wrapper
function. The function adds a subchart with the `fear and greed`-index.

## Usage

``` r
fgi(index, ...)
```

## Arguments

- index:

  A [`xts::xts()`](https://rdrr.io/pkg/xts/man/xts.html)-object. See
  [`get_fgindex()`](https://serkor1.github.io/cryptoQuotes/reference/get_fgindex.md)
  for more details.

- ...:

  For internal use. Please ignore.

## Value

An [invisible](https://rdrr.io/r/base/invisible.html)
[`plotly::plot_ly()`](https://rdrr.io/pkg/plotly/man/plot_ly.html)-object.

## Details

### Classification

The Fear and Greed Index goes from 0-100, and can be classified as
follows,

- 0-24, Extreme Fear

- 25-44, Fear

- 45-55, Neutral

- 56-75, Greed

- 76-100, Extreme Greed

### About the Fear and Greed Index

The fear and greed index is a market sentiment indicator that measures
investor emotions to gauge whether they are generally fearful
(indicating potential selling pressure) or greedy (indicating potential
buying enthusiasm).

### Source

This index is fetched from
[alternative.me](https://alternative.me/crypto/fear-and-greed-index/),
and can be different from the one provided by
[coinmarketcap](https://coinmarketcap.com/charts/#fear-and-greed-index).

## See also

Other chart indicators:
[`add_event()`](https://serkor1.github.io/cryptoQuotes/reference/add_event.md),
[`alma()`](https://serkor1.github.io/cryptoQuotes/reference/alma.md),
[`bollinger_bands()`](https://serkor1.github.io/cryptoQuotes/reference/bollinger_bands.md),
[`chart()`](https://serkor1.github.io/cryptoQuotes/reference/chart.md),
[`dema()`](https://serkor1.github.io/cryptoQuotes/reference/dema.md),
[`donchian_channel()`](https://serkor1.github.io/cryptoQuotes/reference/donchian_channel.md),
[`ema()`](https://serkor1.github.io/cryptoQuotes/reference/ema.md),
[`evwma()`](https://serkor1.github.io/cryptoQuotes/reference/evwma.md),
[`hma()`](https://serkor1.github.io/cryptoQuotes/reference/hma.md),
[`lsr()`](https://serkor1.github.io/cryptoQuotes/reference/lsr.md),
[`macd()`](https://serkor1.github.io/cryptoQuotes/reference/macd.md),
[`rsi()`](https://serkor1.github.io/cryptoQuotes/reference/rsi.md),
[`sma()`](https://serkor1.github.io/cryptoQuotes/reference/sma.md),
[`smi()`](https://serkor1.github.io/cryptoQuotes/reference/smi.md),
[`volume()`](https://serkor1.github.io/cryptoQuotes/reference/volume.md),
[`vwap()`](https://serkor1.github.io/cryptoQuotes/reference/vwap.md),
[`wma()`](https://serkor1.github.io/cryptoQuotes/reference/wma.md),
[`zlema()`](https://serkor1.github.io/cryptoQuotes/reference/zlema.md)

Other sentiment indicators:
[`lsr()`](https://serkor1.github.io/cryptoQuotes/reference/lsr.md)

Other subchart indicators:
[`add_event()`](https://serkor1.github.io/cryptoQuotes/reference/add_event.md),
[`lsr()`](https://serkor1.github.io/cryptoQuotes/reference/lsr.md),
[`macd()`](https://serkor1.github.io/cryptoQuotes/reference/macd.md),
[`rsi()`](https://serkor1.github.io/cryptoQuotes/reference/rsi.md),
[`smi()`](https://serkor1.github.io/cryptoQuotes/reference/smi.md),
[`volume()`](https://serkor1.github.io/cryptoQuotes/reference/volume.md)

## Author

Serkan Korkmaz

## Examples

``` r
if (FALSE) { # \dontrun{
  # script start;

  # 1) get the fear and greed index
  # for the last 14 days
  FGIndex <- cryptoQuotes::get_fgindex(
    from = Sys.Date() - 14
  )

  # 2) get the BTC price
  # for the last 14 days
  BTC <- cryptoQuotes::get_quote(
    ticker  = "BTCUSDT",
    source  = "bybit",
    futures = FALSE,
    from    = Sys.Date() - 14
  )

  # 3) chart the daily BTC
  # along side the Fear and
  # Greed Index
  cryptoQuotes::chart(
    ticker = BTC,
    main   = kline(),
    sub    = list(
      fgi(
        FGIndex
      )
    )
  )

  # script end;
} # }
```
