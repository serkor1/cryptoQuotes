# testing quotes;
#
# The internal test data, is the last known validated
# data before any major overhauls to the functions.
# expect no errors; ####
#
# Why wouldn't you?
testthat::test_that(
  desc = 'Check if Binance API returns data correctly',
  code = {

    # 0) skip if offline;
    testthat::skip_if_offline()

    # 1) we skip tests on github
    # as these fails automatically
    testthat::skip_on_ci()

    futures <- c(TRUE,FALSE)
    ticker  <- c('BTCUSDT', 'BTCUSDT')

    # 2) run tests via
    # lapply and force a fail
    # to see what happens
    for (i in 1:2) {

      # 1) get quote without errors
      # and store
      testthat::expect_no_error(
        returned_quote <- get_quote(
          ticker = ticker[i],
          source = 'binance',
          futures = futures[i],
          interval = "15m",
          to = Sys.Date() - 1
        )
      )

      # 2) check if the returned
      # quote is 100 +/-
      testthat::expect_equal(
        object = nrow(returned_quote),
        tolerance = 1,
        expected = 200
      )

      # 3) expect that the years
      # are between 2000 and current year
      year_range <- as.numeric(
        format(
        range(
          zoo::index(returned_quote)
          ),
        format = "%Y"
        )
        )

      # 3.1) The minium year
      # has to be greater than 2000
      testthat::expect_gte(
        min(year_range),
        expected = 2000
      )

      # 3.2) The maximum
      # year has to be less than the
      # current system year.
      testthat::expect_lte(
        min(year_range),
        expected = as.numeric(
          format(Sys.Date(), '%Y'))
      )


      # 3.3 Check if all values
      # makes sense. This is important
      # to check for any breaking code changes
      testthat::expect_true(
        all(
          returned_quote$High >= returned_quote$Low,
          returned_quote$Open >= returned_quote$Low & returned_quote$Open <= returned_quote$High,
          returned_quote$Close >= returned_quote$Low & returned_quote$Close <= returned_quote$High
        )

      )



    }

  }
)



testthat::test_that(
  desc = 'Check if Bybit API returns data correctly',
  code = {


    # 0) skip if offline;
    testthat::skip_if_offline()

    # 1) we skip tests on github
    # as these fails automatically
    testthat::skip_on_ci(

    )

    futures <- c(TRUE,FALSE)
    ticker  <- c('BTCUSDT', 'BTCUSDT')

    # 2) run tests via
    # lapply and force a fail
    # to see what happens
    for (i in 1:2) {

      # 1) get quote without errors
      # and store
      testthat::expect_no_error(
        returned_quote <- get_quote(
          ticker = ticker[i],
          source = 'bybit',
          futures = futures[i],
          interval = "15m",
          to = Sys.Date() - 1
        )
      )

      # 2) check if the returned
      # quote is 100 +/-
      testthat::expect_equal(
        object = nrow(returned_quote),
        tolerance = 1,
        expected = 200
      )

      # 3) expect that the years
      # are between 2000 and current year
      year_range <- as.numeric(
        format(
          range(
            zoo::index(returned_quote)
          ),
          format = "%Y"
        )
      )

      # 3.1) The minium year
      # has to be greater than 2000
      testthat::expect_gte(
        min(year_range),
        expected = 2000
      )

      # 3.2) The maximum
      # year has to be less than the
      # current system year.
      testthat::expect_lte(
        min(year_range),
        expected = as.numeric(
          format(Sys.Date(), '%Y'))
      )


      # 3.3 Check if all values
      # makes sense. This is important
      # to check for any breaking code changes
      testthat::expect_true(
        all(
          returned_quote$High >= returned_quote$Low,
          returned_quote$Open >= returned_quote$Low & returned_quote$Open <= returned_quote$High,
          returned_quote$Close >= returned_quote$Low & returned_quote$Close <= returned_quote$High
        )

      )



    }

  }
)



