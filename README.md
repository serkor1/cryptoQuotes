
<!-- README.md is generated from README.Rmd. Please edit that file -->

## cryptoQuotes <a href="https://serkor1.github.io/cryptoQuotes/"><img src="man/figures/logo.png" align="right" height="139" alt="cryptoQuotes website" /></a>

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

The `cryptoQuotes` package is an unified API client that provides access
to public market data from all major cryptocurrency exchanges. The
package is compatible with `quantmod` and `TTR` out of the box.

### Supported Exchanges and Markets

| Exchange | Spot | Futures |
|:---------|:-----|:--------|
| Binance  | ✔    | ✔       |
| Kucoin   | ✔    | ✔       |
| Bitmart  | ✔    | ✔       |
| Kraken   | ✔    | ✔       |

#### Basic usage

Get USDT denominated ATOM in the spot market from Binance in `30m`
intervals,

``` r
## get perpetual contracts on USDT denominated ATOM
spotPrice <- cryptoQuotes::getQuote(
  ticker = 'ATOMUSDT',
  source = 'binance',
  futures = FALSE,
  interval = '30m'
)
```

#### Installation

**Stable Version**

``` r
# install from CRAN
install.packages('cryptoQuotes', dependencies = TRUE)
```

**Development Version**

``` r
devtools::install_github(
  repo = 'https://github.com/serkor1/cryptoQuotes/',
  ref = 'main'
)
```
