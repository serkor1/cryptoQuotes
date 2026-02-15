# GET-requests

GET-requests

## Usage

``` r
GET(url, endpoint = NULL, query = NULL, path = NULL)
```

## Arguments

- url:

  [character](https://rdrr.io/r/base/character.html) of length 1. The
  baseurl

- endpoint:

  [character](https://rdrr.io/r/base/character.html) of length 1. The
  API endpoint

- query:

  A named [list](https://rdrr.io/r/base/list.html) of queries.

- path:

  A [list](https://rdrr.io/r/base/list.html) of paths.

## Value

A [list](https://rdrr.io/r/base/list.html) crated by
[`jsonlite::fromJSON()`](https://jeroen.r-universe.dev/jsonlite/reference/fromJSON.html)

## See also

Other development tools:
[`chart_layout()`](https://serkor1.github.io/cryptoQuotes/reference/chart_layout.md),
[`convert_date()`](https://serkor1.github.io/cryptoQuotes/reference/convert_date.md),
[`default_dates()`](https://serkor1.github.io/cryptoQuotes/reference/default_dates.md),
[`fetch()`](https://serkor1.github.io/cryptoQuotes/reference/fetch.md),
[`flatten()`](https://serkor1.github.io/cryptoQuotes/reference/flatten.md),
[`is.date()`](https://serkor1.github.io/cryptoQuotes/reference/is.date.md)

## Examples

``` r
if (FALSE) { # \dontrun{
  # script start;

  exchange <- "bybit"
  futures  <- FALSE

  # 1) define baseurl
  base_url <- cryptoQuotes:::baseUrl(
    source  = exchange,
    futures = futures
  )

  # 2) define endpoint
  end_point <- cryptoQuotes:::endPoint(
    source  = "bybit",
    futures = futures,
    type    = "ohlc"
  )

  # 2) define actual
  # parameters based on
  # API docs
  queries <- list(
    symbol   = "BTCUSDT",
    category = "spot",
    limit    = 100,
    interval = "D"
  )

  # 3) perform GET request
  cryptoQuotes:::GET(
    url      = base_url,
    endpoint = end_point,
    query    = queries
  )

  # script end;
} # }
```
