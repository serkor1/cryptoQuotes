# cryptoQuotes 1.3.1

## Improvements

### Charting

* The `chart()`-function now has proper `light`-theme available that isnt the default `plotly`-values.
* The charts now displays date ranges as a subtitles.
* The `bollinger_bands()`-function now accepts a `color`-argument. These can be passed as `Hexadecimal`-colors or as is, `"blue"` for example.


### Backend Changes

* The `chart()`-functions no longer depend on `rlang`. 

> **Note:** we are generally moving away from `rlang`, `purrr` and `tidyverse` in general. We are, however, 
> keeping the `tidyverse` styleguide.

### New developper tools

* `pull()`-function
* `var_ly()`-function
* `build()`-function


## Bugfixes

# cryptoQuotes 1.3.0

## Improvements

### General function improvements

* `get_lsratio` and `getLSratio()` supports `kraken` and `bybit` as `source`

* `available_`-functions are more adaptive to the callling environments

```R
## charting the klines
## with indicators as
## subcharts
available_exchanges(type = 'ohlc')
```

Now returns all available exhanges that supports Open, High, Low and Close market data. The `type`-argument can be changed to, for example, `lsratio` to get
all available exchanges that supports Long to Shorts ratios. Similar changes have been made to remaining `available_`-functions.

### Error-handling

All `get_*`- and `available_*`-functions are now more robust to API and input errors.

### Default Returning

* `quotes` and `fear and greed index` now returns `200` rows instead of `100`

### Charting

* The `charts` now has a `dark` and `light` theme. Its passed into the `options = list(dark = TRUE)` of the `chart()`-function.
* The `charts` are now more color deficiency compliant, and the `deficiency` parameter in `options = list(deficiency = TRUE)` now applies to all `chart`-elements
* The `charts` are now constructed without `%>%` and, should, be more intuitive to navigate in. See example below,

```R
## charting the klines
## with indicators as
## subcharts
chart(
  ticker     = BTCUSDT,
  main       = kline(),
  sub        = list(
    volume(),
    macd()
  ),
  indicator = list(
    bollinger_bands(),
    sma(),
    alma()
  ),
  options = list(
    dark = TRUE,
    deficiency = FALSE
  )
)
```

### Exchange Support

The following exchanges have been added to list of `exchanges` available,

* ByBit

### New features

* Funding rates

```R
## get funding rate
get_fundingrate(
    ticker = "BTCUSDT",
    source = "binance"
  )
```

* Open interest

```R
## get open interest
get_openinterest(
      ticker = "BTCUSDT",
      source = "binance"
    )
```


## Breaking Changes

### Charting

* All the `charting`-functions have been reworked without backwards compatibility, or `lifecycle::deprecated()`-warnings. The `charting`-functions were, and still is, in an `experimental`-stage.

### API Calls

* All `dates` passed to `get_*`-functions assumed the dates were given in `UTC`, and were retrieved as `UTC`. These have now been changed; all functions now uses `Sys.timezone()` as `default` upon request and retrieval.

## Warning

As the `cryptoQuotes`-package has moved to the `tidyverse` style guide, the `getFoo`-functions are now `deprecated`. These will be permanently deleted, and removed from the `cryptoQuotes`-package, at version 1.4.0!


# cryptoQuotes 1.2.1

### Minor Updates

* Added DOGECOIN data. This data is extracted on the `1m` chart, around Elon Musks Tweet.
* Added a usecase in the Vignette about Dogecoin and Elon Musk to showcase the functionality of the library.

### Bugfixes

* Corrected misspelled ticker in Vignette 
* All returned Quotes are now in `UTC`, again.
* Fixed an error on the `Bitmart` API where weekly candles would throw an error.

# cryptoQuotes 1.2.0

* All `from` and `to` arguments are now more flexible, and supports passing `Sys.Date()` and `Sys.time()` directly into the `get`-functions.

* `getQuote()` now returns up to 100 pips preceding the specified `to` date, when `from = NULL`. It returns 100 pips, or up to `Sys.Date()`, from the specified `from` date.

The `getQuote()`-function can now be used as follows;

```
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

```
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

## Market Sentiment

Four new functions are added,

* `getFGIndex()` which returns the daily Fear and Greed Index.
* `addFGIndex()` which adds the Fear and Greed Index as a subplot to price charts.
* `getLSRatio()` which returns the long-short ratio with varying granularity. Contributor has been credited.
* `addLSRatio()` which adds the long-short ratio as a subplot to price charts.

## Convinience functions added

Three new convinience functions are added applicable to some situations,

* `removeBound()`
* `splitWindow()`
* `calibrateWindow()`

# cryptoQuotes 1.1.0

## Frontend

`getQuote()` now returns up to 100 pips when `to` and `from` is `NULL`

## Backend

* All code has been rewritten so its compatible with `httr2`, the package used `httr` at version `1.0.0`.

## Future releases

In the next release, three more exchanges will be supported. 

## Known bugs

The returned `quotes` are in local timezone, this is an unintentional feature and will be fixed in a bugfix.


# cryptoQuotes 1.0.0

* Initial CRAN submission.
