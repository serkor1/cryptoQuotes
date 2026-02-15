# Changelog

## Version 1.3.3

CRAN release: 2025-09-15

### General

#### New features

- The
  [`get_mktcap()`](https://serkor1.github.io/cryptoQuotes/reference/get_mktcap.md)-function
  returns the global market capitalization of the cryptocurrency market.
  It also has the option to return altcoin market capitalization.

``` r
# get market capitalization
tail(
  get_mktcap()
)
```

``` R
#>                        marketcap       volume
#> 2026-01-31 22:15:00 2.638013e+12 174620475855
#> 2026-02-01 22:15:00 2.610109e+12 131569299731
#> 2026-02-02 22:15:00 2.649726e+12 213047787315
#> 2026-02-03 22:15:00 2.570898e+12 165843309387
#> 2026-02-04 22:15:00 2.449463e+12 162971002109
#> 2026-02-05 22:15:00 2.183401e+12 264076715964
```

### Bugfixes

- A bug in the funding rates from Binance have been fixed. The returned
  values was the time indices of the json-array, not the actual rates.

## Version 1.3.2

CRAN release: 2024-11-07

### General

- `bitmart` has updated their futures API. The backend have been updated
  accordingly.

- Unit-tests have been updated and now all
  [`get_quote()`](https://serkor1.github.io/cryptoQuotes/reference/get_quote.md)-functions
  are being tested for equality in passed and inferred interval.

### Improvements

### \[NEW FEATURE\] Read and Write `xts`-objects

- [`read_xts()`](https://serkor1.github.io/cryptoQuotes/reference/write_xts.md)
  and
  [`write_xts()`](https://serkor1.github.io/cryptoQuotes/reference/write_xts.md)
  reads and stores `xts`-objects. These functions are essentially just
  wrappers of
  [`zoo::read.zoo()`](https://rdrr.io/pkg/zoo/man/read.zoo.html) and
  [`zoo::write.zoo()`](https://rdrr.io/pkg/zoo/man/read.zoo.html). Thank
  you [@gokberkcan7](https://github.com/gokberkcan7) for the suggestion.

#### Charting

- The
  [`chart()`](https://serkor1.github.io/cryptoQuotes/reference/chart.md)-function
  are now exported as `.svg`-images in 4k resolution via the `modebar`.
- The
  [`chart()`](https://serkor1.github.io/cryptoQuotes/reference/chart.md)-function
  are now more interactive and supports drawing lines and rectangles via
  the `modebar`. It is also possible to interactively change the `title`
  and `subtitle` by double clicking these (Thank you
  [@andreltr](https://github.com/andreltr) for the suggestion. See
  [Discussion](https://github.com/serkor1/cryptoQuotes/discussions/19)).
- The
  [`chart()`](https://serkor1.github.io/cryptoQuotes/reference/chart.md)-function
  now has a new option `static` that is equal to `FALSE` by default. If
  `FALSE` the chart can be edited, annotated and explored interactively.
- The
  [`chart()`](https://serkor1.github.io/cryptoQuotes/reference/chart.md)-function
  now has a new option `palette` that is set to “hawaii” by default. See
  [`hcl.pals()`](https://rdrr.io/r/grDevices/palettes.html) for accepted
  values.
- The
  [`chart()`](https://serkor1.github.io/cryptoQuotes/reference/chart.md)-function
  now has a new option `scale` that is set to 1 by default. Scales all
  fonts on the chart.
- The
  [`chart()`](https://serkor1.github.io/cryptoQuotes/reference/chart.md)-function
  now has a new option `width` that is set to 0.9 by default. Sets the
  overall `linewidth` of the chart. (Thank you
  [@andreltr](https://github.com/andreltr) for the suggestion. See
  [Discussion](https://github.com/serkor1/cryptoQuotes/discussions/30))

Static set to FALSE (Default Palette)

``` r
# static = FALSE
chart(
  ticker  = BTC,
  main    = kline(),
    indicator = line(
    sma(n = 7),
    sma(n = 14),
    sma(n = 21)
  ),
  options = list(
    static = FALSE,
    palette = "hawaii"
  ) 
)
```

![](reference/figures/NEWS-unnamed-chunk-3-1.png)

Static set to TRUE (“Set 3” palette)

``` r
# static = TRUE
chart(
  ticker  = BTC,
  main    = kline(),
  indicator = line(
    sma(n = 7),
    sma(n = 14),
    sma(n = 21)
  ),
  options = list(
    static  = TRUE,
    palette = "Set 3"
  ) 
)
```

![](reference/figures/NEWS-unnamed-chunk-4-1.png)

#### Supported Exchanges (Issue [\#14](https://github.com/serkor1/cryptoQuotes/issues/14))

[{cryptoQuotes}](https://serkor1.github.io/cryptoQuotes/) now supports
the following exchanges:

- Crypto.com
- Huobi
- MEXC

### Breaking Changes

### Bugfixes

#### Charting

- Fixed a bug in the
  [`chart()`](https://serkor1.github.io/cryptoQuotes/reference/chart.md)-function
  where a warning would be given if called using namespace qualified
  function calls (Issue
  [\#13](https://github.com/serkor1/cryptoQuotes/issues/13))
- Fixed a bug in the
  [`chart()`](https://serkor1.github.io/cryptoQuotes/reference/chart.md)-function
  where a `legend` wouldn’t show unless a main-chart indicator were
  included. (Issue
  [\#13](https://github.com/serkor1/cryptoQuotes/issues/13))

#### Quotes

- Removed `1s` from *Binance spot*
- Removed `3m`, `6h` and `3d` in *Bitmart spot*

These intervals have been removed as they have either been discontinued,
or were non-existent.

## Version 1.3.1

CRAN release: 2024-05-31

### General

> **NOTE:** With this update the package is no longer considered
> `experimental`.

- Removed deprecated functions `getQuote()`-, `getFGIndex()`- and
  `getLSRatio()`-functions.

- Removed decprecated functions `availableExchanges()`-,
  `availableIntervals()`- and `availableTickers()`-functions.

These functions were planned to be deleted in `1.4.0` - however, we have
decided to aim for an `JOSS`- and `rOpenSci`-subscription which requires
some degree of stability. Hence the deletion of these function at
`1.3.0`.

We expect `1.4.0` to be released *after* `rOpenSci`-submission and
acceptance 🙏

### Improvements

#### New features

- [`smi()`](https://serkor1.github.io/cryptoQuotes/reference/smi.md)-function,
  a `subchart`-indicator built on the
  [`TTR::SMI()`](https://rdrr.io/pkg/TTR/man/stochastics.html)-function.
- [`donchian_channel()`](https://serkor1.github.io/cryptoQuotes/reference/donchian_channel.md)-function,
  a `main chart`-indicator built on the
  [`TTR::DonchianChannel()`](https://rdrr.io/pkg/TTR/man/DonchianChannel.html)-function

Usage

``` r
chart(
  ticker = BTC,
  main   = kline(),
  indicator = list(
    donchian_channel()
  ),
  sub = list(
    smi()
  )
)
```

![](reference/figures/NEWS-unnamed-chunk-5-1.png)

#### Expanded Support

- [`get_openinterest()`](https://serkor1.github.io/cryptoQuotes/reference/get_openinterest.md)
  is now supported by `kraken`

Usage

``` r
tail(
  get_openinterest(
    ticker   = "PF_XBTUSD",
    interval = "1h",
    source   = "kraken"
  )
)
```

``` R
#>                     open_interest
#> 2026-02-06 18:00:00      1804.811
#> 2026-02-06 19:00:00      1720.164
#> 2026-02-06 20:00:00      1704.200
#> 2026-02-06 21:00:00      1717.264
#> 2026-02-06 22:00:00      1697.977
#> 2026-02-06 23:00:00      1693.890
```

#### Charting

- The
  [`chart()`](https://serkor1.github.io/cryptoQuotes/reference/chart.md)-function
  now has proper `light`-theme available that isn’t the default
  `plotly`-values.
- The charts now displays date ranges as a subtitles.
- The
  [`bollinger_bands()`](https://serkor1.github.io/cryptoQuotes/reference/bollinger_bands.md)-function
  now accepts a `color`-argument. These can be passed as
  `Hexadecimal`-colors or as is, `"blue"` for example.
- A new main chart function has been introduced.
  [`pline()`](https://serkor1.github.io/cryptoQuotes/reference/pline.md)
  which is a univariate price chart based on either open, high, low or
  close prices.

Usage

``` r
chart(
  ticker = BTC,
  main   = pline(price = "close"),
  indicator = list(
    bollinger_bands(
    color = "steelblue"
  )
  ),
  sub = list(
    volume()
  ),
  options = list(
    dark = FALSE
  )
)
```

![](reference/figures/NEWS-unnamed-chunk-7-1.png)

#### Documentation

- The documentation has been extensively reworked. This is includes, but
  not limited to, sample outputs for all `get_*`-functions.

#### Backend Changes

- The
  [`chart()`](https://serkor1.github.io/cryptoQuotes/reference/chart.md)-functions
  no longer depend on `rlang`.

> **Note:** we are generally moving away from `rlang`, `purrr` and
> `tidyverse` in general. We are, however, keeping the `tidyverse`
> styleguide.

- Removed dependency on `conflicted`-package.

Prior to version `1.3.0` the `get*`-functions were following the syntax
of [{quantmod}](https://github.com/joshuaulrich/quantmod) closely, and
this goes for the function naming too. With the adoption of the
`tidyverse` style guide, there is no conflicts that needs to be resolved
on `stable`- and `experimental`-functions.

#### New developper tools

- `pull()`-function
- `var_ly()`-function
- `build()`-function

### Breaking Changes

- The
  [`get_fgindex()`](https://serkor1.github.io/cryptoQuotes/reference/get_fgindex.md)-function
  now returns columns in lower case.

### Bugfixes

- Fixed a bug where
  [`get_fgindex()`](https://serkor1.github.io/cryptoQuotes/reference/get_fgindex.md)
  where labelled as `deprecated`
- Fixed a bug in the `limitations`-article where the desired number of
  observations werent compatible with the `kraken`-exchange.
- Fixed a warning in the
  [`get_lsratio()`](https://serkor1.github.io/cryptoQuotes/reference/get_lsratio.md)-function
  with `source = "binance"`
- Fixed a bug in the
  [`lsr()`](https://serkor1.github.io/cryptoQuotes/reference/lsr.md)-indicator
  which broke the
  [`chart()`](https://serkor1.github.io/cryptoQuotes/reference/chart.md)-function
  when included.
- Fixed a bug in the
  [`get_quote()`](https://serkor1.github.io/cryptoQuotes/reference/get_quote.md)-function
  where if `to = NULL` and `from != NULL` the returned `quote` would be
  filtered according to `UTC` and not
  [`Sys.timezone()`](https://rdrr.io/r/base/timezones.html)
- Fixed a bug in the
  [`chart()`](https://serkor1.github.io/cryptoQuotes/reference/chart.md)-function
  where the inferred intervals would be incorrect for leap years, and
  months different from 30 days.

## Version 1.3.0

CRAN release: 2024-03-12

### Improvements

#### General function improvements

- `get_lsratio` and `getLSratio()` supports `kraken` and `bybit` as
  `source`

- `available_`-functions are more adaptive to the calling environments

``` r
## charting the klines
## with indicators as
## subcharts
available_exchanges(type = 'ohlc')
```

Now returns all available exhanges that supports Open, High, Low and
Close market data. The `type`-argument can be changed to, for example,
`lsratio` to get all available exchanges that supports Long to Shorts
ratios. Similar changes have been made to remaining
`available_`-functions.

#### Error-handling

All `get_*`- and `available_*`-functions are now more robust to API and
input errors.

#### Default Returning

- `quotes` and `fear and greed index` now returns `200` rows instead of
  `100`

#### Charting

- The `charts` now has a `dark` and `light` theme. Its passed into the
  `options = list(dark = TRUE)` of the
  [`chart()`](https://serkor1.github.io/cryptoQuotes/reference/chart.md)-function.
- The `charts` are now more color deficiency compliant, and the
  `deficiency` parameter in `options = list(deficiency = TRUE)` now
  applies to all `chart`-elements
- The `charts` are now constructed without `%>%` and, should, be more
  intuitive to navigate in. See example below,

``` r
## charting the klines
## with indicators as
## subcharts
chart(
  ticker     = BTC,
  main       = kline(),
  sub        = list(
    volume()
  ),
  indicator = list(
    bollinger_bands(),
    sma(),
    alma()
  ),
  options = list(
    dark       = TRUE,
    deficiency = FALSE
  )
)
```

![](reference/figures/NEWS-unnamed-chunk-8-1.png)

#### Exchange Support

The following exchanges have been added to list of `exchanges`
available,

- ByBit

#### New features

- Funding rates,
  [`get_fundingrate()`](https://serkor1.github.io/cryptoQuotes/reference/get_fundingrate.md)

Usage

``` r
## get funding rate
tail(
  get_fundingrate(
    ticker = "BTCUSDT",
    source = "binance"
  )
)
```

``` R
#>                     funding_rate
#> 2026-02-05 01:00:00   0.00009173
#> 2026-02-05 09:00:00   0.00000298
#> 2026-02-05 17:00:00  -0.00004957
#> 2026-02-06 01:00:00  -0.00001597
#> 2026-02-06 09:00:00  -0.00013688
#> 2026-02-06 17:00:00  -0.00013478
```

- Open interest,
  [`get_openinterest()`](https://serkor1.github.io/cryptoQuotes/reference/get_openinterest.md)

Usage

``` r
## get funding rate
tail(
  get_openinterest(
    ticker = "BTCUSDT",
    source = "binance"
  )
)
```

``` R
#>      open_interest
```

### Breaking Changes

#### Charting

- All the `charting`-functions have been reworked without backwards
  compatibility, or
  [`lifecycle::deprecated()`](https://lifecycle.r-lib.org/reference/deprecated.html)-warnings.
  The `charting`-functions were, and still is, in an
  `experimental`-stage.

#### API Calls

- All `dates` passed to `get_*`-functions assumed the dates were given
  in `UTC`, and were retrieved as `UTC`. These have now been changed;
  all functions now uses
  [`Sys.timezone()`](https://rdrr.io/r/base/timezones.html) as `default`
  upon request and retrieval.

### Warning

As [{cryptoQuotes}](https://serkor1.github.io/cryptoQuotes/) has moved
to the `tidyverse` style guide, the `getFoo`-functions are now
`deprecated`. These will be permanently deleted, and removed from the
[{cryptoQuotes}](https://serkor1.github.io/cryptoQuotes/), at version
1.4.0!

## Version 1.2.1

CRAN release: 2024-01-08

#### Minor Updates

- Added DOGECOIN data. This data is extracted on the `1m` chart, around
  Elon Musks Tweet.
- Added a usecase in the Vignette about Dogecoin and Elon Musk to
  showcase the functionality of the library.

#### Bugfixes

- Corrected misspelled ticker in Vignette
- All returned Quotes are now in `UTC`, again.
- Fixed an error on the `Bitmart` API where weekly candles would throw
  an error.

## Version 1.2.0

- All `from` and `to` arguments are now more flexible, and supports
  passing [`Sys.Date()`](https://rdrr.io/r/base/Sys.time.html) and
  [`Sys.time()`](https://rdrr.io/r/base/Sys.time.html) directly into the
  `get`-functions.

- `getQuote()` now returns up to 100 pips preceding the specified `to`
  date, when `from = NULL`. It returns 100 pips, or up to
  [`Sys.Date()`](https://rdrr.io/r/base/Sys.time.html), from the
  specified `from` date.

The `getQuote()`-function can now be used as follows;

``` r
## Specifying from
## date only;
##
## Returns 10 pips
getQuote(
 ticker   = 'BTCUSDT',
 interval = '1d'
 from     = as.character(Sys.Date() - 10)
 )
```

``` r
## Specifying to
## date only;
##
## Returns 100 pips
getQuote(
 ticker   = 'BTCUSDT',
 interval = '1d'
 to     = as.character(Sys.Date())
 )
```

### Market Sentiment

Four new functions are added,

- `getFGIndex()` which returns the daily Fear and Greed Index.
- `addFGIndex()` which adds the Fear and Greed Index as a subplot to
  price charts.
- `getLSRatio()` which returns the long-short ratio with varying
  granularity. Contributor has been credited.
- `addLSRatio()` which adds the long-short ratio as a subplot to price
  charts.

### Convinience functions added

Three new convinience functions are added applicable to some situations,

- `removeBound()`
- `splitWindow()`
- `calibrateWindow()`

## Version 1.1.0

### Frontend

`getQuote()` now returns up to 100 pips when `to` and `from` is `NULL`

### Backend

- All code has been rewritten so its compatible with
  [{httr2}](https://github.com/r-lib/httr2), the package used
  [{httr}](https://github.com/r-lib/httr) at version `1.0.0`.

### Future releases

In the next release, three more exchanges will be supported.

### Known bugs

The returned `quotes` are in local timezone, this is an unintentional
feature and will be fixed in a bugfix.

## Version 1.0.0

CRAN release: 2023-12-13

- Initial CRAN submission 🚀
