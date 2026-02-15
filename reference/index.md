# Package index

## Cryptocurrency Market Data

The collection of functions to retrieve OHLC-V and sentiment data.

- [`get_fgindex()`](https://serkor1.github.io/cryptoQuotes/reference/get_fgindex.md)
  **\[stable\]** : Get the daily Fear and Greed Index in the
  cryptocurrency market
- [`get_fundingrate()`](https://serkor1.github.io/cryptoQuotes/reference/get_fundingrate.md)
  **\[stable\]** : Get the funding rate on futures contracts
- [`get_lsratio()`](https://serkor1.github.io/cryptoQuotes/reference/get_lsratio.md)
  **\[stable\]** : Get the long to short ratio of a cryptocurrency pair
- [`get_mktcap()`](https://serkor1.github.io/cryptoQuotes/reference/get_mktcap.md)
  : Get the global market capitalization
- [`get_openinterest()`](https://serkor1.github.io/cryptoQuotes/reference/get_openinterest.md)
  **\[stable\]** : Get the open interest on perpetual futures contracts
- [`get_quote()`](https://serkor1.github.io/cryptoQuotes/reference/get_quote.md)
  **\[stable\]** : Get the Open, High, Low, Close and Volume data on a
  cryptocurrency pair

## Supported Calls

The collection of functions to list available argument values in the
`interval`-, `source`- and `interval`-arguments.

- [`available_exchanges()`](https://serkor1.github.io/cryptoQuotes/reference/available_exchanges.md)
  **\[stable\]** : Get available exchanges
- [`available_intervals()`](https://serkor1.github.io/cryptoQuotes/reference/available_intervals.md)
  **\[stable\]** : Get available intervals
- [`available_tickers()`](https://serkor1.github.io/cryptoQuotes/reference/available_tickers.md)
  **\[stable\]** : Get actively traded cryptocurrency pairs

## Charting

The collection of `chart`-functions are split 3; main charts (price
chart), main chart indicators and subchart indicators. All `charts` are
initialised using the `chart`-function.

- [`chart()`](https://serkor1.github.io/cryptoQuotes/reference/chart.md)
  **\[experimental\]** : Build an interactive financial chart

### Main Charts

The collection of main chart functions for charting prices.

- [`kline()`](https://serkor1.github.io/cryptoQuotes/reference/kline.md)
  **\[experimental\]** : Candlestick Chart
- [`ohlc()`](https://serkor1.github.io/cryptoQuotes/reference/ohlc.md)
  **\[experimental\]** : OHLC Barchart
- [`pline()`](https://serkor1.github.io/cryptoQuotes/reference/pline.md)
  **\[experimental\]** : Line Chart

### Main Chart Indicators

The collection of main chart indicators which are overlaid the main
chart.

- [`alma()`](https://serkor1.github.io/cryptoQuotes/reference/alma.md)
  **\[experimental\]** : Add Arnaud Legoux Moving Average (ALMA) to the
  chart
- [`bollinger_bands()`](https://serkor1.github.io/cryptoQuotes/reference/bollinger_bands.md)
  **\[experimental\]** : Add Bollinger Bands to the chart
- [`dema()`](https://serkor1.github.io/cryptoQuotes/reference/dema.md)
  **\[experimental\]** : Add Double Exponential Moving Average (DEMA) to
  the chart
- [`donchian_channel()`](https://serkor1.github.io/cryptoQuotes/reference/donchian_channel.md)
  **\[experimental\]** : Add Donchian Channels to the chart
- [`ema()`](https://serkor1.github.io/cryptoQuotes/reference/ema.md)
  **\[experimental\]** : Add Exponentially-Weighted Moving Average (EMA)
  to the chart
- [`evwma()`](https://serkor1.github.io/cryptoQuotes/reference/evwma.md)
  **\[experimental\]** : Add Elastic Volume-Weighted Moving Average
  (EVWMA) to the chart
- [`hma()`](https://serkor1.github.io/cryptoQuotes/reference/hma.md)
  **\[experimental\]** : Add Hull Moving Average (HMA) to the chart
- [`sma()`](https://serkor1.github.io/cryptoQuotes/reference/sma.md)
  **\[experimental\]** : Add Simple Moving Average (SMA) indicators to
  the chart
- [`vwap()`](https://serkor1.github.io/cryptoQuotes/reference/vwap.md)
  **\[experimental\]** : Add Volume-Weighted Moving Average (VWAP) to
  the chart
- [`wma()`](https://serkor1.github.io/cryptoQuotes/reference/wma.md)
  **\[experimental\]** : Add Weighted Moving Average (WMA) to the chart
- [`zlema()`](https://serkor1.github.io/cryptoQuotes/reference/zlema.md)
  **\[experimental\]** : Add Zero Lag Exponential Moving Average (ZLEMA)
  to the chart

### Subchart Indicators

The collection of subchart indicators which are charted as a subchart.

- [`fgi()`](https://serkor1.github.io/cryptoQuotes/reference/fgi.md)
  **\[experimental\]** : Chart the Fear and Greed Index
- [`lsr()`](https://serkor1.github.io/cryptoQuotes/reference/lsr.md)
  **\[experimental\]** : Chart the long-short ratio
- [`macd()`](https://serkor1.github.io/cryptoQuotes/reference/macd.md)
  **\[experimental\]** : Chart the Moving Average Convergence Divergence
  (MACD) indicator
- [`rsi()`](https://serkor1.github.io/cryptoQuotes/reference/rsi.md)
  **\[experimental\]** : Chart the Relative Strength Index (RSI)
- [`smi()`](https://serkor1.github.io/cryptoQuotes/reference/smi.md)
  **\[experimental\]** : Chart the Stochastic Momentum Index (SMI)
- [`volume()`](https://serkor1.github.io/cryptoQuotes/reference/volume.md)
  **\[experimental\]** : Chart the trading volume

## Utilities

Manipulate and calibrate objects

- [`calibrate_window()`](https://serkor1.github.io/cryptoQuotes/reference/calibrate_window.md)
  **\[experimental\]** : calibrate the time window of a list of xts
  objects

- [`remove_bound()`](https://serkor1.github.io/cryptoQuotes/reference/remove_bound.md)
  **\[experimental\]** : remove upper and lower bounds from an XTS
  object

- [`split_window()`](https://serkor1.github.io/cryptoQuotes/reference/split_window.md)
  **\[experimental\]** : split xts object iteratively in lists of
  desired intervals

- [`write_xts()`](https://serkor1.github.io/cryptoQuotes/reference/write_xts.md)
  [`read_xts()`](https://serkor1.github.io/cryptoQuotes/reference/write_xts.md)
  **\[experimental\]** :

  Read and Write `xts`-objects

## Datasets

Sample datasets returned by
[`get_quote()`](https://serkor1.github.io/cryptoQuotes/reference/get_quote.md)
and
[`get_fgindex()`](https://serkor1.github.io/cryptoQuotes/reference/get_fgindex.md)

- [`ATOM`](https://serkor1.github.io/cryptoQuotes/reference/ATOM.md) :
  USDT Denominated ATOM (ATOMUSDT) 15-Minute Intervals
- [`BTC`](https://serkor1.github.io/cryptoQuotes/reference/BTC.md) :
  USDT Denominated Bitcoin (BTCUSDT) Weekly Intervals
- [`DOGE`](https://serkor1.github.io/cryptoQuotes/reference/DOGE.md) :
  USDT Denominated DOGECOIN (DOGEUSDT) 1-Minute Intervals
- [`FGIndex`](https://serkor1.github.io/cryptoQuotes/reference/FGIndex.md)
  : Fear and Greed Index (FGI) values for the cryptocurrency market in
  daily intervals
