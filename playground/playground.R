# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup;
rm(list = ls()); gc(); devtools::load_all()

chart(
  ticker = BTC,
  main   = kline(),
  indicator = list(
    sma()
  ),
  sub    = list(
    volume(),
    macd()
  ),
  options = list(
    dark    = TRUE,
    size = 0.7,
    modebar = FALSE,
    slider = TRUE,
    static = FALSE,
    scale = 1
  )
)

get_quote(
  ticker = "BTCUSD-PERP",
  source = "crypto.com"
)

get_quote(
  ticker = sample(available_tickers("kraken"), size = 1),
  source = "kraken"
)

get_quote(
  ticker = sample(available_tickers("mexc"), size = 1),
  source = "mexc"
)

get_quote(
  ticker = "ICP-USDT",
  source = "huobi"
)

get_quote(
  ticker = sample(available_tickers("kucoin"), size = 1),
  source = "kucoin"
)


get_quote(
  ticker = "BTCUSDT",
  source = "mexc",
  futures = FALSE,
  interval = "1d"
)


get_quote(
  ticker = "BTCUSDT",
  source = "mexc",
  futures = FALSE,
  interval = "15m"
)


get_quote(
  ticker = "BTC_USDT",
  source = "mexc",
  futures = TRUE,
  interval = "1d"
)

get_quote(
  ticker = "BTC_USDT",
  source = "mexc",
  futures = TRUE,
  interval = "15m"
)


available_exchanges()

available_tickers(
  "crypto.com",futures = FALSE
)


"hawii" %in% hcl.pals()


grDevices::palette.colors(
  n = 20,
  palette = c("R4", "Okabe-ito"),
  recycle = TRUE
)

length(unique(hcl.colors(200,palette = "hawaii")))




output <- get_quote("BTC_USDT", source = "bitmart", futures = FALSE, interval = "1h")


output[!output$open >= output$low]

# Error on Bitmart hourly
#                         open     high   low    close   volume
# 2024-06-23 08:00:00 64379.98 64413.59 64380 64386.48 121228.1



# script end;



library(plotly)
library(magrittr)

df <- data.frame(Date = seq(as.Date("2016-01-01"), as.Date("2016-08-31"), by="days"),
                 Value = sample(100:200, size = 244, replace = T))

p <- plot_ly(data = df, x = ~Date, y = ~Value, type = "scatter") %>%
  layout(xaxis = list(rangeslider = list(type = "date", traces = FALSE, thickness = 0.1)  ))
p
