
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
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
![GitHub last commit
(branch)](https://img.shields.io/github/last-commit/serkor1/cryptoQuotes/development)
<!-- badges: end -->

The `cryptoQuotes`-package is a high-level API client for accessing
public market data endpoints on major cryptocurrency exchanges. It
supports open, high, low, close and volume (OHLC-V) data and a variety
of sentiment indicators; the market data is high quality and can be
retrieved in intervals ranging from *seconds* to *months*. All the
market data is accessed and processed without relying on crawlers, or
API keys, ensuring an open, and reliable, access for researchers,
traders and students alike.

## Example: Bitcoin OHLC-V with Long-Short Ratios

<div align="center">

<table style="width: fit-content; font-size: 14px; color: black; margin-left: auto; margin-right: auto;" class="table table-responsive table-bordered">
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
2024-05-25 12:00:00
</td>
<td style="text-align:center;">
69118
</td>
<td style="text-align:center;">
69133.8
</td>
<td style="text-align:center;">
69040.8
</td>
<td style="text-align:center;">
69061.1
</td>
<td style="text-align:left;">
1229.377
</td>
<td style="text-align:center;">
0.587
</td>
<td style="text-align:center;">
0.413
</td>
<td style="text-align:center;">
1.42
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-05-25 12:30:00
</td>
<td style="text-align:center;">
69061
</td>
<td style="text-align:center;">
69492.1
</td>
<td style="text-align:center;">
69058.8
</td>
<td style="text-align:center;">
69397.6
</td>
<td style="text-align:left;">
5130.885
</td>
<td style="text-align:center;">
0.585
</td>
<td style="text-align:center;">
0.415
</td>
<td style="text-align:center;">
1.411
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-05-25 13:00:00
</td>
<td style="text-align:center;">
69397.7
</td>
<td style="text-align:center;">
69622.8
</td>
<td style="text-align:center;">
69345.8
</td>
<td style="text-align:center;">
69560.1
</td>
<td style="text-align:left;">
5232.397
</td>
<td style="text-align:center;">
0.589
</td>
<td style="text-align:center;">
0.411
</td>
<td style="text-align:center;">
1.434
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-05-25 13:30:00
</td>
<td style="text-align:center;">
69560
</td>
<td style="text-align:center;">
69563.3
</td>
<td style="text-align:center;">
69112.4
</td>
<td style="text-align:center;">
69112.5
</td>
<td style="text-align:left;">
5320.138
</td>
<td style="text-align:center;">
0.589
</td>
<td style="text-align:center;">
0.411
</td>
<td style="text-align:center;">
1.434
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-05-25 14:00:00
</td>
<td style="text-align:center;">
69112.4
</td>
<td style="text-align:center;">
69323.9
</td>
<td style="text-align:center;">
69031.4
</td>
<td style="text-align:center;">
69234.1
</td>
<td style="text-align:left;">
4699.305
</td>
<td style="text-align:center;">
0.581
</td>
<td style="text-align:center;">
0.419
</td>
<td style="text-align:center;">
1.386
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-05-25 14:30:00
</td>
<td style="text-align:center;">
69234
</td>
<td style="text-align:center;">
69260.4
</td>
<td style="text-align:center;">
69103.6
</td>
<td style="text-align:center;">
69131.9
</td>
<td style="text-align:left;">
1183.558
</td>
<td style="text-align:center;">
0.585
</td>
<td style="text-align:center;">
0.416
</td>
<td style="text-align:center;">
1.407
</td>
</tr>
</tbody>
</table>

</div>

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

## :information_source: Installation

### :shield: Stable version

``` r
## install from CRAN
install.packages(
  pkgs = 'cryptoQuotes',
  dependencies = TRUE
)
```

### :hammer_and_wrench: Development version

``` r
## install from github
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
