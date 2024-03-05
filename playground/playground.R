# script: playground
# date: 2024-02-26
# author: Serkan Korkmaz, serkor1@duck.com
# objective: A playground for
# testing various elements of the
# library
# script start;

# setup
rm(list = ls()); gc(); devtools::load_all()


nrow(
 BTC <-  get_quote(
    ticker = "BTCUSDT",
    source = "bybit",
    to     = Sys.Date() - 1,
    futures = FALSE
  )
)





index <- zoo::index(BTC)

length(
  seq(
    from = index[1],
    to   = index[length(index)],
    by   = "1 day"
  )
)



length(
  seq(
    from = Sys.Date() - 199,
    to   = Sys.Date(),
    by   = "1 day"
  )
)


Sys.Date() - (Sys.Date() - 200)



chart(
  ticker = BTC,
  main = kline()
)


chart(
  ticker = BTC,
  main = ohlc()
)


to_title <- function(
    x) {

  gsub("\\b(.)", "\\U\\1", tolower(x), perl = TRUE)
}





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
