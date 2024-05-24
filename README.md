
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cryptoQuotes: Open access to cryptocurrency market data <a href="https://serkor1.github.io/cryptoQuotes/"><img src="man/figures/logo.png" align="right" height="139" alt="cryptocurrency in R"/></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/cryptoQuotes)](https://CRAN.R-project.org/package=cryptoQuotes)
[![CRAN RStudio mirror
downloads](https://cranlogs.r-pkg.org/badges/last-month/cryptoQuotes?color=blue)](https://r-pkg.org/pkg/cryptoQuotes)
[![R-CMD-check](https://github.com/serkor1/cryptoQuotes/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/serkor1/cryptoQuotes/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/serkor1/cryptoQuotes/graph/badge.svg?token=D7NF1BPVL5)](https://codecov.io/gh/serkor1/cryptoQuotes)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
![GitHub last commit
(branch)](https://img.shields.io/github/last-commit/serkor1/cryptoQuotes/development)
<!-- badges: end -->

The `cryptoQuotes`-package is a high-level API-client to get current and
historical cryptocurrency market data in `R`, without using web-crawlers
or API keys. This `R`-package uses `xts` and `zoo` under the hood and
are compatible with `quantmod` and `TTR` out of the box.

<div align="center">

<table class="table" style="color: black; margin-left: auto; margin-right: auto;">
<caption>
Available tickers by exchange and markets
</caption>
<thead>
<tr>
<th style="text-align:left;">
Endpoint
</th>
<th style="text-align:center;">
Binance
</th>
<th style="text-align:center;">
Bitmart
</th>
<th style="text-align:center;">
Bybit
</th>
<th style="text-align:center;">
Kraken
</th>
<th style="text-align:center;">
Kucoin
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
Spot
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
</tr>
<tr>
<td style="text-align:left;">
Futures
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
</tr>
<tr>
<td style="text-align:left;">
Long-Short Ratio
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
<td style="text-align:center;">
:x:
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
<td style="text-align:center;">
:x:
</td>
</tr>
<tr>
<td style="text-align:left;">
Open Interest
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
<td style="text-align:center;">
:x:
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
<td style="text-align:center;">
:x:
</td>
</tr>
<tr>
<td style="text-align:left;">
Funding Rate
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
<td style="text-align:center;">
:x:
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
<td style="text-align:center;">
:x:
</td>
<td style="text-align:center;">
:white_check_mark:
</td>
</tr>
</tbody>
</table>

</div>

## :information_source: Overview

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
  ticker   = 'BTCUSDT',
  source   = 'binance',
  futures  = FALSE,
  interval = '30m',
  from     = Sys.Date() - 1 
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
index
</th>
<th style="text-align:center;">
open
</th>
<th style="text-align:center;">
high
</th>
<th style="text-align:center;">
low
</th>
<th style="text-align:center;">
close
</th>
<th style="text-align:left;">
volume
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
2024-05-24 17:30:00
</td>
<td style="text-align:center;">
68219.44
</td>
<td style="text-align:center;">
68396.77
</td>
<td style="text-align:center;">
68130.43
</td>
<td style="text-align:center;">
68326.46
</td>
<td style="text-align:left;">
803.84837
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-05-24 18:00:00
</td>
<td style="text-align:center;">
68326.46
</td>
<td style="text-align:center;">
68473.85
</td>
<td style="text-align:center;">
67924.39
</td>
<td style="text-align:center;">
68112.12
</td>
<td style="text-align:left;">
975.72647
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-05-24 18:30:00
</td>
<td style="text-align:center;">
68112.13
</td>
<td style="text-align:center;">
68396.51
</td>
<td style="text-align:center;">
68105.07
</td>
<td style="text-align:center;">
68394.33
</td>
<td style="text-align:left;">
680.33966
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-05-24 19:00:00
</td>
<td style="text-align:center;">
68394.32
</td>
<td style="text-align:center;">
68676.77
</td>
<td style="text-align:center;">
68394.32
</td>
<td style="text-align:center;">
68555.98
</td>
<td style="text-align:left;">
1064.08397
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-05-24 19:30:00
</td>
<td style="text-align:center;">
68555.99
</td>
<td style="text-align:center;">
68931.31
</td>
<td style="text-align:center;">
68555.98
</td>
<td style="text-align:center;">
68919.02
</td>
<td style="text-align:left;">
806.76798
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-05-24 20:00:00
</td>
<td style="text-align:center;">
68919.02
</td>
<td style="text-align:center;">
69178.06
</td>
<td style="text-align:center;">
68856
</td>
<td style="text-align:center;">
69165.14
</td>
<td style="text-align:left;">
967.59605
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

## :information_source: Code of Conduct

Please note that the `cryptoQuotes` project is released with a
[Contributor Code of
Conduct](https://serkor1.github.io/cryptoQuotes/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
