# script:
# date: 2023-10-06
# author: Serkan Korkmaz, serkor1@duck.com
# objective:
# script start;

# available intervals
# at kucoin futures market
cryptoQuotes::availableIntervals(
  source = 'kucoin',
  futures = TRUE
)

# available intervals
# at kraken spot market
cryptoQuotes::availableIntervals(
  source = 'kraken',
  futures = FALSE
)

# script end;