testthat::test_that(
  desc = 'Check if Kucoin API returns data correctly',
  code = {


    # 0) skip if offline;
    testthat::skip_if_offline()

    # 1) we skip tests on github
    # as these fails automatically
    testthat::skip_on_ci(

    )

    futures <- c(TRUE,FALSE)
    ticker  <- c('XBTUSDTM', 'BTC-USDT')

    # 2) run tests via
    # lapply and force a fail
    # to see what happens
    for (i in 1:2) {

      # 1) get quote without errors
      # and store
      testthat::expect_no_error(
        returned_quote <- get_quote(
          ticker = ticker[i],
          source = 'kucoin',
          futures = futures[i],
          interval = "15m",
          to = Sys.Date() - 1
        )
      )

      # 2) check if the returned
      # quote is 100 +/-
      testthat::expect_equal(
        object = nrow(returned_quote),
        tolerance = 1,
        expected = 200
      )

      # 3) expect that the years
      # are between 2000 and current year
      year_range <- as.numeric(
        format(
          range(
            zoo::index(returned_quote)
          ),
          format = "%Y"
        )
      )

      # 3.1) The minium year
      # has to be greater than 2000
      testthat::expect_gte(
        min(year_range),
        expected = 2000
      )

      # 3.2) The maximum
      # year has to be less than the
      # current system year.
      testthat::expect_lte(
        min(year_range),
        expected = as.numeric(
          format(Sys.Date(), '%Y'))
      )


      # 3.3 Check if all values
      # makes sense. This is important
      # to check for any breaking code changes
      testthat::expect_true(
        all(
          returned_quote$High >= returned_quote$Low,
          returned_quote$Open >= returned_quote$Low & returned_quote$Open <= returned_quote$High,
          returned_quote$Close >= returned_quote$Low & returned_quote$Close <= returned_quote$High
        )

      )



    }

  }
)


testthat::test_that(
  desc = 'Check if Bitmart API returns data correctly',
  code = {


    # 0) skip if offline;
    testthat::skip_if_offline()

    # 1) we skip tests on github
    # as these fails automatically
    testthat::skip_on_ci(

    )

    futures <- c(TRUE,FALSE)
    ticker  <- c('BTCUSDT', 'BTC_USDT')

    # 2) run tests via
    # lapply and force a fail
    # to see what happens
    for (i in 1:2) {

      # 1) get quote without errors
      # and store
      testthat::expect_no_error(
        returned_quote <- get_quote(
          ticker = ticker[i],
          source = 'bitmart',
          futures = futures[i],
          interval = "15m",
          to = Sys.Date() - 1
        )
      )

      # 2) check if the returned
      # quote is 100 +/-
      testthat::expect_equal(
        object = nrow(returned_quote),
        tolerance = 1,
        expected = 200
      )

      # 3) expect that the years
      # are between 2000 and current year
      year_range <- as.numeric(
        format(
          range(
            zoo::index(returned_quote)
          ),
          format = "%Y"
        )
      )

      # 3.1) The minium year
      # has to be greater than 2000
      testthat::expect_gte(
        min(year_range),
        expected = 2000
      )

      # 3.2) The maximum
      # year has to be less than the
      # current system year.
      testthat::expect_lte(
        min(year_range),
        expected = as.numeric(
          format(Sys.Date(), '%Y'))
      )

      # 3.3 Check if all values
      # makes sense. This is important
      # to check for any breaking code changes
      testthat::expect_true(
        all(
          returned_quote$High >= returned_quote$Low,
          returned_quote$Open >= returned_quote$Low & returned_quote$Open <= returned_quote$High,
          returned_quote$Close >= returned_quote$Low & returned_quote$Close <= returned_quote$High
        )

      )



    }

  }
)

testthat::test_that(
  desc = 'Check if Kraken API returns data correctly',
  code = {


    # 0) skip if offline;
    testthat::skip_if_offline()

    # 1) we skip tests on github
    # as these fails automatically
    testthat::skip_on_ci(

    )

    futures <- c(TRUE,FALSE)
    ticker  <- c('PF_XBTUSD', 'XBTUSDT')

    # 2) run tests via
    # lapply and force a fail
    # to see what happens
    for (i in 1:2) {

      # 1) get quote without errors
      # and store
      testthat::expect_no_error(
        returned_quote <- get_quote(
          ticker = ticker[i],
          source = 'kraken',
          futures = futures[i],
          interval = "15m",
          to = Sys.Date() - 1
        )
      )

      # 2) check if the returned
      # quote is 100 +/-
      testthat::expect_equal(
        object = nrow(returned_quote),
        tolerance = 1,
        expected = 200
      )

      # 3) expect that the years
      # are between 2000 and current year
      year_range <- as.numeric(
        format(
          range(
            zoo::index(returned_quote)
          ),
          format = "%Y"
        )
      )

      # 3.1) The minium year
      # has to be greater than 2000
      testthat::expect_gte(
        min(year_range),
        expected = 2000
      )

      # 3.2) The maximum
      # year has to be less than the
      # current system year.
      testthat::expect_lte(
        min(year_range),
        expected = as.numeric(
          format(Sys.Date(), '%Y'))
      )


      # 3.3 Check if all values
      # makes sense. This is important
      # to check for any breaking code changes
      testthat::expect_true(
        all(
          returned_quote$High >= returned_quote$Low,
          returned_quote$Open >= returned_quote$Low & returned_quote$Open <= returned_quote$High,
          returned_quote$Close >= returned_quote$Low & returned_quote$Close <= returned_quote$High
        )

      )



    }

  }
)
