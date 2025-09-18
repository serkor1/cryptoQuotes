testthat::test_that(desc = "Test that the convinience functions calibrates the data correctly", code = {
  testthat::expect_false(
    setequal(
      zoo::index(FGIndex),
      zoo::index(BTC)
    )
  )

  # 2) to align the indices,
  # we use the convincience functions
  # by splitting the FGI by the BTC index.
  FGIndex <- split_window(
    xts = FGIndex,
    by = zoo::index(BTC),

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
  FGIndex <- calibrate_window(
    list = FGIndex,

    # As each element in the list can include
    # more than one row, each element needs to be aggregated
    # or summarised.
    #
    # using xts::first gives the first element
    # of each list, along with its values
    FUN = xts::first
  )

  # 3) check if candles aligns
  # accordingly
  testthat::expect_equal(
    zoo::index(BTC),
    zoo::index(FGIndex)
  )
})
