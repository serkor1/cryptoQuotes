# Usecase

``` r
library(cryptoQuotes)
```

## Introduction

This high-level `API`-client provides open access to cryptocurrency
market data without relying on low-level coding and `API`-keys.
Currently all actively traded cryptocurrencies on 1 major exchanges are
available, see the
[wiki](https://github.com/serkor1/cryptoQuotes/wiki/Available-Exchanges)
for more details.

In this vignette we will explore a case study to showcase the
capabilities of
[{cryptoQuotes}](https://github.com/serkor1/cryptoQuotes); how did the
`Dogecoin`-market react to Elon Musks following tweet,

![Tweet by Elon Musk - the timezone is CET.](elonTweet.png)

Tweet by Elon Musk - the timezone is CET.

## Cryptocurrency Market Analysis in R

Elon Musk tweeted (Well, now he X’ed) about `Dogecoin` January 14, 06.18
AM (UTC) - and `Dogecoin` rallied. To determine how fast the markets
reacted to his tweets, we could get the market data for Dogecoin in 1
minute intervals the day he tweeeted using the `get_quotes()`-function,

``` r
## DOGEUSDT the day
## of the tweet on the
## 1m chart
DOGE <- cryptoQuotes::get_quote(
  ticker   = 'DOGE-USDT',
  interval = '1m',
  source   = 'kucoin',
  futures  = FALSE,
  from     = '2022-01-14 07:00:00',
  to       = '2022-01-14 08:00:00'
)
```

This returns an object of class xts and zoo with 61 rows. To calculate
the rally within the first minute of the tweet, we can use
[{xts}](https://github.com/joshuaulrich/xts)-syntax to determine its
magnitude,

``` r
## extrat the
## tweet moment
tweet_moment <- DOGE["2022-01-14 07:18:00"]

## calculate 
## rally
cat(
  "Doge closed:", round((tweet_moment$close/tweet_moment$open - 1),4) * 100, "%"
)
```

    #> Doge closed: 8.71 %

`Dogecoin` rallied 8.71% within the minute Elon Musk tweeted.

### Charting price action with candlesticks

We can visualize the rally this with candlestick charts using the
[`chart()`](https://serkor1.github.io/cryptoQuotes/reference/chart.md)-
and
[`kline()`](https://serkor1.github.io/cryptoQuotes/reference/kline.md)-function,

``` r
## chart the
## price action
## using klines
cryptoQuotes::chart(
  ticker     = DOGE,
  main       = cryptoQuotes::kline(),
  indicator  = list(
    cryptoQuotes::bollinger_bands()
  ),
  sub  = list(
    cryptoQuotes::volume()
  ),
  options = list(
    dark = FALSE
  )
)
```

### Charting price action with event lines

To create a, presumably, better visual overview we can add event lines
using the `event_data`-argument, which takes a `data.frame` of any kind
as argument,

``` r
## 1) create event data.frame
## by subsetting the data
event_data <- as.data.frame(
  zoo::coredata(
    DOGE["2022-01-14 07:18:00"]
  )
)

## 1.1) add the index 
## to the event_data
event_data$index <- zoo::index(
  DOGE["2022-01-14 07:18:00"]
)

# 1.2) add event label
# to the data
event_data$event <- 'Elon Musk Tweets'

# 1.3) add color to the
# event label
event_data$color <- 'steelblue'
```

This event data, can be passed into the chart as follows,

``` r
## 1) chart the
## price action
## using klines
cryptoQuotes::chart(
  ticker     = DOGE,
  event_data = event_data,
  main       = cryptoQuotes::kline(),
  indicator  = list(
    cryptoQuotes::bollinger_bands()
  ),
  sub = list(
    cryptoQuotes::volume()
  ),
  options = list(
    dark = FALSE
  )
)
```
