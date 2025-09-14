# testing quotes;
#
# The internal test data, is the last known validated
# data before any major overhauls to the functions.
# expect no errors; ####
#
# Why wouldn't you?
testthat::test_that(desc = "All get_quote()-functions returns the expected values and lengths", code = {
  # 0) skip if offline
  # and on github
  testthat::skip_if_offline()
  testthat::skip_on_ci()

  # 1) create a vector
  # of available exchanges
  exchanges <- c(
    'binance',
    'bitmart',
    'bybit',
    'kraken',
    'kucoin',
    "crypto.com",
    "mexc",
    "huobi"
  )

  # 2) start loop
  for (exchange in exchanges) {
    # 1) for each exchange we test
    # two markets
    markets <- c("spot", "futures")

    for (market in markets) {
      # 3) set logical
      futures <- as.logical(
        market == "futures"
      )

      if (futures) {
        ticker <- switch(
          exchange,
          "binance" = "BTCUSDT",
          "bybit" = "BTCUSDT",
          "bitmart" = "ETHUSDT",
          "kraken" = "PF_XBTUSD",
          "kucoin" = "XBTUSDTM",
          "crypto.com" = "BTCUSD-PERP",
          "mexc" = "BTC_USDT",
          "huobi" = "BTC-USDT"
        )
      } else {
        ticker <- switch(
          exchange,
          "binance" = "BTCUSDT",
          "bybit" = "BTCUSDT",
          "bitmart" = "ETH_USDT",
          "kraken" = "XBTUSDT",
          "kucoin" = "BTC-USDT",
          "crypto.com" = "BTC_USDT",
          "mexc" = "BTCUSDT",
          "huobi" = "btcusdt"
        )
      }

      # 2) for each market we
      # test two intervals
      suppressMessages(
        intervals <- available_intervals(
          source = exchange,
          futures = futures
        )
      )

      for (interval in intervals) {
        error_label <- paste(
          "Error in get_quote for",
          exchange,
          "in",
          market,
          "with interval:",
          interval
        )

        output <- try(
          get_quote(
            ticker = ticker,
            source = exchange,
            interval = interval,
            futures = futures
          )
        )

        # 1) Return quote on
        # from exchanges
        testthat::expect_false(
          object = inherits(
            x = output,
            what = "try-error"
          ),
          label = paste(error_label, "(Test 0)")
        )

        # 2) test wether the
        # ohlc is logical
        testthat::expect_true(
          all(
            output$high >= output$low,
            output$open >= output$low,
            output$open <= output$high,
            output$close >= output$low,
            output$close <= output$high
          ),
          label = paste(error_label, "(Test 1)")
        )

        testthat::expect_true(
          setequal(
            x = infer_interval(output),
            y = interval
          ),
          label = paste(error_label, "(Expected Interval)")
        )
        # 2) check if the returned
        # quote is 100 +/-
        testthat::expect_equal(
          object = nrow(output),
          tolerance = 1,
          expected = 200,
          label = paste(error_label, "(Test 2)")
        )

        # 3) test if dates are reasonable
        # within range
        date_range <- as.numeric(
          format(
            range(
              zoo::index(output)
            ),
            format = "%Y"
          )
        )

        testthat::expect_true(
          object = all(
            min(date_range) >= 2000,
            max(date_range) <= as.numeric(format(Sys.Date(), "%Y"))
          ),
          label = paste(error_label, "(Test 3)")
        )

        # 4) test that the inferred interval
        # corresponds to the passed interval
        testthat::expect_true(
          setequal(
            interval,
            cryptoQuotes:::infer_interval(
              output
            )
          )
        )
      }
    }
  }
})
