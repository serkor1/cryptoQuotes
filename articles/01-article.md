# Cryptocurrency Market Data in R

``` r
## load library
library(cryptoQuotes)
```

The main goal of the
[{cryptoQuotes}](https://github.com/serkor1/cryptoQuotes) is to bridge
the gap between `R` and the cryptocurrency market data. Its a high-level
`API`-client that connects to major cryptocurrency exchanges and their
respective public market data endpoints.

In this article we will focus on `price` and `sentiment` data made
available by the [Kraken](https://www.kraken.com/) exchange.

## Cryptocurrency market data

In this section we will focus on market data from the last 24 hours, on
the hourly chart.

### Open, Highl Low, Close and Volume (OHLC-V) data

To get `OHLC-V` data the
[`get_quote()`](https://serkor1.github.io/cryptoQuotes/reference/get_quote.md)-function
is the go-to function,

``` r
## Get the
## SPOT price of 
## Bitcoin on the hourly
BTC <- get_quote(
  ticker   = "BTCUSD",
  source   = "kraken",
  futures  = FALSE,
  interval = "1h",
  from     = Sys.Date() - 1
)
```

| index               |  open   |  high   |   low   |  close  | volume |
|:--------------------|:-------:|:-------:|:-------:|:-------:|:-------|
| 2026-02-15 05:00:00 | 70138.7 | 70432.5 |  70121  | 70260.1 | 32.267 |
| 2026-02-15 06:00:00 | 70260.1 | 70498.8 | 70180.5 | 70383.3 | 63.791 |
| 2026-02-15 07:00:00 | 70383.3 | 70877.3 | 70304.4 |  70780  | 91.881 |
| 2026-02-15 08:00:00 | 70783.7 | 70935.2 | 70149.6 |  70400  | 61.036 |
| 2026-02-15 09:00:00 |  70400  | 70626.8 | 70357.7 |  70395  | 8.114  |
| 2026-02-15 10:00:00 |  70395  |  70479  |  70200  | 70478.9 | 7.464  |

Hourly Bitcoin OHLC-V data

### Sentiment data

One sentiment indicator for Bitcoin is the long-short ratio, which can
be retrieved using
[`get_lsratio()`](https://serkor1.github.io/cryptoQuotes/reference/get_lsratio.md)-function,

``` r
## Get the
## long-short ratio of 
## Bitcoin on the hourly
LS_BTC <- get_lsratio(
  ticker   = "PF_XBTUSD",
  source   = "kraken",
  interval = "1h",
  from     = Sys.Date() - 1
)
```

| index               | long  | short | ls_ratio |
|:--------------------|:-----:|:-----:|:--------:|
| 2026-02-15 05:00:00 | 0.633 | 0.367 |  1.723   |
| 2026-02-15 06:00:00 | 0.631 | 0.369 |  1.709   |
| 2026-02-15 07:00:00 | 0.638 | 0.362 |  1.765   |
| 2026-02-15 08:00:00 | 0.64  | 0.36  |  1.776   |
| 2026-02-15 09:00:00 | 0.639 | 0.361 |  1.768   |
| 2026-02-15 10:00:00 | 0.639 | 0.361 |  1.772   |

Hourly Long-Short Ratio on Bitcoin

## Limitations

There is a limit to the amount of market data that can be extracted in
one call. The [Kraken](https://www.kraken.com/) exchange, for example,
has a limit on `5000` rows of data per call in the futures market,

``` r
## Get the SPOT
## market for over 
## 2000 rows
tryCatch(
  get_quote(
    ticker   = "PF_XBTUSD",
    source   = "kraken",
    futures  = TRUE,
    interval = "5m",
    from     = Sys.Date() - 25,
    to       = Sys.Date()
  ),
  error = function(error) {
    
    error
    
  }
)
#>                         open     high      low    close volume
#> 2026-01-21 00:00:00 88349.95 88527.50 88289.35 88489.46      0
#> 2026-01-21 00:05:00 88489.46 88532.90 88419.64 88446.51      0
#> 2026-01-21 00:10:00 88446.51 88464.32 88298.70 88333.35      0
#> 2026-01-21 00:15:00 88333.35 88391.45 88234.62 88320.80      0
#> 2026-01-21 00:20:00 88320.80 88321.69 88166.39 88291.43      0
#> 2026-01-21 00:25:00 88291.43 88526.27 88255.73 88480.65      0
#> 2026-01-21 00:30:00 88480.65 88527.83 88421.06 88525.87      0
#> 2026-01-21 00:35:00 88525.87 88854.73 88525.59 88813.35      0
#> 2026-01-21 00:40:00 88813.35 88819.79 88735.02 88766.63      0
#> 2026-01-21 00:45:00 88766.63 88861.78 88740.70 88844.70      0
#>                 ...                                           
#> 2026-01-27 21:50:00 89014.81 89070.04 88997.32 89043.02      0
#> 2026-01-27 21:55:00 89043.02 89050.46 88907.15 88972.46      0
#> 2026-01-27 22:00:00 88972.46 89124.92 88972.46 89024.96      0
#> 2026-01-27 22:05:00 89024.96 89063.48 88989.85 88994.37      0
#> 2026-01-27 22:10:00 88994.37 89082.37 88994.37 89042.39      0
#> 2026-01-27 22:15:00 89042.39 89094.07 88931.45 88943.73      0
#> 2026-01-27 22:20:00 88943.73 89069.46 88913.79 89068.94      0
#> 2026-01-27 22:25:00 89068.94 89152.33 89012.17 89066.30      0
#> 2026-01-27 22:30:00 89066.30 89126.92 89026.98 89123.68      0
#> 2026-01-27 22:35:00 89123.68 89316.90 89117.70 89230.17      0
```

If you need more data than this, you need to do multiple calls. One such
solution is the following,

``` r
## 1) create date
## sequence
dates <- seq(
  from       = as.POSIXct(Sys.Date()),
  by         = "-5 mins",
  length.out = 10000
)

## 2) split the sequence
## in multiples of 100
## by assigning numbers
## to each indices of 100
idx <- rep(
  x    = 1:2,
  each = 5000
)

## 3) use the idx to split
## the dates into equal parts
split_dates <- split(
  x = dates,
  f = idx
)

## 4) collect all all
## calls in a list
## using lapply
ohlc <- lapply(
  X   = split_dates,
  FUN = function(dates){
    
    Sys.sleep(1)
    
    cryptoQuotes::get_quote(
      ticker   = "PF_XBTUSD",
      source   = "kraken",
      futures  = TRUE,
      interval = "5m",
      from     = min(dates),
      to       = max(dates)
    )
    
  }
)

## 4.1) rbind all
## elements
nrow(
  ohlc <- do.call(
    what = rbind,
    args = ohlc
  )
)
#> [1] 4000
```

> **Note:** For an indepth analysis of the various limitations and
> workarounds please see the
> [{cryptoQuotes}](https://github.com/serkor1/cryptoQuotes)
> [wiki](https://github.com/serkor1/cryptoQuotes/wiki/Limits-and-Restrictions)
> on [Github](https://github.com/serkor1/cryptoQuotes)
