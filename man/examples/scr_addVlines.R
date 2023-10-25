# script: scr_addVlines
# date: 2023-10-25
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Describe the usage
# of addVlines
# script start;

# laod library
library(cryptoQuotes)

# 1) add random a random
# buy date to plot
ATOMUSDT$buy <- sample(
  c(1, rep(0, nrow(ATOMUSDT) - 1))
)

# 2) subset and
# chart
chart(
  chart = kline(
    ATOMUSDT
  ) %>% addVlines(
    subset(
      ATOMUSDT,
      buy == 1
    )
  )
)

# script end;
