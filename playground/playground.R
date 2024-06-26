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
    sma(n = 11),
    sma(n = 12),
    sma(n = 13),
    sma(n = 14),
    sma(n = 15),
    sma(n = 16),
    sma(n = 17),
    sma(n = 18),
    sma(n = 19),
    sma(n = 20),
    sma(n = 21),
    sma(n = 22),
    sma(n = 23)
  ),
  sub    = list(
    volume()
  ),
  options = list(
    dark    = FALSE
  )
)



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
