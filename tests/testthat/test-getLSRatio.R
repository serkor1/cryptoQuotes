# testing quotes;
#
# The internal test data, is the last known validated
# data before any major overhauls to the functions.
# expect no errors; ####
#
# Why wouldn't you?
testthat::test_that(desc = 'Test that the LSR ratio is returned as expected', code = {
  # 0) Define available
  # exchnages
  testthat::expect_no_error(
    exchanges <- suppressMessages(
      available_exchanges(
        type = "lsratio"
      )
    )
  )

  # 1) skip if offline
  # and on github
  testthat::skip_if_offline()
  testthat::skip_on_ci()

  # 2) set fixed dates;
  from <- Sys.Date() - 1
  to <- Sys.Date()

  for (exchange in exchanges) {
    # 2) Define ticker
    ticker <- switch(
      exchange,
      "binance" = "BTCUSDT",
      "bybit" = "BTCUSDT",
      "bitmart" = "BTCUSDT",
      "kraken" = "PF_XBTUSD",
      "kucoin" = "XBTUSDTM"
    )

    # 1) get quote without errors
    # and store
    testthat::expect_no_condition(
      output <- get_lsratio(
        ticker = ticker,
        source = exchange,
        interval = "1h",
        from = from,
        to = to
      ),
      message = paste("Error for:", exchange)
    )

    # 2) expect that the number of
    # rows returned are as passed to the
    # function
    testthat::expect_equal(
      object = nrow(output),
      tolerance = 1,
      expected = 25,
      label = paste("Error for:", exchange)
    )

    # 3) expect that the years
    # are between 2000 and current year
    year_range <- as.numeric(
      format(
        range(
          zoo::index(output)
        ),
        format = "%Y"
      )
    )

    # 3.1) The minium year
    # has to be greater than 2000
    testthat::expect_gte(
      min(year_range),
      expected = 2000,
      label = paste("Error for:", exchange)
    )

    # 3.2) The maximum
    # year has to be less than the
    # current system year.
    testthat::expect_lte(
      min(year_range),
      expected = as.numeric(
        format(Sys.Date(), '%Y')
      ),
      label = paste("Error for:", exchange)
    )
  }
})
