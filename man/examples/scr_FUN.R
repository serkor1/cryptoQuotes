# script: scr_FUN
# date: 2023-12-27
# author: Serkan Korkmaz, serkor1@duck.com
# objective: Demonstrate the use of the convinience
# funtions
# script start;

# by default the Fear and Greed Index
# is given daily. So to align these values
# with, say, weekly candles it has to be aggregated
#
# In this example the built-in data are used

# 1) check index of BTCUSDT and
# the Fear and Greed Index
setequal(
  zoo::index(BTCUSDT),
  zoo::index(FGIndex)
)

# 2) to align the indices,
# we use the convincience functions
# by splitting the FGI by the BTC index.
FGIndex <- splitWindow(
  xts = FGIndex,
  by  = zoo::index(BTCUSDT),

  # Remove upper bounds of the
  # index to avoid overlap between
  # the dates.
  #
  # This ensures that the FGI is split
  # according to start of each weekly
  # BTC candle
  bounds = 'upper'
)

# 3) as splitWindow returns a list
# it needs to passed into calibrateWindow
# to ensure comparability
FGIndex <- calibrateWindow(
  list = FGIndex,

  # As each element in the list can include
  # more than one row, each element needs to be aggregated
  # or summarised.
  #
  # using xts::first gives the first element
  # of each list, along with its values
  FUN  = xts::first
)


# 3) check if candles aligns
# accordingly
setequal(
  zoo::index(BTCUSDT),
  zoo::index(FGIndex)
)


# As the dates are now aligned
# and the Fear and Greed Index being summarised by
# the first value, the Fear and Greed Index is the opening
# Fear and Greed Index value, at each candle.

# script end;
