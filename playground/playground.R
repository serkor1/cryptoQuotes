# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup
rm(list = ls()); gc(); devtools::load_all()




chart(
  ticker = BTC,
  main = ohlc(),
  indicator = list(
    sma(),
    ema(),
    bollinger_bands()
  ),
  sub = list(
    rsi(),
    macd()
  )
)


# Example OHLC prices
Open <- 100
High <- 105
Low <- 95
Close <- 102

# Check the logical conditions
is_valid <- High >= max(Open, Close) && Low <= min(Open, Close) &&
  High >= Low &&
  all(c(Open, High, Low, Close) >= 0)

# Print the result
if (is_valid) {
  print("OHLC prices are logically correct.")
} else {
  print("OHLC prices have a logical inconsistency.")
}

# script end;

