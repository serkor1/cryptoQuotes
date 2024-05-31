# script: test open interest
# date: 2024-03-01
# author: Serkan Korkmaz, serkor1@duck.com
# objective: These will be skipped
# on CRAN and Github
# script start;

testthat::test_that(
  desc = "Open-interest returns data as expected",
  code = {

    # Pre-calculate dates
    start_date <- Sys.Date() - 3
    end_date <- Sys.Date() - 1
    current_year <- as.numeric(format(Sys.Date(), '%Y'))

    # 0) Define available exchanges
    exchanges <- suppressMessages(available_exchanges(type = "interest"))

    # 1) skip if offline and on github
    testthat::skip_if_offline()
    testthat::skip_on_ci()

    for (exchange in exchanges) {
      error_label <- exchange

      # Run without any errors
      testthat::expect_no_condition(
        output <- get_openinterest(
          ticker = cryptoQuotes::available_tickers(
            source = exchange,futures = TRUE
          )[50],
          source = exchange,
          interval = '1h',
          from = start_date,
          to = end_date
        ),message = error_label
      )

      # Check if interval is equal to input interval
      testthat::expect_equal(
        object = infer_interval(output),
        expected = '1h',
        label = error_label
      )

      # Check year range
      year_range <- as.numeric(format(range(zoo::index(output)), "%Y"))

      # The minimum year has to be greater than 2000
      testthat::expect_gte(
        min(year_range), expected = 2000, label = error_label
        )

      # The maximum year has to be less than the current system year.
      testthat::expect_lte(
        max(year_range), expected = current_year, label = error_label
        )
    }
  }
)


# script end;


