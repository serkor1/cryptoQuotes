
<!-- index.md is generated from index.Rmd. Please edit that file -->

# {cryptoQuotes}: Open access to cryptocurrency market data <a href="https://serkor1.github.io/cryptoQuotes/"><img src="man/figures/logo.png" align="right" height="154" alt="cryptocurrency in R"/></a>

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

[{cryptoQuotes}](https://serkor1.github.io/cryptoQuotes/) is a
high-level API client for accessing public market data endpoints on
major cryptocurrency exchanges. It supports open, high, low, close and
volume (OHLC-V) data and a variety of sentiment indicators; the market
data is high quality and can be retrieved in intervals ranging from
*seconds* to *months*.

All the market data is accessed and processed without relying on
crawlers, or API keys, ensuring an open, and reliable, access for
researchers, traders and students alike.

## Basic usage

Below is an example on retrieving OHLC-V data for Bitcoin in 30 minute
intervals,

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

## display latest
## values
tail(BTC)
```

    #>                        open    high     low   close    volume
    #> 2024-07-09 18:30:00 57667.8 57718.6 57318.3 57663.1  5587.568
    #> 2024-07-09 19:00:00 57663.0 57780.0 57422.4 57580.2  3122.371
    #> 2024-07-09 19:30:00 57582.0 57631.6 57344.7 57497.1  2389.315
    #> 2024-07-09 20:00:00 57497.0 57950.0 57418.9 57699.9  4807.539
    #> 2024-07-09 20:30:00 57700.0 58290.6 57679.0 57888.0 12973.359
    #> 2024-07-09 21:00:00 57888.0 57912.2 57716.0 57812.5  1562.662

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
