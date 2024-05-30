# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup;
rm(list = ls()); gc(); devtools::load_all()

ticker <- cryptoQuotes:::control_data$quote

chart(
  ticker = ticker,
  main   = kline(),
  indicator = list(
    bollinger_bands(),
    donchian_channel(color = "red"),
    sma(n = 10),
    sma(n = 15),
    sma(n = 14)
  ),
  sub = list(
    smi(),
    rsi()
  ),
  options = list(
    deficiency = FALSE
  )
)


# script end;
