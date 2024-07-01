
<!-- index.md is generated from index.Rmd. Please edit that file -->

# Open access to cryptocurrency market data in R <a href="https://serkor1.github.io/cryptoQuotes/"><img src="man/figures/logo.png" align="right" height="139" alt="cryptocurrency in R"/></a>

<!-- badges: start -->

[![CRAN
status](https://www.r-pkg.org/badges/version/cryptoQuotes)](https://CRAN.R-project.org/package=cryptoQuotes)
[![CRAN RStudio mirror
downloads](https://cranlogs.r-pkg.org/badges/last-month/cryptoQuotes?color=blue)](https://r-pkg.org/pkg/cryptoQuotes)
[![R-CMD-check](https://github.com/serkor1/cryptoQuotes/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/serkor1/cryptoQuotes/actions/workflows/R-CMD-check.yaml)
[![codecov](https://codecov.io/gh/serkor1/cryptoQuotes/graph/badge.svg?token=D7NF1BPVL5)](https://app.codecov.io/gh/serkor1/cryptoQuotes)
[![Lifecycle:
stable](https://img.shields.io/badge/lifecycle-stable-brightgreen.svg)](https://lifecycle.r-lib.org/articles/stages.html#stable)
![GitHub last commit
(branch)](https://img.shields.io/github/last-commit/serkor1/cryptoQuotes/development)
<!-- badges: end -->

[{cryptoQuotes}](https://github.com/serkor1/cryptoQuotes) is a
high-level API client for accessing public market data endpoints on
major cryptocurrency exchanges. It supports open, high, low, close and
volume (OHLC-V) data and a variety of sentiment indicators; the market
data is high quality and can be retrieved in intervals ranging from
*seconds* to *months*. All the market data is accessed and processed
without relying on crawlers, or API keys, ensuring an open, and
reliable, access for researchers, traders and students alike.

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
2024-06-29 07:30:00
</td>
<td style="text-align:center;">
60756.7
</td>
<td style="text-align:center;">
60778.9
</td>
<td style="text-align:center;">
60720.4
</td>
<td style="text-align:center;">
60756.1
</td>
<td style="text-align:left;">
678.876
</td>
<td style="text-align:center;">
0.753
</td>
<td style="text-align:center;">
0.247
</td>
<td style="text-align:center;">
3.049
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-06-29 08:00:00
</td>
<td style="text-align:center;">
60756
</td>
<td style="text-align:center;">
60794.7
</td>
<td style="text-align:center;">
60736.1
</td>
<td style="text-align:center;">
60793.4
</td>
<td style="text-align:left;">
765.759
</td>
<td style="text-align:center;">
0.752
</td>
<td style="text-align:center;">
0.248
</td>
<td style="text-align:center;">
3.04
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-06-29 08:30:00
</td>
<td style="text-align:center;">
60793.5
</td>
<td style="text-align:center;">
60864
</td>
<td style="text-align:center;">
60764.2
</td>
<td style="text-align:center;">
60838
</td>
<td style="text-align:left;">
1053.097
</td>
<td style="text-align:center;">
0.753
</td>
<td style="text-align:center;">
0.247
</td>
<td style="text-align:center;">
3.044
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-06-29 09:00:00
</td>
<td style="text-align:center;">
60838
</td>
<td style="text-align:center;">
61120
</td>
<td style="text-align:center;">
60822
</td>
<td style="text-align:center;">
61103.2
</td>
<td style="text-align:left;">
4611.515
</td>
<td style="text-align:center;">
0.753
</td>
<td style="text-align:center;">
0.247
</td>
<td style="text-align:center;">
3.055
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-06-29 09:30:00
</td>
<td style="text-align:center;">
61103.1
</td>
<td style="text-align:center;">
61128.1
</td>
<td style="text-align:center;">
61038.2
</td>
<td style="text-align:center;">
61049.8
</td>
<td style="text-align:left;">
2455.215
</td>
<td style="text-align:center;">
0.75
</td>
<td style="text-align:center;">
0.25
</td>
<td style="text-align:center;">
2.992
</td>
</tr>
<tr>
<td style="text-align:left;">
2024-06-29 10:00:00
</td>
<td style="text-align:center;">
61049.8
</td>
<td style="text-align:center;">
61073.3
</td>
<td style="text-align:center;">
60942
</td>
<td style="text-align:center;">
60947.2
</td>
<td style="text-align:left;">
1678.662
</td>
<td style="text-align:center;">
0.746
</td>
<td style="text-align:center;">
0.254
</td>
<td style="text-align:center;">
2.929
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

Please note that the
[{cryptoQuotes}](https://github.com/serkor1/cryptoQuotes) project is
released with a [Contributor Code of
Conduct](https://serkor1.github.io/cryptoQuotes/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
