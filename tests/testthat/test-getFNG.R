testthat::test_that(
  desc = "getFNG returns 200 values",
  code = {

    # 0) skip if online;
    testthat::skip_if_offline()

    # 1) skip on github
    testthat::skip_on_ci()

    # 2) load FGI
    FGI <- get_fgindex(
      to = Sys.Date() - 1
      )

    # 3) test that its an
    # xts object
    testthat::expect_true(
      object = rlang::inherits_any(
        x = FGI,
        class = c('xts')
      )
    )

    # 4) check that it returns
    # 100 rows
    testthat::expect_equal(
      object   = nrow(FGI),
      expected = 200
    )

  }
)

