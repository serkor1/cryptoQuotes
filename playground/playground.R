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
  main   = ohlc(),
  indicator = list(
    sma(n = 10),
    sma(n = 15)
  ),
  options = list(
    deficiency = FALSE
  )
)



# script end;
