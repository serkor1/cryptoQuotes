
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cryptoQuotes: Cryptocurrency Market Data in R <a href="https://serkor1.github.io/cryptoQuotes/"><img src="man/figures/logo.png" align="right" height="139" alt="cryptoQuotes website" /></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/cryptoQuotes)](https://CRAN.R-project.org/package=cryptoQuotes)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
[![R-CMD-check](https://github.com/serkor1/cryptoQuotes/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/serkor1/cryptoQuotes/actions/workflows/R-CMD-check.yaml)
[![Codecov test
coverage](https://codecov.io/gh/serkor1/cryptoQuotes/branch/main/graph/badge.svg)](https://app.codecov.io/gh/serkor1/cryptoQuotes?branch=main)
[![CRAN RStudio mirror
downloads](https://cranlogs.r-pkg.org/badges/last-month/cryptoQuotes?color=blue)](https://r-pkg.org/pkg/cryptoQuotes)
<!-- badges: end -->

## Overview

A high-level API-client to get current, and historical, cryptocurrency
OHLCV market data in `R`, without using web-crawlers and API keys. This
API-client uses `httr2`, `xts` and `zoo` under the hood and are
compatible with `quantmod` and `TTR`.

### Supported exchanges and markets

All supported exchanges and markets are listed in the table below,
alongside the available range of intervals available from the respective
exchanges

<div align="center">

<table style="width:100%; margin-left: auto; margin-right: auto;" class="table">
<caption>
Available exchanges, markets and interavals.
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
Seconds
</td>
<td style="text-align:center;">
Months
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
11
</td>
<td style="text-align:center;">
Minutes
</td>
<td style="text-align:center;">
Weeks
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
Minutes
</td>
<td style="text-align:center;">
Weeks
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
9
</td>
<td style="text-align:center;">
Minutes
</td>
<td style="text-align:center;">
Weeks
</td>
</tr>
</tbody>
</table>

</div>

### Basic usage

Get USDT denominated Bitcoin spot market price from Binance with
`30m`-intervals,

``` r
## BTC OHLC prices
## from Binance spot market
## in 30 minute intervals
BTC <- cryptoQuotes::getQuote(
  ticker = 'BTCUSDT',
  source = 'binance',
  futures = FALSE,
  interval = '30m'
)
```

<div align="center">

<table style="width:100%; margin-left: auto; margin-right: auto;" class="table">
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
2023-12-26 21:30:00
</td>
<td style="text-align:center;">
42328.05
</td>
<td style="text-align:center;">
42342.64
</td>
<td style="text-align:center;">
42251.1
</td>
<td style="text-align:center;">
42338.47
</td>
<td style="text-align:left;">
476.10312
</td>
</tr>
<tr>
<td style="text-align:left;">
2023-12-26 22:00:00
</td>
<td style="text-align:center;">
42338.47
</td>
<td style="text-align:center;">
42591.89
</td>
<td style="text-align:center;">
42325.41
</td>
<td style="text-align:center;">
42474.72
</td>
<td style="text-align:left;">
833.25736
</td>
</tr>
<tr>
<td style="text-align:left;">
2023-12-26 22:30:00
</td>
<td style="text-align:center;">
42474.73
</td>
<td style="text-align:center;">
42500
</td>
<td style="text-align:center;">
42400.57
</td>
<td style="text-align:center;">
42469.99
</td>
<td style="text-align:left;">
363.68336
</td>
</tr>
<tr>
<td style="text-align:left;">
2023-12-26 23:00:00
</td>
<td style="text-align:center;">
42470
</td>
<td style="text-align:center;">
42520
</td>
<td style="text-align:center;">
42404.1
</td>
<td style="text-align:center;">
42422.47
</td>
<td style="text-align:left;">
565.58056
</td>
</tr>
<tr>
<td style="text-align:left;">
2023-12-26 23:30:00
</td>
<td style="text-align:center;">
42422.46
</td>
<td style="text-align:center;">
42530.09
</td>
<td style="text-align:center;">
42416
</td>
<td style="text-align:center;">
42508.93
</td>
<td style="text-align:left;">
412.06818
</td>
</tr>
<tr>
<td style="text-align:left;">
2023-12-27
</td>
<td style="text-align:center;">
42508.93
</td>
<td style="text-align:center;">
42541.1
</td>
<td style="text-align:center;">
42425.72
</td>
<td style="text-align:center;">
42464.59
</td>
<td style="text-align:left;">
442.53384
</td>
</tr>
</tbody>
</table>

</div>

## Installation

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
  ref = 'main'
)
```
