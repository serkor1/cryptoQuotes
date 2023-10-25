# script: scr_charting
# date: 2023-10-25
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Charting in general
# script start;

# library
library(cryptoQuotes)

# charting klines
# with various indicators
chart(
  chart = kline(
    ATOMUSDT
  ) %>% addVolume() %>% addMA(
    FUN = TTR::SMA,
    n = 7
  ) %>% addMA(
    FUN = TTR::SMA,
    n = 14
  ) %>%
    addBBands() %>%
    addMACD() %>%
    addRSI()

)


# script end;
