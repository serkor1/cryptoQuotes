
<!-- index.md is generated from index.Rmd. Please edit that file -->

# Open access to cryptocurrency market data in R <a href="https://serkor1.github.io/cryptoQuotes/"><img src="man/figures/logo.png" align="right" height="139" alt="cryptocurrency in R"/></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/cryptoQuotes)](https://CRAN.R-project.org/package=cryptoQuotes)
[![CRAN RStudio mirror
downloads](https://cranlogs.r-pkg.org/badges/last-month/cryptoQuotes?color=blue)](https://r-pkg.org/pkg/cryptoQuotes)
[![R-CMD-check](https://github.com/serkor1/cryptoQuotes/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/serkor1/cryptoQuotes/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/serkor1/cryptoQuotes/graph/badge.svg?token=D7NF1BPVL5)](https://codecov.io/gh/serkor1/cryptoQuotes)
[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The `cryptoQuotes` package provides open access to cryptocurrency market
data in `R` by utilizing public market data endpoints through `curl`.
This package does not require any `API` keys, making it straightforward
and easy to use for accessing real-time and historical cryptocurrency
data.

## Example: Bitcoin OHLC-V with Long-Short Ratios

<table style="width: fit-content; font-size: 16px; color: black; margin-left: auto; margin-right: auto;" class="table table-responsive table-bordered">
<caption style="font-size: initial !important;">
Bitcoin (BTC) in 30 minute intervals with Long-Short Ratios.
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
<th style="text-align:center;">
long
</th>
<th style="text-align:center;">
short
</th>
<th style="text-align:center;">
ls_ratio
</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:left;">
2024-05-20 13:00:00
</td>
<td style="text-align:center;">
67072.7
</td>
<td style="text-align:center;">
67278.4
</td>
<td style="text-align:center;">
67012.9
</td>
<td style="text-align:center;">
67174.1
</td>
<td style="text-align:left;">
3421.493
</td>
<td style="text-align:center;">
0.498
</td>
<td style="text-align:center;">
0.502
</td>
<td style="text-align:center;">
0.993
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-05-20 13:30:00
</td>
<td style="text-align:center;">
67174
</td>
<td style="text-align:center;">
67200
</td>
<td style="text-align:center;">
66868.6
</td>
<td style="text-align:center;">
66974
</td>
<td style="text-align:left;">
3401.276
</td>
<td style="text-align:center;">
0.494
</td>
<td style="text-align:center;">
0.506
</td>
<td style="text-align:center;">
0.977
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-05-20 14:00:00
</td>
<td style="text-align:center;">
66974
</td>
<td style="text-align:center;">
67063
</td>
<td style="text-align:center;">
66859.3
</td>
<td style="text-align:center;">
66883.9
</td>
<td style="text-align:left;">
2277.018
</td>
<td style="text-align:center;">
0.492
</td>
<td style="text-align:center;">
0.508
</td>
<td style="text-align:center;">
0.97
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-05-20 14:30:00
</td>
<td style="text-align:center;">
66883.9
</td>
<td style="text-align:center;">
66994.7
</td>
<td style="text-align:center;">
66760
</td>
<td style="text-align:center;">
66903.5
</td>
<td style="text-align:left;">
4318.688
</td>
<td style="text-align:center;">
0.492
</td>
<td style="text-align:center;">
0.508
</td>
<td style="text-align:center;">
0.969
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-05-20 15:00:00
</td>
<td style="text-align:center;">
66903.5
</td>
<td style="text-align:center;">
67073.9
</td>
<td style="text-align:center;">
66866
</td>
<td style="text-align:center;">
66960
</td>
<td style="text-align:left;">
3334.157
</td>
<td style="text-align:center;">
0.49
</td>
<td style="text-align:center;">
0.51
</td>
<td style="text-align:center;">
0.961
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-05-20 15:30:00
</td>
<td style="text-align:center;">
66959.9
</td>
<td style="text-align:center;">
67059.7
</td>
<td style="text-align:center;">
66929.9
</td>
<td style="text-align:center;">
67059.6
</td>
<td style="text-align:left;">
526.914
</td>
<td style="text-align:center;">
0.492
</td>
<td style="text-align:center;">
0.508
</td>
<td style="text-align:center;">
0.967
</td>
</tr>
</tbody>
</table>
<details>
<summary>
Source
</summary>

``` r
## get OHLC-V in 30 minute intervals
## for Bitcoin from Binance
## futures market since yesterday
BTC <- cryptoQuotes::get_quote(
  ticker   = 'BTCUSDT',
  source   = 'binance',
  futures  = TRUE,
  interval = '30m',
  from     = Sys.Date() - 1 
)

## get the Long-Short Ratios in 30 minute
## intervals for Bitcoin from 
## Binance since yesterday
BTC_LSR <- cryptoQuotes::get_lsratio(
  ticker   = 'BTCUSDT',
  source   = 'binance',
  interval = '30m',
  from     = Sys.Date() - 1 
)

## merge the OHLC-B
## and Long-Short Ratios
BTC <- merge(
  BTC,
  BTC_LSR
)
```

</details>

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
  ref  = 'development'
)
```
