
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cryptoQuotes: A streamlined access to OHLC-V market data and sentiment indicators in R <a href="https://serkor1.github.io/cryptoQuotes/"><img src="man/figures/logo.png" align="right" height="139" alt="cryptoQuotes website" /></a>

<!-- badges: start -->

![GitHub
Release](https://img.shields.io/github/v/release/serkor1/cryptoQuotes?logo=github&label=release)
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
2024-01-08 11:30:00
</td>
<td style="text-align:center;">
44196.7
</td>
<td style="text-align:center;">
44688
</td>
<td style="text-align:center;">
44154.28
</td>
<td style="text-align:center;">
44635.99
</td>
<td style="text-align:left;">
2259.56815
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-01-08 12:00:00
</td>
<td style="text-align:center;">
44636
</td>
<td style="text-align:center;">
45200
</td>
<td style="text-align:center;">
44350
</td>
<td style="text-align:center;">
44518.16
</td>
<td style="text-align:left;">
5567.92331
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-01-08 12:30:00
</td>
<td style="text-align:center;">
44518.15
</td>
<td style="text-align:center;">
45120.05
</td>
<td style="text-align:center;">
44518.15
</td>
<td style="text-align:center;">
45111.09
</td>
<td style="text-align:left;">
1949.63739
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-01-08 13:00:00
</td>
<td style="text-align:center;">
45111.1
</td>
<td style="text-align:center;">
45179.14
</td>
<td style="text-align:center;">
44948.83
</td>
<td style="text-align:center;">
45098
</td>
<td style="text-align:left;">
1995.89183
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-01-08 13:30:00
</td>
<td style="text-align:center;">
45098
</td>
<td style="text-align:center;">
45108.38
</td>
<td style="text-align:center;">
44807.56
</td>
<td style="text-align:center;">
44911.58
</td>
<td style="text-align:left;">
1327.42193
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-01-08 14:00:00
</td>
<td style="text-align:center;">
44911.58
</td>
<td style="text-align:center;">
45031.31
</td>
<td style="text-align:center;">
44832
</td>
<td style="text-align:center;">
45002.78
</td>
<td style="text-align:left;">
871.80155
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

## Code of Conduct

Please note that the `cryptoQuotes` project is released with a
[Contributor Code of
Conduct](https://serkor1.github.io/cryptoQuotes/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
