# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup;
rm(list = ls()); gc(); devtools::load_all()


# 1) SPY
# SPY <- quantmod::getSymbols(
#   "SPY",
#   auto.assign = FALSE
# )
custom_indicator <- function(
    FUN = TTR::DonchianChannel
) {

}


chart(
  ticker = BTC,
  main   = line(price = "close"),
  indicator = list(
    bollinger_bands(color = "steelblue")
  ),
  sub = list(
    volume()
  ),
  options = list(
    dark = TRUE,
    slider = TRUE
  )
)

# script end;
