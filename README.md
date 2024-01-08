
<!-- README.md is generated from README.Rmd. Please edit that file -->

# cryptoQuotes: A streamlined access to OHLC-V market data and sentiment indicators in R <a href="https://serkor1.github.io/cryptoQuotes/"><img src="man/figures/logo.png" align="right" height="139" alt="cryptoQuotes website" /></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/cryptoQuotes)](https://CRAN.R-project.org/package=cryptoQuotes)
![GitHub
Release](https://img.shields.io/github/v/release/serkor1/cryptoQuotes?logo=github&label=release)
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
2024-01-08 01:30:00
</td>
<td style="text-align:center;">
43788.74
</td>
<td style="text-align:center;">
43800.03
</td>
<td style="text-align:center;">
43665.31
</td>
<td style="text-align:center;">
43713.06
</td>
<td style="text-align:left;">
466.61525
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-01-08 02:00:00
</td>
<td style="text-align:center;">
43713.07
</td>
<td style="text-align:center;">
43800.07
</td>
<td style="text-align:center;">
43534.78
</td>
<td style="text-align:center;">
43636.94
</td>
<td style="text-align:left;">
684.95496
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-01-08 02:30:00
</td>
<td style="text-align:center;">
43636.94
</td>
<td style="text-align:center;">
43668.14
</td>
<td style="text-align:center;">
43175
</td>
<td style="text-align:center;">
43371.09
</td>
<td style="text-align:left;">
1740.05517
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-01-08 03:00:00
</td>
<td style="text-align:center;">
43371.09
</td>
<td style="text-align:center;">
43442.42
</td>
<td style="text-align:center;">
43225
</td>
<td style="text-align:center;">
43277.82
</td>
<td style="text-align:left;">
1138.00533
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-01-08 03:30:00
</td>
<td style="text-align:center;">
43277.83
</td>
<td style="text-align:center;">
43568.85
</td>
<td style="text-align:center;">
43257.29
</td>
<td style="text-align:center;">
43518.2
</td>
<td style="text-align:left;">
984.91972
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-01-08 04:00:00
</td>
<td style="text-align:center;">
43518.2
</td>
<td style="text-align:center;">
43598
</td>
<td style="text-align:center;">
43430.79
</td>
<td style="text-align:center;">
43495.83
</td>
<td style="text-align:left;">
566.69391
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
