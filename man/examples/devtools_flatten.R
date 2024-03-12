# script: flattten
# date: 2024-03-03
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Give an example
# of the flatten-function
# script start;

# 1) create a nested list
nested_list <- list(
  a = 1,
  b = list(
    c = 2,
    d = 3
  )
)

# 2) flatten the
# nested list
cryptoQuotes:::flatten(
  nested_list
)


# script end;
