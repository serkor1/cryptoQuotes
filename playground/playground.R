# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup;
rm(list = ls()); gc(); devtools::load_all()


get_quote(
  ticker = "BTC_USDT",
  source = "mexc",
  interval = "1h"
)


get_quote(
  ticker = "BTCUSDT",
  source = "mexc",
  interval = "1h",
  futures = FALSE
)
sapply(
  X = available_intervals(
    source = "mexc",
    futures = TRUE
  ),
  FUN = function(x) {

    Sys.sleep(2)

    tryCatch(
      {
        get_quote(
          ticker   = "BTC_USDT",
          interval = x,
          source   = "mexc",
          futures  = TRUE
        )

        paste("OK in", x)
      }

      ,
      error = function(error_msg) {

        paste("Error in", x)

      },
      finally = "sd"
    )

  }
)
#>            1m            5m           15m           30m            1h
#> "Error in 1m"    "OK in 5m"   "OK in 15m"   "OK in 30m"    "OK in 1h"
#>            4h            8h            1d            1w            1M
#>    "OK in 4h"    "OK in 8h"    "OK in 1d"    "OK in 1w" "Error in 1M"


sapply(
  X = available_intervals(
    source = "mexc",
    futures = FALSE
  ),
  FUN = function(x) {

    Sys.sleep(2)

    tryCatch(
      {
        get_quote(
          ticker   = "BTCUSDT",
          interval = x,
          source   = "mexc",
          futures  = FALSE
        )

        paste("OK in", x)
      }

      ,
      error = function(error_msg) {

        paste("Error in", x)

      }
    )

  }
)

#>            1m            5m           15m           30m            1h
#> "Error in 1m"    "OK in 5m"   "OK in 15m"   "OK in 30m" "Error in 1h"
#>            4h            1d            1w            1M
#>    "OK in 4h"    "OK in 1d" "Error in 1w" "Error in 1M"




test <- get_quote("XBTUSDT", "kraken", FALSE, "2w")



index <- zoo::index(
  utils::head(
    x = test,
    # n should be the minimum
    # of available rows and 7. 7
    # was chosen randomly, but its important
    # that its odd numbered so consensus can be
    # reached. This application is 20x faster
    # than using the entire dataset
    # and reaches the same conclusion
    n = min(nrow(test), 7)
  )
)

# 1) calculate
# differences
x <- as.numeric(
  difftime(
    time1 = index[-1],
    time2 = index[-length(index)],
    units = "secs"
  )
)

x <- find_mode(x)


infer_interval(test)
x
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

system.time(
  get_quote(
    ticker = "BTCUSD-PERP",
    source = "crypto.com"
  )
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
