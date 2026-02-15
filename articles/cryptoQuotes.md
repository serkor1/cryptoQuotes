# Introduction: Cryptocurrency Market Data in R

``` r
library(cryptoQuotes)
```

This `vignette` is a short introduction to
[{cryptoQuotes}](https://serkor1.github.io/cryptoQuotes/), for a more
extensive introduction on its usecase and limitations please refer to
the [wiki](https://github.com/serkor1/cryptoQuotes/wiki).

> **NOTE:** This `vignette` is limited by geolocation due to various
> country specific cryptocurrency laws. The introduction, therefore, is
> limited to what is available in the US.

Throughout this `vignette` we will explore the Bitcoin market data using
the `Kraken` exchange. All available `tickers` and its notation various
across exchangs, so if you are unfamiliar with the exchange specific
notation please use the
[`available_intervals()`](https://serkor1.github.io/cryptoQuotes/reference/available_intervals.md)-functions,

``` r
# show a sample of 
# the available tickers
sample(
  x = available_tickers(
    source  = "kraken",
    futures = FALSE
  ),
  size = 5
)
#> [1] "TOKENEUR" "XRPUSDC"  "EURRUSDT" "ALCXUSD"  "FILEUR"
```

These available tickers can be passed into the `ticker`-argument of all
the `get_*`-functions with the appropriate `source` and
`futures`-argument which, in this case, is `kraken` and `FALSE`.

## Cryptocurrency market data in R

### Open, High, Low, Close an Volume

We will extract the Bitcoin market data in `hourly` intervals, and store
it as `BTC`,

``` r
## extract Bitcoin
## market on the hourly 
## chart
BTC <- get_quote(
  ticker   = "XBTUSDT",
  source   = "kraken",
  futures  = FALSE, 
  interval = "1h"
)
```

    #>                        open    high     low   close    volume
    #> 2026-02-15 06:00:00 70232.8 70517.1 70206.5 70397.6 0.3613031
    #> 2026-02-15 07:00:00 70346.6 70919.9 70308.4 70806.2 8.0890162
    #> 2026-02-15 08:00:00 70829.7 70956.4 70194.0 70415.3 2.1113017
    #> 2026-02-15 09:00:00 70403.1 70636.2 70367.3 70420.0 1.5070650
    #> 2026-02-15 10:00:00 70422.4 70491.0 70229.4 70437.9 0.6541102
    #> 2026-02-15 11:00:00 70428.2 70499.8 70389.2 70390.2 0.1601837

The market data can be extracted in different intervals using the
`interval`-argument. To see available intervals, the
[`available_intervals()`](https://serkor1.github.io/cryptoQuotes/reference/available_intervals.md)-function
can be used,

``` r
## get available
## intervals for OHLC
## on Kraken
available_intervals(
  source  = "kraken",
  type    = "ohlc",
  futures = FALSE
)
#> ℹ Available Intervals at "kraken" (spot):
#> ✔ 1m, 5m, 15m, 30m, 1h, 4h, 1d, 1w, 2w
```

### Sentiment Data

To put the Bitcoin price action in perspective, an interesting sentiment
indicator like the `long` to `short` ratio can be extracted,

``` r
## extract long-short
## ratio on Bitcoin
## using the hourly chart
LS_BTC <- try(
   get_lsratio(
    ticker   = "XBTUSDT",
    source   = "kraken",
    interval = "1h"
  )
)
#> Error in base::tryCatch(base::withCallingHandlers({ : 
#>   ✖ Couldn't find "XBTUSDT" on "kraken".
#> ✔ Run available_tickers(source = 'kraken', futures = TRUE) to see available
#>   tickers.
#> ℹ If the error persists please submit a bug report.
```

This gives an `error`. The source of the error is the ticker-naming
convention; as the *long-short ratio* is specific to the perpetual
futures market, and the current ticker is specific to the spot-market,
the endpoint throws an error.

To circumvent this, we can either use perpetual futures throughout the
`script`, or modify the `ticker`-argument as follows,

``` r
## extract long-short
## ratio on Bitcoin
## using the hourly chart
LS_BTC <- get_lsratio(
  ticker   = "PF_XBTUSD",
  source   = "kraken",
  interval = "1h"
)
```

    #>                       long  short ls_ratio
    #> 2026-02-15 06:00:00 0.6308 0.3692 1.708559
    #> 2026-02-15 07:00:00 0.6384 0.3616 1.765487
    #> 2026-02-15 08:00:00 0.6398 0.3602 1.776235
    #> 2026-02-15 09:00:00 0.6387 0.3613 1.767783
    #> 2026-02-15 10:00:00 0.6365 0.3635 1.751032
    #> 2026-02-15 11:00:00 0.6354 0.3646 1.742732

The `ticker` specific to the perpetual futures market can be extracted
using the `available_tickers` with `futures = TRUE` as follows,

``` r
# show a sample of 
# the available tickers
sample(
  x = available_tickers(
    source  = "kraken",
    futures = TRUE
  ),
  size = 5
)
#> [1] "PF_ARUSD"         "PF_MTLUSD"        "PF_MORPHOUSD"     "FF_SOLUSD_260227"
#> [5] "PF_SEIUSD"
```

## Charting cryptocurrency market data

The Bitcoin market data can be charted using the
[`chart()`](https://serkor1.github.io/cryptoQuotes/reference/chart.md)-function,
which uses [{plotly}](https://github.com/plotly/plotly.R) as backend,

``` r
# candlestick chart with
# volume and Long to Short Ratio
chart(
  ticker = BTC,
  main   = kline(),
  sub    = list(
    volume(),
    lsr(ratio = LS_BTC)
  ),
  options = list(
    dark = FALSE
  )
)
```

### Adding indicators

[{cryptoQuotes}](https://serkor1.github.io/cryptoQuotes/) also acts as
an API-client to [{TTR}](https://github.com/joshuaulrich/TTR), and
supports most of its functions. We can add Moving Average indicators,
and Bollinger Bands to the chart using the `indicator`-argument,

``` r
# candlestick chart with
# volume and Long to Short Ratio
chart(
  ticker = BTC,
  main   = kline(),
  sub    = list(
    volume(),
    lsr(ratio = LS_BTC)
  ),
  indicator = list(
    sma(n = 7),
    sma(n = 14),
    sma(n = 21),
    bollinger_bands(
      color = "steelblue"
    )
  ),
  options = list(
    dark = FALSE
  )
)
```
