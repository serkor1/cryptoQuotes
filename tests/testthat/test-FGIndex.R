# script: test-FGIndex
# author: Serkan Korkmaz, serkor1@duck.com
# date: 2024-05-24
# objective: Test that the Fear and Greed index gets
# returned correctly
# script start;

# script end;
testthat::test_that(
  desc = "Fear and Greed Index get returned correcty",
  code = {

    # 0) skip if offline
    testthat::skip_if_offline()

    # 1) fetch Fear and Greed Index
    testthat::expect_no_condition(
      output <- cryptoQuotes::get_fgindex(
        from = Sys.Date() - 7,
        to   = Sys.Date()
      )
    )

    # 2) test if dates are reasonable
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
      )
    )
})
