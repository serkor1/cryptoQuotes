# testing quotes;
#
# The internal test data, is the last known validated
# data before any major overhauls to the functions.
# expect no errors; ####
#
# Why wouldn't you?
testthat::test_that(
  desc = "All get_quote()-functions returns the expected values and lengths",
  code = {

    # 0) skip if offline
    # and on github
    testthat::skip_if_offline(); testthat::skip_on_ci()

    # 1) create a vector
    # of available exchanges
    exchanges <- c(
      'binance',
      'bitmart',
      'bybit',
      'kraken',
      'kucoin'
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
            "bybit"   = "BTCUSDT",
            "bitmart" = "BTCUSDT",
            "kraken"  = "PF_XBTUSD",
            "kucoin"  = "XBTUSDTM"
          )

        } else {

          ticker <- switch(
            exchange,
            "binance" = "BTCUSDT",
            "bybit"   = "BTCUSDT",
            "bitmart" = "BTC_USDT",
            "kraken"  = "XBTUSDT",
            "kucoin"  = "BTC-USDT"
          )

        }

        # 2) for each market we
        # test two intervals
        intervals <- c("1d", "1h")

        for (interval in intervals) {

          error_label <- paste(
            "Error in get_quote for",
            exchange,
            "in",
            market,
            "with interval:",
            interval
          )

          # 1) Return quote on
          # from exchanges
          testthat::expect_no_condition(
            output <- get_quote(
              ticker   = ticker,
              source   = exchange,
              interval = interval,
              futures  = futures
            ),
            message = error_label
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
            label = error_label
          )

          # 2) check if the returned
          # quote is 100 +/-
          testthat::expect_equal(
            object = nrow(output),
            tolerance = 1,
            expected = 200,
            label = error_label
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
            label = error_label
          )


        }

      }

    }

  }
)
