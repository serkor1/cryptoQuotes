
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cryptoQuotes: A streamlined access to OHLC-V market data and sentiment indicators in R <a href="https://serkor1.github.io/cryptoQuotes/"><img src="man/figures/logo.png" align="right" height="139" alt="cryptocurrency in R"/></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/cryptoQuotes)](https://www.cran-e.com/package/cryptoQuotes)
[![CRAN RStudio mirror
downloads](https://cranlogs.r-pkg.org/badges/last-month/cryptoQuotes?color=blue)](https://www.cran-e.com/package/cryptoQuotes)
[![R-CMD-check](https://github.com/serkor1/cryptoQuotes/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/serkor1/cryptoQuotes/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/serkor1/cryptoQuotes/branch/main/graph/badge.svg)](https://app.codecov.io/gh/serkor1/cryptoQuotes?branch=main)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

## :information_source: Overview

The `cryptoQuotes`-package is a high-level API-client to get current,
and historical, cryptocurrency OHLC-V market and sentiment data in `R`,
without using web-crawlers or API keys. This `R`-package uses `xts` and
`zoo` under the hood and are compatible with `quantmod` and `TTR` out of
the box.

### Supported exchanges and markets

All supported exchanges and markets are listed in the table below,
alongside the available range of intervals available from the respective
exchanges,

<div align="center">

<table style="width:100%; color: black; margin-left: auto; margin-right: auto;" class="table">
<caption>
Supported exchanges, markets and intervals.
</caption>
<thead>
<tr>
<th style="text-align:left;">
Exchange
</th>
<th style="text-align:center;">
Spot
</th>
<th style="text-align:center;">
Futures
</th>
<th style="text-align:center;">
Available Intervals
</th>
<th style="text-align:center;">
Smallest Interval
</th>
<th style="text-align:center;">
Biggest Interval
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Binance
</td>
<td style="text-align:center;">
✔
</td>
<td style="text-align:center;">
✔
</td>
<td style="text-align:center;">
16
</td>
<td style="text-align:center;">
1 second(s)
</td>
<td style="text-align:center;">
1 month(s)
</td>
</tr>
<tr>
<td style="text-align:left;">
Bitmart
</td>
<td style="text-align:center;">
✔
</td>
<td style="text-align:center;">
✔
</td>
<td style="text-align:center;">
13
</td>
<td style="text-align:center;">
1 minute(s)
</td>
<td style="text-align:center;">
1 week(s)
</td>
</tr>
<tr>
<td style="text-align:left;">
Bybit
</td>
<td style="text-align:center;">
✔
</td>
<td style="text-align:center;">
✔
</td>
<td style="text-align:center;">
13
</td>
<td style="text-align:center;">
1 minute(s)
</td>
<td style="text-align:center;">
1 month(s)
</td>
</tr>
<tr>
<td style="text-align:left;">
Kraken
</td>
<td style="text-align:center;">
✔
</td>
<td style="text-align:center;">
✔
</td>
<td style="text-align:center;">
10
</td>
<td style="text-align:center;">
1 minute(s)
</td>
<td style="text-align:center;">
2 week(s)
</td>
</tr>
<tr>
<td style="text-align:left;">
Kucoin
</td>
<td style="text-align:center;">
✔
</td>
<td style="text-align:center;">
✔
</td>
<td style="text-align:center;">
13
</td>
<td style="text-align:center;">
1 minute(s)
</td>
<td style="text-align:center;">
1 week(s)
</td>
</tr>
</tbody>
</table>

</div>

### :information_source: Basic Usage

#### OHLC-V Market Data

Get USDT denominated Bitcoin spot market price from Binance with
`30m`-intervals using the `get_quote()`-function,

``` r
## BTC OHLC prices
## from Binance spot market
## in 30 minute intervals
BTC <- cryptoQuotes::get_quote(
  ticker = 'BTCUSDT',
  source = 'binance',
  futures = FALSE,
  interval = '30m',
  from    = Sys.Date() - 1 
)
```

<div align="center">

<table style="width:100%; color: black; margin-left: auto; margin-right: auto;" class="table">
<caption>
Bitcoin (BTC) OHLC-prices
</caption>
<thead>
<tr>
<th style="text-align:left;">
Index
</th>
<th style="text-align:center;">
Open
</th>
<th style="text-align:center;">
High
</th>
<th style="text-align:center;">
Low
</th>
<th style="text-align:center;">
Close
</th>
<th style="text-align:left;">
Volume
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
2024-03-05 14:00:00
</td>
<td style="text-align:center;">
67325.03
</td>
<td style="text-align:center;">
68025.94
</td>
<td style="text-align:center;">
67312.38
</td>
<td style="text-align:center;">
67649.82
</td>
<td style="text-align:left;">
2267.51137
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-03-05 14:30:00
</td>
<td style="text-align:center;">
67649.82
</td>
<td style="text-align:center;">
67880.15
</td>
<td style="text-align:center;">
67504.19
</td>
<td style="text-align:center;">
67770.01
</td>
<td style="text-align:left;">
1286.53443
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-03-05 15:00:00
</td>
<td style="text-align:center;">
67770.02
</td>
<td style="text-align:center;">
67796.25
</td>
<td style="text-align:center;">
67244
</td>
<td style="text-align:center;">
67576.02
</td>
<td style="text-align:left;">
1587.12193
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-03-05 15:30:00
</td>
<td style="text-align:center;">
67576.02
</td>
<td style="text-align:center;">
68789
</td>
<td style="text-align:center;">
67274.77
</td>
<td style="text-align:center;">
68710.41
</td>
<td style="text-align:left;">
4070.54196
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-03-05 16:00:00
</td>
<td style="text-align:center;">
68710.41
</td>
<td style="text-align:center;">
69000
</td>
<td style="text-align:center;">
67080.45
</td>
<td style="text-align:center;">
67170.01
</td>
<td style="text-align:left;">
6416.30113
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-03-05 16:30:00
</td>
<td style="text-align:center;">
67170.02
</td>
<td style="text-align:center;">
67389.13
</td>
<td style="text-align:center;">
66370
</td>
<td style="text-align:center;">
67153.84
</td>
<td style="text-align:left;">
2549.25246
</td>
</tr>
</tbody>
</table>

</div>

#### Charting OHLC-V

The `BTC`-object can be charted using the `chart()`-function,

``` r
## Chart BTC
## using klines, SMA, 
## MACD and Bollinger Bands
cryptoQuotes::chart(
  ticker = BTC,
  main   = cryptoQuotes::kline(),
  sub    = list(
    cryptoQuotes::volume(),
    cryptoQuotes::macd()
  ),
  indicator = list(
    cryptoQuotes::sma(n = 7),
    cryptoQuotes::sma(n = 14),
    cryptoQuotes::sma(n = 21),
    cryptoQuotes::bollinger_bands()
  )
)
```

<img src="man/figures/README-chartquote-1.png" alt="cryptocurrency charts in R" style="display: block; margin: auto;" />

## :information_source: Installation

### Stable version

``` r
# install from CRAN
install.packages(
  pkgs = 'cryptoQuotes',
  dependencies = TRUE
)
```

### Development version

``` r
# install from github
devtools::install_github(
  repo = 'https://github.com/serkor1/cryptoQuotes/',
  ref  = 'development'
)
```

## :warning: Disclaimer

This `library` is still considered `experimental` but no breaking
changes will be made on functions labelled as `stable` without
appropriate action; please refer to the [release notes](NEWS.md), or
submit an [issue](https://github.com/serkor1/cryptoQuotes/issues) if
that promise is broken..

## :information_source: Code of Conduct

Please note that the `cryptoQuotes` project is released with a
[Contributor Code of
Conduct](https://serkor1.github.io/cryptoQuotes/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
