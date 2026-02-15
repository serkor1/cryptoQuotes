# Chart the long-short ratio

**\[experimental\]**

A high-level
[`plotly::plot_ly()`](https://rdrr.io/pkg/plotly/man/plot_ly.html)-wrapper
function. The function adds a subchart to the
[chart](https://serkor1.github.io/cryptoQuotes/reference/chart.md) with
`long-short ratio`.

## Usage

``` r
lsr(ratio, ...)
```

## Arguments

- ratio:

  A [`xts::xts()`](https://rdrr.io/pkg/xts/man/xts.html)-object. See
  [`get_lsratio()`](https://serkor1.github.io/cryptoQuotes/reference/get_lsratio.md)
  for more details.

- ...:

  For internal use. Please ignore.

## Value

An [invisible](https://rdrr.io/r/base/invisible.html)
[`plotly::plot_ly()`](https://rdrr.io/pkg/plotly/man/plot_ly.html)-object.

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
[`fgi()`](https://serkor1.github.io/cryptoQuotes/reference/fgi.md),
[`hma()`](https://serkor1.github.io/cryptoQuotes/reference/hma.md),
[`macd()`](https://serkor1.github.io/cryptoQuotes/reference/macd.md),
[`rsi()`](https://serkor1.github.io/cryptoQuotes/reference/rsi.md),
[`sma()`](https://serkor1.github.io/cryptoQuotes/reference/sma.md),
[`smi()`](https://serkor1.github.io/cryptoQuotes/reference/smi.md),
[`volume()`](https://serkor1.github.io/cryptoQuotes/reference/volume.md),
[`vwap()`](https://serkor1.github.io/cryptoQuotes/reference/vwap.md),
[`wma()`](https://serkor1.github.io/cryptoQuotes/reference/wma.md),
[`zlema()`](https://serkor1.github.io/cryptoQuotes/reference/zlema.md)

Other sentiment indicators:
[`fgi()`](https://serkor1.github.io/cryptoQuotes/reference/fgi.md)

Other subchart indicators:
[`add_event()`](https://serkor1.github.io/cryptoQuotes/reference/add_event.md),
[`fgi()`](https://serkor1.github.io/cryptoQuotes/reference/fgi.md),
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

  # 1) long-short ratio
  # on BTCUSDT pair
  LS_BTC <- cryptoQuotes::get_lsratio(
    ticker   = 'BTCUSDT',
    interval = '15m',
    from     = Sys.Date() - 1,
    to       = Sys.Date()
  )

  # 2) BTCSDT in same period
  # as the long-short ratio;
  BTC <- cryptoQuotes::get_quote(
    ticker   = 'BTCUSDT',
    futures  = TRUE,
    interval = '15m',
    from     = Sys.Date() - 1,
    to       = Sys.Date()
  )

  # 3) plot BTCUSDT-pair
  # with long-short ratio
  cryptoQuotes::chart(
    ticker = BTC,
    main   = cryptoQuotes::kline(),
    sub    = list(
      cryptoQuotes::lsr(
        ratio = LS_BTC
      )
    )
  )

  # end of scrtipt;
} # }
```
